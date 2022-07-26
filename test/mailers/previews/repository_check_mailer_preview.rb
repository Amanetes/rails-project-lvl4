# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/repository_check_mailer
class RepositoryCheckMailerPreview < ActionMailer::Preview
  def check_failed
    user = User.first
    check = Repository::Check.first
    result = Repository::Check.first.result
    RepositoryCheckMailer.with(user: user, check: check, result: result).check_failed
  end
end
