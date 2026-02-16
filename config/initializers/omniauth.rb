OmniAuth.config.logger = Rails.logger

# OmniAuth 2.x changed default allowed request methods from [:get, :post] to [:post] for security.
# We need to explicitly allow GET requests for the initial /auth/:provider redirect to work.
# Note: omniauth-rails_csrf_protection gem provides CSRF protection for POST requests.
# For production, consider updating links to use POST with button_to instead of link_to.
OmniAuth.config.allowed_request_methods = [:get, :post]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
           ENV['GITHUB_KEY'],
           ENV['GITHUB_SECRET'],
           scope: "user"
end
