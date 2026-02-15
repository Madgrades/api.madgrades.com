class Rack::Attack
  # Throttle requests from IP to 150 per minute
  throttle('req/ip', limit: 150, period: 60) do |req|
    req.ip
  end

  # Allow all other requests
  safelist('allow all') { |req| true }
end
