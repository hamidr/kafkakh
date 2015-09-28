class AdminController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :authorize!
  skip_before_filter :verify_authenticity_token, except: :index

  def index
    page = param! :page, Integer, default: 1 
    @users = User.select(:id, :email, :is_active, :role).page(page).per(10)
  end

  def users
    page = param! :page, Integer, default: 1 
    render json: User.page(page).per(10)
  end

  def reporteds
    page = param! :page, Integer, default: 1 
    render json: Poll.where("reported > ?", 0).order("reported desc").page(page).per(10)
  end

  def deactive_user
    id = param! :id, Integer, required: true
    render json: User.update(id, is_active: false)
  end

  def activate_user
    id = param! :id, Integer, required: true
    render json: User.update(id, is_active: true)
  end

  def remove_poll
    id = param! :id, Integer, required: true
    render json: Poll.destroy(id)
  end
  

  private
  def authorize!
    return render json: {action: "not authorized"}, status: :unauthorized if !current_user.admin?
  end
end
