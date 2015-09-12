class Paddle
  attr_reader :color, :radius, :pos_x, :pos_y, :speed, :dir_x, :dir_y

  def initialize(initial_x, initial_y)
    @color = Settings::Paddle::COLOR
    @speed = Settings::Paddle::SPEED
    @pos_x = initial_x
    @pos_y = initial_y
    generate_rmagick_image
  end
end

class LeftPaddle < Paddle
end

class RightPaddle < Paddle
end
