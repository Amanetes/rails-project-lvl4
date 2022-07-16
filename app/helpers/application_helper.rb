# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = '')
    base_title = I18n.t('app_name')
    page_title.empty? ? base_title : page_title.to_s
  end

  def flash_class(level)
    mapping = {
      success: 'alert-success',
      notice: 'alert-info',
      alert: 'alert-danger',
      error: 'alert-danger',
      warn: 'alert-warning'
    }
    mapping[level.to_sym]
  end
end
