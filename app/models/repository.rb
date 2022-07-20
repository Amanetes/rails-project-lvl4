# frozen_string_literal: true

class Repository < ApplicationRecord
  extend Enumerize

  belongs_to :user

  validates :github_id, presence: true
  validates :github_id, uniqueness: true

  enumerize :language, in: %i[javascript]

end
