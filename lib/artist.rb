class Artist < Base

  attr_accessor :name
  attr_reader :songs
  @all = []

  def initialize(name)
    super(name)
    @songs = []
  end

  def add_song(song)
    super(song)
    song.artist = self unless song.artist
  end

  def genres
    @songs.map(&:genre).uniq
  end
end
