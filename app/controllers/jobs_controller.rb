class JobsController < ApplicationController
  before_action :set_job, only: [:show, :destroy, :edit, :update]


  def index
    @company = Company.find(params[:company_id])
    @jobs = @company.jobs
  end

  def new
    @company = Company.find(params[:company_id])
    @job = Job.new
  end

  def create
    @company = Company.find(params[:company_id])
    @job = @company.jobs.new(job_params)
    if @job.save
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      redirect_to company_job_path(@company, @job)
    else
      render :new
    end
  end

  def show
    @company = @job.company
    @comment = Comment.new
    @comment.job_id = @job.id
  end

  def edit
    @company = @job.company
  end

  def update
    @company = @job.company
    @job.update(job_params)
    if @job.save
      flash[:success] = "#{@job.title} updated!"
      redirect_to company_job_path(@company, @job)
    else
      render :edit
    end
  end

  def destroy
    @job.destroy

    flash[:success] = "#{@job.title} was successfully deleted!"
    redirect_to companies_path
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :category_id)
  end

  def set_job
    @job = Job.find(params[:id])
  end
end
