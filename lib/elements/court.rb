class Court
  attr_reader :width, :height, :bg_color, :line_color, :wall_thickness, :center_thickness

  def initialize(window)
    @width = window.width
    @height = window.height
    @bg_color = Settings::Court::BG_COLOR
    @line_color = Settings::Court::LINE_COLOR
    @wall_thickness = Settings::Court::WALL_THICKNESS
    @center_thickness = Settings::Court::CENTER_THICKNESS
    generate_rmagick_image
  end

  # Draw in upper left corner by default
  def draw(x=0, y=0, z=0)
    image = Gosu::Image.new( @rmagick_image)
    image.draw(x, y, z)
  end

  private
  def generate_rmagick_image
    court = self
    image = Magick::Image.new(width, height) { self.background_color = court.line_color }

    pen = Magick::Draw.new

    draw_inner_rectangle(pen)
    draw_center_line(pen)

    # Draw details in image
    pen.draw(image)

    @rmagick_image = image
  end

  def draw_inner_rectangle(pen)
    pen.stroke(bg_color)

    corners = [
      wall_thickness + 1,         # Upper left x
      wall_thickness + 1,         # Upper left y
      width - wall_thickness - 1, # Lower right x
      height - wall_thickness - 1  # Lower right y
    ]

    pen.rectangle(*corners)
  end

  def draw_center_line(pen)
    pen.stroke(line_color).stroke_width(center_thickness)
    pen.line(width/2, 0, width/2, height)
  end
end
