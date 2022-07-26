# frozen_string_literal: true

module RepositoryLoader
  def clone(repository)
    BashRunner.run("git clone #{repository.clone_url} #{get_repository_path(repository)}")
  end

  def remove(repository)
    BashRunner.run("rm -rf #{get_repository_path(repository)}")
  end

  def get_repository_path(repository)
    Rails.root.join('tmp', 'repositories', repository.full_name)
  end
end
