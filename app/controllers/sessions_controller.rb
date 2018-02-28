class SessionsController < ApplicationController
  # todo: this was taken directly from example, it made a lot of sense to me :)
  def create
    auth = request.env['omniauth.auth']

    # Find an identity here
    @identity = Identity.find_with_omniauth(auth)

    if @identity.nil?
      # If no identity was found, create a brand new one here
      @identity = Identity.create_with_omniauth(auth)
    end

    if signed_in?
      if @identity.user == current_user
        # User is signed in so they are trying to link an identity with their
        # account. But we found the identity and the user associated with it
        # is the current user. So the identity is already associated with
        # this user. So let's display an error message.
        redirect_to :root, notice: 'Already linked that account!'
      else
        # The identity is not associated with the current_user so lets
        # associate the identity
        @identity.user = current_user
        @identity.save
        redirect_to :root, notice: 'Successfully linked that account!'
      end
    else
      if @identity.user.present?
        # The identity we found had a user associated with it so let's
        # just log them in here
        self.current_user = @identity.user
        current_user.update_with_omniauth(auth.info)
        redirect_to :root, notice: 'Signed in!'
      else
        # Find existing, but not-logged in user by auth info
        user = User.find_with_omniauth(auth.info)

        # No user associated with the auth info so we need to create a new one
        if user.nil?
          user = User.create_with_omniauth(auth.info)
        end

        self.current_user = user
        @identity.user = current_user
        @identity.save
        redirect_to :root, notice: 'Account created!'
      end
    end
  end

  def destroy
    self.current_user = nil
    redirect_to root_path
  end
end
