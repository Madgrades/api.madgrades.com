class User < ApplicationRecord
  has_many :identities, dependent: :destroy

  def self.find_with_omniauth(info)
    find_by(email: info['email'])
  end

  def self.create_with_omniauth(info)
    create(name: info['name'], email: info['email'])
  end
end
