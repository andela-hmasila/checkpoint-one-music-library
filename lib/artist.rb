class Artist

  extend Concerns::Findable

  attr_accessor(:name)
  attr_reader(:songs)
  #@@all is a class variable that saves all instances of the Song class
  @@all = []

	def initialize(name)
	  @name = name
    @songs = []
  end

  #a custom constructor that instantiates an instance using .new and saves that instance
  def self.create(name)
    Artist.new(name).save
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
#def songs=(song)
#  add_song song
#end
  def add_song(song)
    @songs << song unless @songs.include? song
    song.artist = self unless song.artist
  end

  def genres
    song_genres = []
    @songs.each do |song|
      song_genres << song.genre unless song_genres.include? song.genre
    end
    song_genres
  end

end
