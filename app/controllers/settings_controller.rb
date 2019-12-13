class SettingsController < ApplicationController
  before_action :authenticate_user!
  add_breadcrumb "Nastavení", :settings_path
  def index
  end
end
