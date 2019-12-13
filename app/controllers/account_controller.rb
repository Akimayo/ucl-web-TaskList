class AccountController < ApplicationController
  before_action :authenticate_user!
  def index
    add_breadcrumb current_user.username
  end
end
