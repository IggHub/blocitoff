class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def about
  end

  respond_to do |format|
   format.html
   format.js
  end
end
