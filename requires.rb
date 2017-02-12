require 'gosu'
require 'rmagick'

Dir.glob('lib/**/*.rb').each do |filename|
  require_relative filename
end
