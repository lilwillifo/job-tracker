class DashboardController < ApplicationController
  def index
    @top_companies = Company.top_companies_by_interest
    @jobs = Job.all
    @job_locations = Job.sort_by_location
  end
end
