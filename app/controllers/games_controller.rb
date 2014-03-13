class GamesController < ApplicationController
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
  end

  def create
    render params.inspect
  end

end
