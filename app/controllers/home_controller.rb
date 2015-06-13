class HomeController < BaseController
  def index
    pp current_user
    # moves = Moves::Client.new(access_token)
  end
end
