class Genre
  extend Concerns::Findable
  extend Concerns::BaseFunctions
  include Concerns::MusicStoreActions

  attr_accessor(:name)
  attr_reader(:songs)
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    add_current_song(song)
    song.genre = self unless song.genre
  end

  def artists
    @songs.map(&:artist).uniq
  end
end
