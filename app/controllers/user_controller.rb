class UserController < ApplicationController
  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token, except: :index

  def index
    @polls = {
      own_polls: UserHelper.last_own_polls(current_user),
      voted_polls: UserHelper.last_voted_polls(current_user)
    }
  end

  def polls
    page = param! :page, Integer, required: true

    render json: UserHelper.last_own_polls(current_user, page)
  end

  def voteds
    page = param! :page, Integer, required: true

    render json: UserHelper.last_voted_polls(current_user, page)
  end

  def deactive_me
  end
end
