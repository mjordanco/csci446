class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_consideration
  	Considering.find(session[:considering_id])
  rescue ActiveRecord::RecordNotFound
  	considering = Considering.create
  	session[:considering_id] = considering.id
  	considering
  end

end
