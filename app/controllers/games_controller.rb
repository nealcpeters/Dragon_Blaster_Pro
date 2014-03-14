class GamesController < ApplicationController
  def all
    @games = Game.where(player_id: params[:user_id])
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
      @game.move_hero_east
      @game.save
      @results = "You go east"
    when /\w*west/
      @game.move_hero_west
      @game.save
      @results = "You go west"
    when /\w*north/
      @game.move_hero_north
      @game.save
      @results = "You go north"
    when /\w*south/
      @game.move_hero_south
      @game.save
      @results = "You go south"
    when /\w*look/
      @results = "You see #{@game.room.description}"
    end
    @map = @game.map
    @player = @game.player
    @room = @game.room
    @hero = @game.hero
    render 'show'
  end

  def launch
    @map_id = params[:map_id]
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
