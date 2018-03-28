class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :contacts

  def self.top_companies_by_interest
    select('companies.name, companies.id, avg(jobs.level_of_interest) AS average_level')
      .joins(:jobs)
      .group(:name, :id)
      .order('average_level DESC')
      .limit(3)
  end
end
