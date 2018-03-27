class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :contacts

  def self.top_companies_by_interest
    select('companies.name, avg(jobs.level_of_interest) AS average_level')
      .joins(:jobs)
      .group(:name)
      .order('average_level DESC')
      .limit(3)
  end

  def average_interest_level
    if self.jobs.average(:level_of_interest)
      self.jobs.average(:level_of_interest).round(1)
    else
      0
    end
  end
end
