# MusicImporter class that imports a song from a file
class MusicImporter
  attr_accessor(:path)

  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(@path).sort[2..-1]
  end

  def import
    files.each {|file| Song.create_from_filename(file)}
  end
end
