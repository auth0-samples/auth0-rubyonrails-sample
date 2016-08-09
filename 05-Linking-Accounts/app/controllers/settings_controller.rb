# frozen_string_literal: true
class SettingsController < ApplicationController
  include Secured
  include ClientHelper

  attr_accessor :user

  def show
    @user = session[:userinfo]
    @unlink_providers = unlink_providers.keys - [user[:provider]]
    @providers = link_providers - @unlink_providers - [user[:provider]]
  end

  # Used to link the current user with other provider.
  def link_provider
    @user = session[:userinfo]
    link_user = session[:linkuserinfo]
    ClientHelper.client(user).link_user_account(user['uid'], link_with: link_user[:credentials][:id_token])
    redirect_to '/settings', notice: 'Provider succesfully linked.'
  end

  # Used to unlink the current user from a provider.
  def unlink_provider
    @user = session[:userinfo]
    unlink_user_id = unlink_providers[params['unlink_provider']]
    ClientHelper.client(user).unlink_users_account(user['uid'], params['unlink_provider'], unlink_user_id)
    redirect_to '/settings', notice: 'Provider succesfully unlinked.'
  end

  private

  # Used to get the list of user's providers to unlink
  def unlink_providers
    user_info = ClientHelper.client_user(user).user_info
    Hash[user_info['identities'].collect { |identity| [identity['provider'], identity['user_id']] }]
  end

  # Used to get the list of user's providers to link
  def link_providers
    connections = ClientHelper.client_admin.connections
    connections.map do |connection|
      connection['strategy'] if connection['enabled_clients'].include?(Rails.application.secrets.auth0_client_id)
    end.compact
  end
end
