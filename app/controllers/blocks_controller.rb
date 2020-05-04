class BlocksController < ApplicationController
    include LikesHelper

    before_action :find_profile
    before_action :get_profile_user

    def create
        # Logic here is that if the users have a relantionship of some sort its destroyed 
        # on the blocked users side
        if @profile_user.matches.where(inverse_user: current_user.id).any?
            destroy_match(@profile)
        end
        if @profile_user.likes.where(profile_id: current_user.id).any?
            @profile_user.likes.where(profile_id: current_user.id).destroy_all
        end
        if @profile.blocks.create!(profile_id: @profile.user_id, user_id: current_user.id)
            #disable being able to see the profilees of others
        end
        respond_to do |format|
            # format.html { redirect_to '/main' }
            format.js { redirect_to profile_path(@profile.user_name)}
        end
        
        # redirect_to profile_path(@profile.user_name)
    end

    def destroy
        @profile.blocks.where(profile_id: @profile.user_id).destroy_all
        # logic to reshow a user to the unblocked user

        respond_to do |format|
            # format.html 
            format.js { redirect_to profile_path(@profile.user_name)}
        end
        # redirect_to profile_path(@profile.user_name)
    end

    private
        def get_profile_user
            id = params[:profile_id]
            @profile_user = User.find(id)
        end

        def find_profile
            @profile = Profile.find(params[:profile_id])
        end
end
