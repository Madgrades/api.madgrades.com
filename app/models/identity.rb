class Identity < ApplicationRecord
  belongs_to :user

  def self.find_with_omniauth(auth)
    find_by(uid: auth['uid'], provider: auth['provider'])
  end

  def self.create_with_omniauth(auth)
    create(provider: auth.provider,
           uid: auth.uid,
           oauth_token: auth.credentials.token)
  end

  def provider_name
    case provider
      when 'github'
        return 'GitHub'
      when 'google_oauth2'
        return 'Google'
      else
        return provider
    end
  end
end
