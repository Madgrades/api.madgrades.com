OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           '296091512443-qv3h8f15emcch9m83nbdc3l5qv716nae.apps.googleusercontent.com',
           'enpzfTWOX2uQ5tv5DKK4z9qg',
           {
               prompt: 'select_account'
           }

  provider :github,
           'b989e6efaa5d026d1beb',
           '5c35717a1fd3e4cbe5bf1400b964742e3f912736',
           {
               prompt: 'select_account'
           }
end