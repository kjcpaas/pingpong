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

  def button_down(id)
    case id
    when Gosu::KbUp
      right_paddle.dir = -1
    when Gosu::KbDown
      right_paddle.dir = 1
    when Gosu::KbW
      left_paddle.dir = -1
    when Gosu::KbS
      left_paddle.dir = 1
    end
  end

  def button_up(id)
    case id
    when Gosu::KbUp
      right_paddle.dir = 0
    when Gosu::KbDown
      right_paddle.dir = 0
    when Gosu::KbW
      left_paddle.dir = 0
    when Gosu::KbS
      left_paddle.dir = 0
    end
  end

  def update
    # Gets called every 1/60 seconds
    return unless ready?
    ball.move
    court.bounce(ball)
    right_paddle.move
    left_paddle.move
  end

  def draw
    court.draw
    ball.draw
    right_paddle.draw
    left_paddle.draw
  end

  private
  attr_reader :court, :ball, :left_paddle, :right_paddle

  def create_game_elements
    @court = Court.new(self)
    @ball = Ball.new(width/2, height/2)
    @left_paddle = LeftPaddle.new(court)
    @right_paddle = RightPaddle.new(court)
    @ready = true
  end
end
