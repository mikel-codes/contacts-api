class Api::ContactsController < ApplicationController
  before_action :set_current_user
  before_action :set_contact, only: ["show", "update"]

  def index
    contacts = Contact.where(owner: @current_user)
    render json: {contacts: contacts}, status: 200
  end

  def show
    render json: {contact: @contact}, status: :ok
  end

  def update
  end

  def destroy
  end

  def new
  end

  def create
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
    params.permit(:owner, :name, :phone, :description)
  end

end
