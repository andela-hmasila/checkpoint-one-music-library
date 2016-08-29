class Artist
  extend Concerns::Findable
  extend Concerns::BaseFunctions
  include Concerns::MusicStoreActions

  attr_accessor :name
  attr_reader :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    add_current_song(song)
    song.artist = self unless song.artist
  end

  def genres
    @songs.map(&:genre).uniq
  end
end
