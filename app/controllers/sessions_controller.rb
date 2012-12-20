class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def failure
    #redirect_to root_url, :notice => params[:message]
    flash[:notice] = params[:message]
  end

  def unconfirmed
    flash[:notice] = "You are not a confirmed team member. Please contact cwh@suse.de."
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
