# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super do |reg|
      # TODO: Add mock tasks/categories/tags for new users
      c0 = Category.new(title: "Osobní", color: "", user: reg)
      c0.save
      c1 = Category.new(title: "Škola", color: "", user: reg)
      c1.save
      c2 = Category.new(title: "Práce", color: "", user: reg)
      c2.save
      t0 = Task.new(title: "Vítejte v aplikaci TaskList", user: reg)
      t0.save
      t1 = Task.new(title: "Naučte se používat kategorie", category: c0, note: "TODO: Category text", user: reg)
      t1.save
      t2 = Task.new(title: "Naučte se používat značky", note: "TODO: Tags text", user: reg)
      t2.save
      g0 = Tag.new(title: "UCL", color: "", user: reg)
      g0.save
      g1 = Tag.new(title: "JSE", color: "", user: reg)
      g1.save
      g2 = Tag.new(title: "WEB", color: "", user: reg)
      g2.save
      g3 = Tag.new(title: "3DT", color: "", user: reg)
      g3.save
      g4 = Tag.new(title: "PR1", color: "", user: reg)
      g4.save
      g5 = Tag.new(title: "PES", color: "", user: reg)
      g5.save
      g6 = Tag.new(title: "Nákupy", color: "", user: reg)
      g6.save
      g7 = Tag.new(title: "Wishlist", color: "", user: reg)
      g7.save
      p t2
      p g7
      a0 = TagAssociation.new(tag: g7, task: t2)
      a0.save
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

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
