module Settings
  module Game
    NAME = 'Pingpong'
    WIDTH = 1366
    HEIGHT = 768
  end

  module Court
    BG_COLOR = '#000000'
    LINE_COLOR = '#FFFFFF'
    WALL_THICKNESS = 10
    CENTER_THICKNESS = 4
  end

  module Ball
    COLOR = '#FFFFFF'
    RADIUS = 25
    SPEED = 7 # pixels every 1/60 of second
  end
end
