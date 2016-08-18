class Artist
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.create(name)
    Artist.new(name).save
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
    song.artist = self unless song.artist
  end

  def genres
    artist_genres = []
    @songs.each do |song|
      artist_genres << song.genre unless artist_genres.include? song.genre
    end
    artist_genres
  end
end
