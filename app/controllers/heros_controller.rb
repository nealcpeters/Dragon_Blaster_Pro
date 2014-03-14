class HerosController < ApplicationController



  def show
    @hero = Hero.find(params[:id])
  end

  def index
    @user = current_user
    @hero = @user.heros.all
  end

  def new
    @hero = Hero.new
    @user = current_user
  end

  def create
    @user = current_user
    @hero = Hero.new(hero_params.merge(player_id: current_user.id))
    if @hero.save
      redirect_to user_heros_path
    else
      flash[:alert] = "Error creating your hero. Try again"
      render 'new'
    end
  end


  private
    def hero_params
      params.require(:hero).permit(:name, :description)
    end
end
