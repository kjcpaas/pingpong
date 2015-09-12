class PingpongWindow < Gosu::Window
  def initialize
    super Settings::Game::WIDTH, Settings::Game::HEIGHT
    self.caption = Settings::Game::NAME
  end

  def draw
  end
end
