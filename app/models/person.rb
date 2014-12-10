class Person < ActiveRecord::Base
  validates_uniqueness_of :user_id
  has_many :applications

  def self.editable_attributes
    [:first_name, :last_name]
  end
end
