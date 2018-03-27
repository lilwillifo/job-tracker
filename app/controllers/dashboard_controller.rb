class DashboardController < ApplicationController
  def index
    @top_companies = Company.top_companies_by_interest.reduce(&:name)
  end
end
