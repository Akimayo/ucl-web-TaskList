class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_breadcrumb "TaskList", :root_path

end
