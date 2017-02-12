class PaddleAndWallCollision
  attr_reader :paddle, :court, :handlers

  def initialize(paddle, court, handlers = {})
    @paddle = paddle
    @court = court
    @handlers = handlers
  end

  def apply_collisions
    if handlers[:top].is_a?(Proc) && (paddle.pos_y) < court.top_y
      handlers[:top].call(paddle, court)
    elsif handlers[:bottom].is_a?(Proc) && (paddle.pos_y + paddle.height) > court.bottom_y
      handlers[:bottom].call(paddle, court)
    end
  end
end
