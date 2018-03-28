class DashboardController < ApplicationController
  def index
    @top_companies = Company.top_companies_by_interest
    @top_company_ids = @top_companies.map do |company|
                          Company.find_by(name: company.name)
                        end
    @jobs = Job.all
    @job_locations = Job.group_by_location
  end
end
