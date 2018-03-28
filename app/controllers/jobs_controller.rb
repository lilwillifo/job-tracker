class JobsController < ApplicationController
  before_action :set_job, only: [:show, :destroy, :edit, :update]

  def index
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @jobs = @company.jobs
    elsif params[:location]
      @jobs = Job.where(city: params[:location])
      @location = params[:location]
    elsif params[:sort]
      @jobs = Job.sort(params[:sort])
    else
      @jobs = Job.order(:title)
    end
  end

  def new
    @company = Company.find(params[:company_id]) if params[:company_id]
    @job = Job.new
  end

  def create
    @job = Job.create(job_params)
    if @job.save
      flash[:success] = "You created #{@job.title} at #{@job.company.name}"
      redirect_to jobs_path
    else
      flash[:error] = "Try again! Please fill in all the fields."
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
    @job.company.destroy if @job.company.jobs.length == 1

    @job.destroy

    flash[:success] = "#{@job.title} was successfully deleted!"
    redirect_to jobs_path
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :category_id, :company_id)
  end

  def set_params
    params.permit(:sort)
  end

  def set_job
    @job = Job.find(params[:id])
  end
end
