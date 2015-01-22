class Person < ActiveRecord::Base
  # validates_uniqueness_of :user_id
  has_many :applications

  def self.editable_attributes
    [:first_name, :last_name]
  end

  def self.find_or_create_user_from(auth)
    Rails.logger.info("got omniauth auth data: #{auth.inspect}")
    person = find_or_create_by(provider: auth.provider, uid: auth.uid)

    person.provider     = auth.provider
    person.uid          = auth.uid
    person.first_name   = auth.info.name
    person.oauth_token  = auth.credentials.token
    person.save

    person
  end
end
