class GamesController < ApplicationController
  before_action :set_game, only: [:show]

  def create
    @game = Game.create!
    render json: @game, status: :created
  end

  def show
    render json: @game
  end

private
  def set_game
    @game = Game.find params[:id]
  end
end
