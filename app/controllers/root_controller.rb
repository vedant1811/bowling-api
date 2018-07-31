class RootController < ApplicationController
  def apis
    render json: apis_json
  end

private
  def apis_json
    {
      new_game_url: games_url,
      new_ball_url: game_new_ball_url(':game_id'),
      game_score_url: game_url(':game_id')
    }
  end
end
