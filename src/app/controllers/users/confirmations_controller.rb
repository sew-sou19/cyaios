# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token])

    if resource.nil? || resource.confirmed?
      # トークンが不正な場合、アカウント登録(パスワード登録)が済んでいる場合
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])
      render :show
    elsif resource.is_confirmation_period_expired?
      # アカウント登録メールの期限が切れた場合
      resource.errors.add(:email, :confirmation_period_expired,
        period: Devise::TimeInflector.time_ago_in_words(resource_class.confirm_within.ago))
      render :show
    else
      # activate
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])
      user = User.find_by(id: params[:format]).update_attribute(:account_type_id, 2)
      sign_in(resource)
      render :confirmed
    end
  end

  def confirmed
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
