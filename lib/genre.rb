class Genre
  extend Concerns::Findable

  attr_accessor(:name)
  attr_reader(:songs)
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.create(name)
    Genre.new(name).save
  end

  def save
    @@all << self
    self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def add_song(song)
    @songs << song unless @songs.include? song
    song.genre = self unless song.genre
  end

  def artists
    @songs.map(&:artist).uniq
   end
end
