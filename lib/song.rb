class Song
  extend Concerns::Findable

  attr_accessor(:name)
  attr_reader(:artist, :genre)
  #@@all is a class variable that saves all instances of the Song class
  @@all = []

	def initialize(name, artist = nil, genre = nil)
	  @name = name
    self.genre = genre if genre
    self.artist = artist if artist
  end

  #a custom constructor that instantiates an instance using .new and saves that instance
  def self.create(name, artist = nil, genre = nil)
    Song.new(name, artist, genre).save
  end

  #saves the instance
  def save
    @@all << self
    self
  end

  #returns all the saved instances
  def self.all
    @@all
  end

  #emptys @@all
  def self.destroy_all
    @@all = []
  end

  def genre=(song_genre)
    @genre = song_genre
    song_genre.add_song self
  end

  def artist=(song_artist)
    @artist = song_artist
    song_artist.add_song self
  end

  def self.new_from_filename(filename)
    song_instance = filename[0...-4].split(' - ')
    Song.new(song_instance[1],
    Artist.find_or_create_by_name(song_instance[0]),
    Genre.find_or_create_by_name(song_instance[2]))

  end

  def self.create_from_filename(filename)
    song_instance = filename[0...-4].split(' - ')
    Song.new(song_instance[1],
    Artist.find_or_create_by_name(song_instance[0]),
    Genre.find_or_create_by_name(song_instance[2])).save


  end


end
