class Person < ActiveRecord::Base
  validates_uniqueness_of :user_id
  has_many :applications

  def self.editable_attributes
    [:first_name, :last_name]
  end

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first
    user ? user.update_auth_attrs(auth) : create_with_auth(auth)
  end

  def update_auth_attrs(auth)
    update_attributes(
      provider: auth.provider,
      uid: auth.uid,
      first_name: auth.info.name,
      oauth_token: auth.credentials.token
    )
    self
  end

  def self.create_with_auth(auth)
      create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.first_name = auth.info.name
        user.oauth_token = auth.credentials.token
        user.save!
      end
    end
end
