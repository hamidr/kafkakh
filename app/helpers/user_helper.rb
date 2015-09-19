module UserHelper

  def self.last_own_polls current_user, page = 1, per = 10
    last_polls = current_user.polls.order('id desc').page(page).per(per)
    votes = Vote.where(poll_id: last_polls.map(&:id)).group(:poll_id).count
    last_polls.map do |p|
      poll = p.attributes
      poll['total_count'] = votes[p.id].to_i 
      poll
    end
  end

  def self.last_voted_polls current_user, page = 1, per = 10
    votes = current_user.votes
    last_polls = Poll.where(id: votes.map(&:poll_id)).order('id desc').page(page).per(per)
    votes = Vote.where(poll_id: last_polls.map(&:id)).group(:poll_id).count
    last_polls.map do |p|
      poll = p.attributes
      poll['total_count'] = votes[p.id] 
      poll
    end
  end
end
