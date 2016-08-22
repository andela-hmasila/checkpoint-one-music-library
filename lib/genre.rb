class Genre
  extend Concerns::Findable
  extend Concerns::Base_functions

  attr_accessor(:name)
  attr_reader(:songs)
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
    song.genre = self unless song.genre
  end

  def artists
    @songs.map(&:artist).uniq
   end
end
