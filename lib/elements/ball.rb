class Ball
  attr_reader :color, :radius, :pos_x, :pos_y, :speed, :dir_x, :dir_y

  def initialize(initial_x, initial_y)
    @color = Settings::Ball::COLOR
    @radius = Settings::Ball::RADIUS
    @speed = Settings::Ball::SPEED
    @pos_x = initial_x
    @pos_y = initial_y
    generate_rmagick_image
    set_ball_direction
  end

  def diameter
    radius * 2 + 1 # +1 for the center point
  end

  def draw
    image.draw(pos_x - radius, pos_y - radius, 0)
  end

  def move
    @pos_x += dir_x * speed
    @pos_y += dir_y * speed
  end

  def image
    @image ||= Gosu::Image.new(@rmagick_image)
  end

  def bounce_from_top
    @dir_y *= -1
  end

  def bounce_from_left
    @dir_x *= -1
  end

  alias_method :bounce_from_bottom, :bounce_from_top
  alias_method :bounce_from_right, :bounce_from_left

  private
  def generate_rmagick_image
    @rmagick_image = Magick::Image.new(diameter, diameter) { self.background_color = 'none' }

    pen = Magick::Draw.new
    pen.fill(color).circle(radius, radius, 0, radius)
    pen.draw(@rmagick_image)
  end

  def set_ball_direction
    angle_deg = Random.rand(360) # 360 degrees in a circle
    angle_rad = angle_deg * Math::PI / 180
    @dir_x = Math.cos(angle_rad)
    @dir_y = Math.sin(angle_rad)
  end
end
