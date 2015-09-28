class PollController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  skip_before_filter :verify_authenticity_token, except: :index

  def index
    param! :id, Integer, required: true

    id = params[:id]
    poll = Poll.find_pub_by_id!(id)
    Poll.increment_counter(:view_count, id)

    total_votes = 0
    options = poll.options.order(:order)
    votes = Vote.where(poll_id: poll.id).group(:option_id).count

    @poll = poll.attributes

    if user_signed_in?
      @poll[:signed_in] = true 
      voted_to = current_user.votes.find_by(poll_id: poll.id) 
      @poll[:voted_to] = voted_to.option_id if !voted_to.nil?
    end

    @poll[:options] = options.map do |opt|
      option = opt.attributes
      total_votes += option[:count] = votes[opt.id].to_i
      option
    end
    @poll[:total_votes] = total_votes
  end

  def create
    title =           param! :title, String, required: true
    description =     param! :description, String, required: false 

    tags = param! :tags, Array, required: true, default: [] do |array, index|
      array.param! index, String, requured: true
    end

    options = param! :options, Array, required: true do |array, index|
      array.param! index, String, required: true
    end

    render json: Poll.create!(
      title: title,
      description: description,
      user_id: current_user.id,
      tags: tags,
      options: options
    )
  end

  def edit
  end

  def delete
    id = param! :id, Integer, required: true
    render json: Poll.destroy_all(user_id: current_user.id, id: id) 
  end

  def report
    id = param! :id, Integer, required: true
    render json: Poll.increment_counter(:reported, id)
  end
end
