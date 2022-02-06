class Api::RatingsController < ApplicationController
  before_action :set_contact
  before_action :set_rating, only: ["update"]

  def create
    @rating = @contact.ratings.new :value => params[:value]
    if @rating.save
      render json: {message: "Added star successfully"}, status: :created
    else
      render json: @rating.errors, status: :bad_request
    end
  end

  def update
    if @rating.update_attribute(:value, params[:value])
      render json: @rating, status: :ok
    else
      # code
      render json: @rating.errors, status: :bad_request
    end
  end

  private
  def set_contact
    @contact = Contact.find_by(id: params[:contact_id])
  end

  def set_rating
    @rating = Rating.find_by(id: params[:id])
  end

  def rating_params
    params.permit(:id, :contact_id, :value)
  end
end
