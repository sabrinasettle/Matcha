class Match < ApplicationRecord
  include PublicActivity::Common
  
  belongs_to :user
  belongs_to :conversation

  validates_presence_of :user_id, scope: :conversation_id
  validates_presence_of :inverse_user


  def self.shared_chat(users)
    # find the id of the shared chat room
    
  end
  


  def self.shared_with(users)
    user_ids = users.map(&:id)
    convo_ids = Match.all.where(user_id: [user_ids]).pluck(:conversation_id)
    convo_ids.select{|item| convo_ids.count(item) > 1}.uniq
    id = convo_ids[0].to_i
    # a.select{|item| a.count(item) > 1}.uniq
  end

  
  # def connect_to(user)
  #   self.where(user_id: user.id)
  # end

end
