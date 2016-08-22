class Artist
  extend Concerns::Findable
  extend Concerns::Base_functions

  attr_accessor :name
  attr_reader :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    @@all << self
    self
  end

  def add_song(song)
    @songs << song unless @songs.include? song
    song.artist = self unless song.artist
  end

  def genres
    @songs.map(&:genre).uniq
  end
end
