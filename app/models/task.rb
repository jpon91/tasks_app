class Task < ActiveRecord::Base
  attr_accessible :description, :priority
  validates_presence_of :description
  validates :priority, numericality: {greater_than: 0}
  validates_uniqueness_of :description
  before_validation :clean_description

  private
	def clean_description
		if self.description.present?
			self.description.strip.capitalize!
		end
	end
end
