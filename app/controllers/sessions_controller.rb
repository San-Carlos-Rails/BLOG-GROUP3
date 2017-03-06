class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      redirect_back_or user
    else
      # Create an error message.
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Invalid email/password combination' }
        format.json { render :show, status: :created, location: @user }
      end
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end