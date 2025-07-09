class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  before_action :authenticate_person!
  
  private
  
  def after_sign_in_path_for(resource)
    trips_path
  end
  
  def after_sign_out_path_for(resource_or_scope)
    new_person_session_path
  end
end
