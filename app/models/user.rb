class User < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.screen_name = auth['info']['nickname']
      user.name = auth['info']['name']
      user.access_token = auth['credentials']['token']
      user.refresh_token = auth['credentials']['refresh_token']
    end
  end
end
