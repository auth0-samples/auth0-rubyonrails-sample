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
