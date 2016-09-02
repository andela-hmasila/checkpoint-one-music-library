class Genre < Base

  attr_accessor(:name)
  attr_reader(:songs)
  @all = []

  def initialize(name)
    super(name)
    @songs = []
  end

  def add_song(song)
    super(song)
    song.genre = self unless song.genre
  end

  def artists
    @songs.map(&:artist).uniq
  end
end
