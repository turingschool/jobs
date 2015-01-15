
class Application < ActiveRecord::Base
  validates_presence_of :company
  validates_presence_of :status
  validates_presence_of :url

  has_many :steps

  def self.statuses
    %w(to-apply in-progress applied closed )
  end

  def self.to_apply
    where(status: "to-apply").order(:company)
  end

  def self.in_progress
    where(status: "in-progress").order(:company)
  end

  def self.applied
    where(status: "applied").order(:company)
  end

  def self.closed
    where(status: "closed").order(:company)
  end
end
