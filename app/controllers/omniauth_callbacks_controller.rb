class OmniauthCallbacksController < Devise::OmniauthCallbacksController   
  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
    
    redirect_to home_index_path if !@user.is_active
    
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    end
  end
end
