class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      # Send them back to the page they were requesting, or
      # to their profile page by default.
      redirect_back_or user
    else
      # Need to use flash.now for re-renders, no flash.
      # The reason is we have been using flash within redirects which
      # count as a request, so when we click away from the page the 
      # flash message is gone. This is not the case with re-renders and
      # so the flash message persists until we make two requests.
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
