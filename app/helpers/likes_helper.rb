module LikesHelper

    def match?(profile)
        current_user.profile.likes.where(user_id: profile.user_id).any?
    end

    def create_match(profile)
        #need to test
        @new_convo = Conversation.create
        id = @new_convo.id
        #create match objects for both users 
        
        Match.create([{user_id: current_user.id, inverse_user: profile.user_id, conversation_id: id},
        {user_id: profile.user_id, inverse_user: current_user.id, conversation_id: id}])

        @new_convo.create_activity key: 'match.liked_back', owner: current_user, recipient: @user
    end

    # Work on -- Destory the conversation model and the match models 
    def destroy_match(profile)
        id = Match.where(user_id: current_user.id, inverse_user: profile.user_id).pluck(:conversation_id)
        
        Match.where(user_id: current_user.id, inverse_user: profile.user_id).destroy_all
        Match.where(user_id: profile.user_id, inverse_user: current_user.id).destroy_all
        Conversation.where(id: id).destroy_all
        # matches.destory_all
        # Match.all.where(id: [current_user.id, profile.id]).destory_all
        # Conversation.all.where(id: @new_convo.id).destroy_all
        # put the matchs in a array?
        # find the conversation id, then detory the Conversation object
        
        # then destroy both Match objects

        
        puts "Destory Connection/Conversation"
    end
end
