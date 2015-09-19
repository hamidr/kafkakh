class Option < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :poll, validate: true
  has_many :votes, dependent: :destroy 

  def self.create_many!(poll_id, titles)
    titles.each do |title|
      Option.create!(title: title, poll_id: poll_id)
    end
  end

end
