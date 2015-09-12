class Ball
  attr_reader :color, :radius, :pos_x, :pos_y

  def initialize(initial_x, initial_y)
    @color = Settings::Ball::COLOR
    @radius = Settings::Ball::RADIUS
    @pos_x = initial_x
    @pos_y = initial_y
    generate_rmagick_image
  end

  def diameter
    radius * 2 + 1 # +1 for the center point
  end

  def draw
    image = Gosu::Image.new(@rmagick_image)
    image.draw(pos_x - radius, pos_y - radius, 0)
  end

  private
  def generate_rmagick_image
    image = Magick::Image.new(diameter, diameter) { self.background_color = 'none' }

    pen = Magick::Draw.new
    pen.fill(color).circle(radius, radius, 0, radius)
    pen.draw(image)

    @rmagick_image = image
  end
end
