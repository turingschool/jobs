class Step < ActiveRecord::Base
  belongs_to :application

  def self.kinds
    %W(feedback)
  end
end
