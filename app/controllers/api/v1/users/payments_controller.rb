module Api
  module V1
    module Users
      class PaymentsController < ApiController
        def create
          PaymentService.transfer_to_friend(current_user, friend_id, amount, description)
        end

        private

        def current_user
          @current_user ||= User.with_balances.find(params[:user_id])
        end

        def friend_id
          params[:friend_id]
        end

        def description
          params[:description]
        end

        def amount
          params[:amount].to_f
        end
      end
    end
  end
end
