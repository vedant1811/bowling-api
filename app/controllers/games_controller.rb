class GamesController < ApplicationController
  before_action :set_game, only: [:show, :new_ball]

  def create
    @game = Game.create!
    render json: @game, status: :created
  end

  def show
    render json: @game, include: 'frames,frames.balls'
  end

  def new_ball
    errors = @game.new_ball params[:pins]
    if errors.empty?
      render json: @game, include: 'frames,frames.balls', status: :created
    else
      render json: { errors: errors }, status: :unprocessable_entity
    end
  end

private
  def set_game
    @game = Game.find params[:id] || params[:game_id]
  end
end
