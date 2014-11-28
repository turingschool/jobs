class Application < ActiveRecord::Base
  validates_presence_of :company

  has_many :steps
end
