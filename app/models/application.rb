class Application < ActiveRecord::Base
  validates_presence_of :company
  validates :status, inclusion: { in: %w(to_apply in_progress applied closed) }
  belongs_to :person
  has_many :steps

  def self.application_search(type)
    where(status: type).order(:company)
  end
end
