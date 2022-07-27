# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    before_action :authenticate_user!, only: %i[logout]
    def callback
      @user = GithubAuthService.login(auth)

      @user.nickname = auth[:info][:nickname]
      @user.name = auth[:info][:name]
      @user.image_url = auth[:info][:image]
      @user.token = auth[:credentials][:token]

      if @user.save
        sign_in @user
        flash[:notice] = t('.login')
        redirect_to root_url
      else
        flash.now[:error] = t('.auth_error')
        redirect_back(fallback_location: root_path)
      end
    end

    def logout
      sign_out
      flash[:notice] = t('.sign_out')
      redirect_to root_path, status: :see_other
    end

    private

    def auth
      request.env['omniauth.auth']
    end
  end
end
