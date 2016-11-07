class SeasonsController < ApplicationController

  def index
    @seasons = Game::SEASONS
  end

  def show

  end



  protected

end
