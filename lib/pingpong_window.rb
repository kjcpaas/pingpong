class PingpongWindow < Gosu::Window
  def initialize
    super Settings::Game::WIDTH, Settings::Game::HEIGHT
    self.caption = Settings::Game::NAME
    create_game_elements
  end

  def draw
    background.draw
  end

  private
  attr_reader :background

  def create_game_elements
    @background = Court.new(self)
  end
end
