# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    add_breadcrumb "Zaregistrovat se"
    super
  end

  # POST /resource
  def create
    bell = 7.chr
    super do |reg|
      c0 = reg.categories.new({title: "#{bell}Osobní", color: "#FF0000"})
      c1 = reg.categories.new(title: "#{bell}Škola", color: "#00FF00")
      reg.categories.new(title: "#{bell}Práce", color: "#0000FF")
      g1 = reg.tags.new(title: "#{bell}UCL", color: "#F00000")
      reg.tags.new(title: "#{bell}JSE", color: "#0FFFFF")
      g2 = reg.tags.new(title: "#{bell}WEB", color: "#00F000")
      reg.tags.new(title: "#{bell}3DT", color: "#FF0FFF")
      reg.tags.new(title: "#{bell}PR1", color: "#0000F0")
      reg.tags.new(title: "#{bell}PES", color: "#FFFF0F")
      g0 = reg.tags.new(title: "#{bell}Nákupy", color: "#000FFF")
      reg.tags.new(title: "#{bell}Wishlist", color: "#FFF000")
      reg.tasks.new(title: "#{bell}Toto je jednoduchý úkol", is_done: false)
      reg.tasks.new(title: "#{bell}Toto je už dokončený úkol", is_done: true)
      reg.tasks.new(title: "#{bell}Nakoupit na večeři", is_done: false, category: c0, tags: [g0])
      reg.tasks.new(title: "#{bell}Udělat semestrální práci z předmětu WEB", is_done: false, category: c1, tags: [g1, g2])
      reg.save
    end
  end

  # GET /resource/edit
  def edit
    add_breadcrumb "Upravit účet"
    super
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
    def destroy
      current_user.tasks.all.each do |c|
        c.update({tag_ids: []})
        c.destroy
      end
      current_user.tags.all.each do |g|
        g.destroy
      end
      current_user.categories.all.each do |t|
        t.destroy
      end
      super
    end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
