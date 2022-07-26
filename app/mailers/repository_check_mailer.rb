# frozen_string_literal: true

class RepositoryCheckMailer < ApplicationMailer
  def check_failed
    @check = params[:check]
    @user = @check.repository.user
    @repository = @check.repository
    mail to: @user.email, subject: t('.subject', repository: @repository.name)
  end
end
