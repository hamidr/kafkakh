class OptionController < ApplicationController
  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def create
    param! :poll_id, Integer, required: true
    param! :title, String, required: true

    poll_id = params[:poll_id]
    title = params[:title]

    render json: Option.create!(title: title, poll_id: poll_id)
  end

  def create_multiple
    param! :poll_id, Integer, required: true
    param! :titles, Array, required: true do |array, index|
      array.param! index, String, required: true
    end

    render json: Option.create_many!(params[:poll_id], params[:titles])
  end

  def delete
  end
  
  def edit
  end
end
