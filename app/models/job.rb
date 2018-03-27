class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  has_many :comments
  belongs_to :category

  def self.count_by_level_of_interest(level_of_interest)
    Job.where(level_of_interest: level_of_interest).count
  end
end
