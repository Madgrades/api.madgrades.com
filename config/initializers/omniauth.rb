OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           ENV['GOOGLE_KEY'],
           ENV['GOOGLE_SECRET'],
           {
               prompt: 'select_account'
           }

  provider :github,
           ENV['GITHUB_KEY'],
           ENV['GITHUB_SECRET'],
           {
               prompt: 'select_account'
           }
end
