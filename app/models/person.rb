class Person < ActiveRecord::Base
  validates_uniqueness_of :user_id
  has_many :applications

  def self.editable_attributes
    [:first_name, :last_name]
  end

  def self.find_or_create_user_from(auth)
    user = find_or_create_by(provider: auth.provider, uid: auth.uid)

    user.provider     = auth.provider
    user.uid          = auth.uid
    user.first_name   = auth.info.name
    user.oauth_token  = auth.credentials.token
    user.save

    user
  end
end
