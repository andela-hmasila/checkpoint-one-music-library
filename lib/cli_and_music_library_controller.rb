require 'colorize'
class MusicLibraryController
  attr_accessor :view

  def initialize(path = './db/mp3s')
    MusicImporter.new(path).import
    @view = MusicLibraryView.new
  end

  def call
    puts view.cli_start
    check_input
  end

  def cli_options
    {
      'list songs' => :list_songs,
      'list artists' => :list_artists,
      'list genres' => :list_genres,
      'play song' => :play_song,
      'list artist' => :list_artist,
      'list genre' => :list_genre,
      'home' => :cli_commands
    }
  end

  def check_input
    loop do
      view.prompt
      user_input = gets.chomp
      break if user_input == 'exit'
      if cli_options.include? user_input
        send(cli_options[user_input])
      else
        view.undefined
      end
    end
  end

  def list_songs
    Song.all.each_with_index do |song, index|
       puts "#{index + 1}. #{song.artist.name} - #{song.name}" \
       " - #{song.genre.name}".green
    end
  end

  def list_artists
    Artist.all.each { |artist| puts artist.name.to_s }
  end

  def list_genres
    Genre.all.each { |genre| puts genre.name.to_s }
  end

  def play_song
    song = check_for_integer
    if song
      puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
    else
      puts "The song number could not be found"
    end
  end

  def list_genre
    print 'Enter a genre to list '
    genre = gets.chomp
    genres = Genre.find_by_name(genre)
    if genres
      genres.songs.each do |song|
        puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
      end
    else
      puts "Genre not found"
    end
  end

  def list_artist
    print 'Enter an artist to list '
    artist = Artist.find_by_name(gets.chomp)
    if artist
      artist.songs.each do |song|
        puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
      end
    else
      puts "Artist not found"
    end
  end

  def check_for_integer
    print "Enter a number to play "
    begin
      song_number = Integer(gets.chomp)
    rescue
      puts "Kindly enter an integer"
      retry
    end
    Song.all[song_number.to_i - 1]
  end
end
