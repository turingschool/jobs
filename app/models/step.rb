class Step < ActiveRecord::Base
  belongs_to :application

  def self.kinds
    %W(feedback code_challenge phone_screen culture_interview technical_interview contracting)
  end
end
