class Message < ApplicationRecord
  include PublicActivity::Common


  
  belongs_to :conversation
  belongs_to :user

  # belongs_to :sender, class_name: :User, foreign_key: 'sender_id'

  validates_presence_of :body

  # after_create_commit { MessageBroadcastJob.perform_later(self) }
end
