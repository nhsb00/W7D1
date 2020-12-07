class SessionsController < ApplicationController

    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
        if @user.nil?
            render json: "Log in info was incorrect"
        else
            session[:session_token] = @user.reset_session_token!
            redirect_to cats_url
        end
            

    end

    def destroy
        # @current_user = self.current_user
        current_user.reset_session_token!
        session[:session_token] = nil
        redirect_to new_session_url
    end

end
