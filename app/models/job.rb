class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  has_many :comments, dependent: :destroy
  belongs_to :category

  def self.count_by_level_of_interest(level_of_interest)
    where(level_of_interest: level_of_interest).count
  end

  def self.group_by_location
    group(:city).count
  end

  def self.sort(string)
    if string == 'location'
      order(:city)
    elsif string == 'interest'
      order(:level_of_interest).reverse
    else
      all
    end
  end
end
