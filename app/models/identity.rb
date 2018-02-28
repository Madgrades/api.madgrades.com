class Identity < ApplicationRecord
  belongs_to :user

  def self.find_with_omniauth(auth)
    find_by(uid: auth['uid'], provider: auth['provider'])
  end

  def self.create_with_omniauth(auth)
    create(provider: auth.provider,
           uid: auth.uuid,
           oauth_token: auth.credentials.token)
  end
end
