class BallAndPaddleCollision
  attr_reader :ball, :paddle, :handlers

  def initialize(ball, paddle, handlers = {})
    @ball = ball
    @paddle = paddle
    @handlers = handlers
  end

  def apply_collisions
    if handlers[:left_edge].is_a?(Proc) && (ball.pos_x + ball.radius) > paddle.left_edge_x
      handlers[:left_edge].call(ball, paddle)
    elsif handlers[:right_edge].is_a?(Proc) && (ball.pos_x - ball.radius) < paddle.right_edge_x
      handlers[:right_edge].call(ball, paddle)
    end
  end
end
