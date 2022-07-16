# frozen_string_literal: true

class Repository < ApplicationRecord
  extend Enumerize

  enumerize :language, in: %i[javascript]

  belongs_to :user

  validates :github_id, presence: true, uniqueness: true, allow_nil: true

  def self.fetch_repositories(token)
    client = Octokit::Client.new(access_token: token, per_page: 100)
    client.repos.select { |repo| Repository.language.values.include?(repo[:language]&.downcase) }
  end
end
