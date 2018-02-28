class User < ApplicationRecord
  has_many :identities, dependent: :destroy

  before_create :set_api_token

  def self.find_with_omniauth(info)
    find_by(email: info['email'])
  end

  def self.create_with_omniauth(info)
    create(name: info['name'], email: info['email'])
  end

  def update_with_omniauth(info)
    update(email: info['email'])
  end

  def regenerate_api_token
    update(api_token: User.generate_api_token)
  end

  private
    def self.generate_api_token
      SecureRandom.uuid.gsub(/\-/,'')
    end

    def set_api_token
      return if api_token.present?
      self.api_token = User.generate_api_token
    end
end
