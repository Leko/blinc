# RailsでいろんなSNSとOAuth連携/ログインする方法 - Qiita
# http://qiita.com/awakia/items/03dd68dea5f15dc46c15
class SessionsController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid']) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
