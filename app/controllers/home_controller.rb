class HomeController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  skip_before_filter :verify_authenticity_token, except: :index

  def index
    votes_by_poll_ids = Vote.group(:poll_id).limit(10).count
    polls = Poll.where(id: votes_by_poll_ids.keys).limit(10)
    @polls = polls.map do |p|
      poll = p.attributes
      poll['total_count'] = votes_by_poll_ids[p.id].to_i
      poll
    end.sort_by {|p| p['total_count']}.reverse
  end

  def search
    page = param! :page, Integer, required: true
    title = param! :title, String, required: true, default: ""
    tags = param! :tags, Array, required: true, default: [] do |array, index|
      array.param! index, String, required: true
    end

    p = (tags.length == 0) ? Poll : Poll.all_tags(tags)
    p = (title == "") ? p : p.search_by_title(title)

    polls = p.order('id desc').page(page).per(10)
    votes = Vote.where(poll_id: polls.map(&:id)).group(:poll_id).count

    polls = polls.map do |p|
      poll = p.attributes
      poll['total_count'] = votes[p.id].to_i
      poll
    end

    render json: polls
  end
end
