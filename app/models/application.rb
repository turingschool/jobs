class Application < ActiveRecord::Base
  validates_presence_of :company
  validates_presence_of :status

  has_many :steps

  def self.statuses
    %W(open waiting dead icebox offered)
  end
end
