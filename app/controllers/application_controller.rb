class ApplicationController < ActionController::Base
    include Pundit
    protect_from_forgery

    rescue_from Pundit::NotAuthorizedError do
        redirect_to root_url, alert: 'You do not have access to this page'
    end
end
