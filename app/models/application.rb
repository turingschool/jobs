class Application < ActiveRecord::Base
  validates_presence_of :company
  validates_presence_of :status

  has_many :steps

  def self.statuses
    %W(open waiting dead icebox offered)
  end

  def self.active
    where.not(:status => 'dead').order(:company)
  end

  def self.dead
    where(:status => 'dead').order(:company)
  end
end
