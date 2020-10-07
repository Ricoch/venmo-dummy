module Api
  module V1
    module Users
      class FriendshipsController < ApiController
        def index
          @friends = current_user.friends
        end

        def destroy
          FriendshipService.remove_friend(current_user, friend_id)

          head :ok
        end

        private

        def current_friendship
          current_user.friendships.find_by
        end

        def current_user
          @current_user ||= User.with_friendships_and_friends.find(params[:user_id])
        end

        def friend_id
          params[:friend_id]
        end
      end
    end
  end
end
