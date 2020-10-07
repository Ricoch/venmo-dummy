module Api
  module V1
    module Users
      class BalancesController < ApplicationController
        def index
          @balance = current_user.last_balance
        end

        private

        def current_user
          @current_user ||= User.with_balances.find(params[:user_id])
        end
      end
    end
  end
end
