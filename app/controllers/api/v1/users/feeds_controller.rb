module Api
  module V1
    module Users
      class FeedsController < ApplicationController
        def index
          @feed_entries = FeedService.feed_for(current_user).page(page)
        end

        private

        def page
          params[:page] || 1
        end

        def current_user
          @current_user ||= User.find(params[:user_id])
        end
      end
    end
  end
end
