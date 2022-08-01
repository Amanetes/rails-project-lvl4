# frozen_string_literal: true

class GithubAuthService
  def self.login(auth)
    user = User.find_or_initialize_by(email: auth[:info][:email].downcase)
    user.nickname = auth[:info][:nickname]
    user.name = auth[:info][:name]
    user.image_url = auth[:info][:image]
    user.token = auth[:credentials][:token]
    user
  end
end
