# app/controllers/contacts_controller.rb
class ContactsController < ApplicationController
  before_action :set_contact, only: %i[destroy edit update]

  def create
    @contact = Contact.new(contact_params)
    @contact.company_id = params[:company_id]
    if @contact.save
      flash[:success] = "#{@contact.name} added!"
      redirect_to company_path(@contact.company)
    else
      render :new
    end
  end

  def edit; end

  def update
    @company = @contact.company
    @contact.update(contact_params)
    if @contact.save
      flash[:success] = "#{@contact.name} updated!"
      redirect_to company_path(@contact.company)
    else
      render :edit
    end
  end

  def destroy
    @company = Company.find(params[:company_id])
    @contact.destroy
    flash[:success] = "#{@contact.name} was successfully deleted!"
    redirect_to company_path(@company)
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :role, :email, :company_id)
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end
end
