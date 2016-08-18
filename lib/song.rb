class Song
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.genre = genre if genre
    self.artist = artist if artist
  end

  def self.create(name, artist = nil, genre = nil)
    new(name, artist, genre).save
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
    new_from_filename(filename).save
  end
end
