class Poll < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search_by_title, :against => :title

  validates :title, presence: true

  belongs_to :user, validate: true
  has_many :options, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  scope :any_tags, -> (tags){ where('tags && ARRAY[?]::varchar[]', tags) }
  scope :all_tags, -> (tags){ where('tags @> ARRAY[?]::varchar[]', tags) }

  enum status: [:pub, :priv]

  def self.find_pub_by_id! id
    Poll.select(:id, :view_count, :title, :description, :tags).find_by!(status: statuses[:pub], id: id)
  end

  def self.create! **kargs
    options = kargs.delete(:options)
    ActiveRecord::Base.transaction do
      poll = super kargs
      Option.create_many!(poll.id, options)
      poll
    end
  end

end
