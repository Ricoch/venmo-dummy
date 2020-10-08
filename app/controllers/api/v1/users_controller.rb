module Api
  module V1
    class UsersController < Api::V1::ApiController
      def show; end

      def index
        @users = User.all
      end

      def create
        user = UserService.create_user(user_params)

        # For simplicity, will create the payment source here
        ExternalPaymentSource.create!(user: user)

        head :ok
      end

      def update
        current_user.update!(user_params)
        render :show
      end

      private

      def user_params
        params.require(:user).permit(:username, :first_name, :last_name, :email)
      end
    end
  end
end
