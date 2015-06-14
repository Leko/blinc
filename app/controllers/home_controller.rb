class HomeController < BaseController
  def index
    @current_user = current_user
    @root = true
  end
end
