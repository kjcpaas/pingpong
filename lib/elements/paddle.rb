class Paddle
  attr_reader :court, :color, :width, :height, :pos_x, :pos_y, :speed
  attr_accessor :dir

  def initialize(court, initial_x, initial_y)
    @court = court
    @color = Settings::Paddle::COLOR
    @speed = Settings::Paddle::SPEED
    @width = Settings::Paddle::WIDTH
    @height = Settings::Paddle::HEIGHT
    @pos_x = initial_x
    @pos_y = initial_y
    @dir = 0
    generate_rmagick_image
  end

  def draw
    image.draw(pos_x, pos_y, 1)
  end

  def move
    # Need to limit position to stay within court
    @pos_y = [
      [@pos_y + dir * speed, court.top_y].max,
      court.bottom_y - height
    ].min
  end

  def image
    @image ||= Gosu::Image.new(@rmagick_image)
  end

  private
  def generate_rmagick_image
    paddle = self
    @rmagick_image = Magick::Image.new(width, height) { self.background_color = paddle.color }
  end
end

class LeftPaddle < Paddle
end

class RightPaddle < Paddle
end
