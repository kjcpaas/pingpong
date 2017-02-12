class PingpongWindow < Gosu::Window
  def initialize
    super Settings::Game::WIDTH, Settings::Game::HEIGHT
    self.caption = Settings::Game::NAME
    @ready = false
    create_game_elements
    set_element_collisions
    @ready = true
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
    right_paddle.move
    left_paddle.move
    @collisions.each(&:apply_collisions)
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
    @left_paddle = LeftPaddle.new(
      court,
      court.left_x + Settings::Paddle::EDGE_DISTANCE,
      (height - Settings::Paddle::HEIGHT)/2
    )
    @right_paddle = RightPaddle.new(
      court,
      court.right_x - Settings::Paddle::EDGE_DISTANCE - Settings::Paddle::WIDTH,
      (height - Settings::Paddle::HEIGHT)/2
    )
  end

  def set_element_collisions
    ball_handlers = {
      top: Proc.new { |ball| ball.bounce_from_top },
      bottom: Proc.new { |ball| ball.bounce_from_bottom },
      left: Proc.new { |ball| ball.bounce_from_left },
      right: Proc.new { |ball| ball.bounce_from_right }
    }
    paddle_handlers = {
      top: Proc.new { |paddle| paddle.keep_top },
      bottom: Proc.new { |paddle| paddle.keep_bottom }
    }

    @collisions = [
      BallAndWallCollision.new(ball, court, ball_handlers),
      BallAndPaddleCollision.new(ball, left_paddle, { right_edge: ball_handlers[:left] }),
      BallAndPaddleCollision.new(ball, right_paddle, { left_edge: ball_handlers[:right] }),
      PaddleAndWallCollision.new(left_paddle, court, paddle_handlers),
      PaddleAndWallCollision.new(right_paddle, court, paddle_handlers)
    ]
  end
end
