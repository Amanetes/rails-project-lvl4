# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = '')
    base_title = t('app_name')
    page_title.empty? ? base_title : page_title.to_s
  end

  def flash_class(level)
    mapping = {
      notice: 'alert alert-info',
      success: 'alert alert-success',
      error: 'alert alert-error',
      alert: 'alert alert-warning'
    }
    mapping[level.to_sym]
  end
end
