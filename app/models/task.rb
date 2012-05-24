class Task < ActiveRecord::Base
  attr_accessible :description, :priority, :user_id
  validates_presence_of :description, :user_id
  validates :priority, numericality: {greater_than: 0}
  validates_uniqueness_of :description
  before_validation :clean_description
  belongs_to :user

  private
	def clean_description
		if self.description.present?
			self.description.strip.capitalize!
		end
	end
end
