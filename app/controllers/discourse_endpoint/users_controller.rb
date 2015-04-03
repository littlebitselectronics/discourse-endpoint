module DiscourseEndpoint
  class UsersController < ApplicationController

    def current
      if current_user.present?
        retrieve_user_info
      else
        render nothing: true, status: 404
      end
    end

    def fetch_nav
      nav_response = RestClient.get(
          "http://stg1.littlebits.cc/nav/fetch",
          {
            params: {
              ahoy_visitor: cookies[:visitor] || cookies[:ahoy_visitor]
            }
          }
        )

      render html: nav_response.html_safe, status: :ok
    end

    private
      def retrieve_user_info
        oauth_info = Oauth2UserInfo.find_by(user_id: current_user.id)
        response = RestClient.get(
          endpoint_store_url,
          {
            params: {
              user_uid: oauth_info.try(:uid),
              user_token: session[:authentication]
            }
          }
        )

        render json: response, status: :ok
      end

      def endpoint_store_url
        "#{SiteSetting.endpoint_url}/api/users/retrieve_user_info.json"
      end
  end
end
