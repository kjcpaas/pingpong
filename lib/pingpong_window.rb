class PingpongWindow < Gosu::Window
  def initialize
    super Settings::Game::WIDTH, Settings::Game::HEIGHT
    self.caption = Settings::Game::NAME
    create_game_elements
  end

  def draw
    background.draw
    ball.draw
  end

  private
  attr_reader :background, :ball

  def create_game_elements
    @background = Court.new(self)
    @ball = Ball.new(width/2, height/2)
  end
end
