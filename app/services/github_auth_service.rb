# frozen_string_literal: true

class GithubAuthService
  def self.login(auth)
    User.find_or_initialize_by(email: auth[:info][:email].downcase)
  end
end
