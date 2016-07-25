# Auth0 + Ruby on Rails quickstart sample 03 - User Profile
This project corresponds to the Auth0 Rails quickstart step 03 - User Profile. It is comprised of a basic Rails web app able to handle a user login using Auth0 Lock and OmniAuth and displaying the User Profile information.

You can learn more about this sample project in the [Auth0 Rails quickstart](https://auth0.com/docs/quickstart/webapp/rails/03-user-profile).

# Running the Sample Application
In order to run the example you need to have ruby installed.

You also need to set the ClientSecret, ClientId, Domain and CallbackURL for your Auth0 app as environment variables with the following names respectively: `AUTH0_CLIENT_SECRET`, `AUTH0_CLIENT_ID`, `AUTH0_DOMAIN` and `AUTH0_CALLBACK_URL`.

For that, if you just create a file named `.env` in the project directory and set the values as follows, the app will just work:

````bash
# .env file
AUTH0_CLIENT_SECRET=myCoolSecret
AUTH0_CLIENT_ID=myCoolClientId
AUTH0_DOMAIN=samples.auth0.com
AUTH0_CALLBACK_URL=http://localhost:3000/auth/auth0/callback
````
Once you've set those 4 environment variables, run `bundle install` and then `rails s`. Now, browse [http://localhost:3000/](http://localhost:3000/).

__Note:__ If you are using Windows, uncomment the `tzinfo-data` gem in the gemfile.
