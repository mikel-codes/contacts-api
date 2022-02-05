class Api::ContactsController < ApplicationController
  before_action :set_current_user
  before_action :set_contact, only: ["show", "update", "destroy"]

  def index
    contacts = Contact.where(owner: @current_user)
    render json: {contacts: contacts}, status: 200
  end

  def show
    render json: {contact: @contact}, status: :ok
  end

  def update
    if @contact.update! contact_params
      render json: @contact, status: :ok
    else
      render json: @contact.errors, status: :bad_request
    end
  end

  def destroy
    @contact.destroy
    head :no_content
  end

  def create
    contact = Contact.new contact_params
    contact[:user_id] = @current_user.id
    if contact.valid?
      contact.save
      render json: contact, status: :created
    else
      render json: contact.errors, status: :bad_request
    end
  end

  private

  def set_contact
    @contact ||= begin
			contact_id = params[:id].presence
			Contact.find_by(id: contact_id, owner: @current_user) if contact_id
		end
    unless @contact  then head :not_found end
  end

  def contact_params
    #these params works at the db_level so :user_id used instead of owner
    params.permit(:user_id, :name, :phone, :description)
  end

end
