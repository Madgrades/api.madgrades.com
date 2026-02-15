class PagesController < ApplicationController
  layout false, only: :docs

  def index

  end

  def docs
  end

  def disconnect_provider
    if current_user.nil?
      redirect_to :root
      return
    end

    identity = current_user.identities.find_by(provider: params[:provider])

    if identity.nil?
      redirect_to :root
      return
    end

    identity.destroy
    redirect_to :root
  end

  def regenerate_api_token
    if current_user.nil?
      redirect_to :root
      return
    end

    current_user.regenerate_api_token
    redirect_to :root
  end
end
