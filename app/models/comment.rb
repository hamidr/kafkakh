class Comment < ActiveRecord::Base
  validates :body, presence: true

  belongs_to :poll, validate: true

  enum status: [:show, :hide]
end
