class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "#{@category.title} added!"
      redirect_to categories_path
    else
      flash[:error] = 'Sorry, that category name already exists!'
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end
end
