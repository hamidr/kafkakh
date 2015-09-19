class Vote < ActiveRecord::Base
  belongs_to :option, validate: true
  belongs_to :user, validate: true
  belongs_to :poll, validate: true
end
