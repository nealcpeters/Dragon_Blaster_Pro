class GamesController < ApplicationController
  def all
    @games = current_user.games
  end

  def show
    @game = Game.find(params[:id])
    @map = @game.map
    @player = @game.player
    @room = @game.room
    @hero = @game.hero
  end

  def input
    @action = params[:user_input]
    @game = Game.find(params[:id])
    case @action
    when /\w*east/
      if @game.move_hero_east
        @game.save
        @results = "You go east"
      else
        flash[:alert] = "There is no room to the east."
      end
    when /\w*west/
      if @game.move_hero_west
        @game.save
        @results = "You go west"
      else
        flash[:alert] = "There is no room to the west."
      end
    when /\w*north/
      if @game.move_hero_north
        @game.save
        @results = "You go north"
      else
        flash[:alert] = "There is no room to the north."
      end
    when /\w*south/
      if @game.move_hero_south
        @game.save
        @results = "You go south"
      else
        flash[:alert] = "There is no room to the south."
      end
    when /\w*look/
      @results = "You see #{@game.room.description}"
    else
      flash[:alert] = "I don't know that command."
    end
    @map = @game.map
    @player = @game.player
    @room = @game.room
    @hero = @game.hero
    render 'show'
  end

  def launch
    @game = Game.where(player_id: current_user.id,id: params[:game_id]).first
    if @game
      @map = @game.map
      @player = @game.player
      @room = @game.room
      @hero = @game.hero
      render 'show'
    else
      flash[:notice] = "That game wasn't located"
      redirect_to all_games_path
    end
  end

  def new
    render 'new'
  end

  def create
    @hero = Hero.find_by_name(params[:hero_name])
    @map = Map.find(params[:map_id][0])
    @player = User.find(session[:user_id])
    @game = Game.create(player_id: @player.id ,hero_id: @hero.id, map_id: @map.id, room_id: @map.starting_room_id)
    @room = @game.room
    render 'show'
  end

end
