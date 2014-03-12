class MapsController < ApplicationController
  def index

  end

  def new
    @user = current_user
    @map = Map.new
  end

  def create

  end
end
