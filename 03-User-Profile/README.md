# User Profile
[Full Tutorial](https://auth0.com/docs/quickstart/webapp/rails/04-user-profile)

This example shows how to retrieve an Auth0 user’s profile ([normalized and full](https://auth0.com/docs/user-profile/user-profile-details)) in a Rails application using OmniAuth.

## Running the Sample Application

In order to run the example you need to have ruby installed.

Register `http://localhost:3000/auth/auth0/callback` as `Allowed Callback URLs` in your client setting in [Auth0's dashboard](https://manage.auth0.com/#/).

You also need to set the ClientSecret, ClientId, Domain, CallbackURL and Audience for your Auth0 app as environment variables with the following names respectively: `AUTH0_CLIENT_SECRET`, `AUTH0_CLIENT_ID`, `AUTH0_DOMAIN`, `AUTH0_CALLBACK_URL` and `AUTH0_AUIDIENCE`.

__Note:__ If you are not implementing any API, leave this variable empty.

Set the environment variables in `.env` to match those your Auth0 Client.

````bash
# .env file
AUTH0_CLIENT_ID=YOUR_CLIENT_ID
AUTH0_CLIENT_SECRET=YOUR_CLIENT_SECRET
AUTH0_DOMAIN=<YOUR_TENANT>.auth0.com
AUTH0_CALLBACK_URL=http://localhost:3000/auth/auth0/callback
AUTH0_AUDIENCE=YOUR_API_IDENTIFIER
````
Once you've set those 5 environment variables, run `bundle install` and then `rails s`. Now, browse [http://localhost:3000/](http://localhost:3000/).
__Note:__ Remember that you need to have `./bin` in your path for `rails s` to work.

Shut it down manually with Ctrl-C.

__Note:__ If you are using Windows, uncomment the `tzinfo-data` gem in the gemfile.

## Running the Sample Application With Docker
In order to run the example you need to have `docker` installed.

You also need to set the environment variables as explained [previously](#running-the-sample-application).

Execute in command line `sh exec.sh` to run the Docker in Linux, or `.\exec.ps1` to run the Docker in Windows.

## What is Auth0?

Auth0 helps you to:

* Add authentication with [multiple authentication sources](https://docs.auth0.com/identityproviders), either social like **Google, Facebook, Microsoft Account, LinkedIn, GitHub, Twitter, Box, Salesforce, amont others**, or enterprise identity systems like **Windows Azure AD, Google Apps, Active Directory, ADFS or any SAML Identity Provider**.
* Add authentication through more traditional **[username/password databases](https://docs.auth0.com/mysql-connection-tutorial)**.
* Add support for **[linking different user accounts](https://docs.auth0.com/link-accounts)** with the same user.
* Support for generating signed [Json Web Tokens](https://docs.auth0.com/jwt) to call your APIs and **flow the user identity** securely.
* Analytics of how, when and where users are logging in.
* Pull data from other sources and add it to the user profile, through [JavaScript rules](https://docs.auth0.com/rules).

## Create a free Auth0 account

1. Go to [Auth0](https://auth0.com/signup) and click Sign Up.
2. Use Google, GitHub or Microsoft Account to login.

## Issue Reporting

If you have found a bug or if you have a feature request, please report them at this repository issues section. Please do not report security vulnerabilities on the public GitHub issue tracker. The [Responsible Disclosure Program](https://auth0.com/whitehat) details the procedure for disclosing security issues.

## Author

[Auth0](https://auth0.com)

## License

This project is licensed under the MIT license. See the [LICENSE](LICENSE.txt) file for more info.
