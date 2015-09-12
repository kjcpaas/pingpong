class PingpongWindow < Gosu::Window
  def initialize
    super Settings::Game::WIDTH, Settings::Game::HEIGHT
    self.caption = Settings::Game::NAME
    @ready = false
    create_game_elements
  end

  def ready?
    @ready
  end

  def update
    # Gets called every 1/60 seconds
    return unless ready?
    ball.move
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
    @ready = true
  end
end
