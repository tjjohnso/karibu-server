class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :exclude_json_root

  def exclude_json_root
    ActiveRecord::Base.include_root_in_json = false
  end
end
