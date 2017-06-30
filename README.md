# Auth0 + Ruby on Rails WebApp Seed + Samples
This project goal is to help integrating Auth0 capabilities in your Ruby on Rails application.

You can learn more about the seed project and samples in the [Auth0 Rails quickstart](https://auth0.com/docs/quickstart/webapp/rails).

### Troubleshooting issues

1) If you receive the following error, on Mac:

```
An error occurred while installing pg (0.19.0), and Bundler cannot continue.
Make sure that `gem install pg -v '0.19.0'` succeeds before bundling.
```

Try running the following commands:

1. `brew update`
2. `brew install postgresql`
3. `gem install pg`
4. Then go back to the project and run: `bundle install`

2) If you receive the following error, on Mac:

```
An error occurred while installing nokogiri (1.7.0.1), and Bundler cannot
continue.
Make sure that `gem install nokogiri -v '1.7.0.1'` succeeds before bundling.
```

Simply run:

```
gem install nokogiri -- --use-system-libraries=true --with-xml2-include=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/libxml2/
```

More info, [here](http://stackoverflow.com/questions/24251494/nokogiri-gem-installation-error).

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

[Auth0](auth0.com)

## License

This project is licensed under the MIT license. See the [LICENSE](LICENSE.txt) file for more info.
