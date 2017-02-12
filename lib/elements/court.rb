class Court
  attr_reader :width, :height
  # From settings
  attr_reader :bg_color, :line_color, :wall_thickness, :center_thickness
  # Calculated
  attr_reader :left_x, :right_x, :top_y, :bottom_y

  def initialize(window)
    @width = window.width
    @height = window.height
    @bg_color = Settings::Court::BG_COLOR
    @line_color = Settings::Court::LINE_COLOR
    @wall_thickness = Settings::Court::WALL_THICKNESS
    @center_thickness = Settings::Court::CENTER_THICKNESS
    @left_x = wall_thickness
    @right_x = width - wall_thickness - 1
    @top_y = wall_thickness
    @bottom_y = height - wall_thickness - 1
    generate_rmagick_image
  end

  # Draw in upper left corner by default
  def draw(x=0, y=0, z=0)
    image.draw(x, y, z)
  end

  def image
    @image ||= Gosu::Image.new(@rmagick_image)
  end

  private
  def generate_rmagick_image
    court = self
    @rmagick_image = Magick::Image.new(width, height) { self.background_color = court.line_color }

    pen = Magick::Draw.new

    draw_inner_rectangle(pen)
    draw_center_line(pen)

    # Draw details in image
    pen.draw(@rmagick_image)
  end

  def draw_inner_rectangle(pen)
    pen.stroke(bg_color)

    corners = [
      left_x,         # Upper left x
      top_y,         # Upper left y
      right_x, # Lower right x
      bottom_y  # Lower right y
    ]

    pen.rectangle(*corners)
  end

  def draw_center_line(pen)
    pen.stroke(line_color).stroke_width(center_thickness)
    pen.line(width/2, 0, width/2, height)
  end
end
