module Api
  module V1
    module Users
      class FriendshipRequestsController < ApiController
        def create
          success = FriendshipService.create_friendship_request(current_user, friend_id)

          head :ok if success

          render json: { errors: I18n.t('api.errors.unable_to_add_friend') },
                 status: :bad_request
        end

        def index
          @requests = current_user.received_friendship_requests
        end

        def destroy
          FriendshipService.cancel_request(current_received_friendship_request)
        end

        private

        def current_user
          User.find(params[:user_id])
        end

        def current_received_friendship_request
          current_user.received_friendship_requests.find(friendship_request_id)
        end

        def friendship_request_id
          params[:friendship_request_id] || params[:id]
        end

        def friend_id
          params[:friend_id]
        end
      end
    end
  end
end
