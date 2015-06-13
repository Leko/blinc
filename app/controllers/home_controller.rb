class HomeController < BaseController
  def index
    pp request.env['omniauth.auth']
    # moves = Moves::Client.new(access_token)
  end
end
