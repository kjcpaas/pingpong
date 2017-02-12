class BallAndWallCollision
  attr_reader :ball, :court, :handlers

  def initialize(ball, court, handlers = {})
    @ball = ball
    @court = court
    @handlers = handlers
  end

  def apply_collisions
    if handlers[:top].is_a?(Proc) && (ball.pos_y - ball.radius) < court.top_y
      handlers[:top].call(ball, court)
    elsif handlers[:bottom].is_a?(Proc) && (ball.pos_y + ball.radius) > court.bottom_y
      handlers[:bottom].call(ball, court)
    elsif handlers[:left].is_a?(Proc) && (ball.pos_x - ball.radius) < court.left_x
      handlers[:left].call(ball, court)
    elsif handlers[:right].is_a?(Proc) && (ball.pos_x + ball.radius) > court.right_x
      handlers[:right].call(ball, court)
    end
  end
end
