class Application < ActiveRecord::Base
  validates_presence_of :company

  has_many :steps

  def self.statuses
    %W(open waiting dead icebox offered)
  end
end
