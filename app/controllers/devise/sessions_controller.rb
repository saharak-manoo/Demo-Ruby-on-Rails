
class Devise::SessionsController < DeviseController
  prepend_before_action :require_no_authentication, only: [:new, :create]
  prepend_before_action :allow_params_authentication!, only: :create
  prepend_before_action :verify_signed_out_user, only: :destroy
  prepend_before_action(only: [:create, :destroy]) { request.env["devise.skip_timeout"] = true }

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    email = params[:user][:email]
    user = User.find_by(email: email)

    # สำหรับกรณีที่ระบบไม่ส่ง email ให้
    if params[:not_receive_confirm].present?
      send_confirmation_again(user)
    else
      if user.present? && user.confirmed_at.present?
        if user.valid_password?(params[:user][:password])
          self.resource = warden.authenticate!(auth_options)
          set_flash_message!(:notice, :signed_in)
          # ส่ง Email แจ้งเตือนการเข้าสู่ระบบ
          UserMailer.login_notification(user).deliver
          sign_in(resource_name, resource)
        else
          flash[:error] = I18n.t('login_failed')
        end
      else
        flash[:error] = user.blank? ? I18n.t('login_failed') : I18n.t('not_confirmed')
      end
      redirect_to root_path
    end
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

  protected

  def sign_in_params
    devise_parameter_sanitizer.sanitize(:sign_in)
  end

  def serialize_options(resource)
    methods = resource_class.authentication_keys.dup
    methods = methods.keys if methods.is_a?(Hash)
    methods << :password if resource.respond_to?(:password)
    { methods: methods, only: [:password] }
  end

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end

  def translation_scope
    'devise.sessions'
  end

  private

  # Check if there is no signed in user before doing the sign out.
  #
  # If there is no signed in user, it will set the flash message and redirect
  # to the after_sign_out path.
  def verify_signed_out_user
    if all_signed_out?
      set_flash_message! :notice, :already_signed_out

      respond_to_on_destroy
    end
  end

  def all_signed_out?
    users = Devise.mappings.keys.map { |s| warden.user(scope: s, run_callbacks: false) }

    users.all?(&:blank?)
  end

  def respond_to_on_destroy
    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
    end
  end

  def send_confirmation_again(user)
    if user.present?
      if user.confirmed_at.nil?
        resource_class.send_confirmation_instructions(resource_params)
        flash[:success] = I18n.t('devise.confirmations.send_instructions')
      else
        flash[:success] = I18n.t('errors.messages.already_confirmed')
      end
      redirect_to root_path(confirmed: true)
    else
      flash[:error] = 'There is no email in this system.'
      redirect_to root_path(no_email: true)
    end
  end
end
