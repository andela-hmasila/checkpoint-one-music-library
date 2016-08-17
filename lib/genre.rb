# Genre class that initializes a genre and its properties
class Genre
  extend Concerns::Findable

  attr_accessor(:name)
  attr_reader(:songs)
  # @@all is a class variable that saves all instances of the Song class
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  # a custom constructor that instantiates a genre instance and saves it
  def self.create(name)
    Genre.new(name).save
  end

  # saves the instance
  def save
    @@all << self
    self
  end

  # returns all the saved instances
  def self.all
    @@all
  end

  # emptys @@all
  def self.destroy_all
    @@all = []
  end

  def add_song(song)
    @songs << song unless @songs.include? song
    song.genre = self unless song.genre
  end

  def artists
    genre_artists = []
    @songs.each do |song|
      genre_artists << song.artist unless genre_artists.include? song.artist
    end
    genre_artists
  end
end
