class VoteController < ApplicationController
  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token
  
  #vote_to
  def vote 
    poll_id = param! :poll_id, Integer, require: true
    option_id = param! :option_id, Integer, require: true
    user_id = current_user.id

    render json: Vote.create!(user_id: user_id, option_id: option_id, poll_id: poll_id) 
  end

  #unvote
  def unvote 
    poll_id = param! :poll_id, Integer, require: true
    option_id = param! :option_id, Integer, require: true
    user_id = current_user.id

    render json: Vote.find_by!(user_id: user_id, option_id: option_id, poll_id: poll_id).destroy
  end
end
