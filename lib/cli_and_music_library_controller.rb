require 'colorize'
class MusicLibraryController
  attr_reader(:path)
  attr_accessor(:music_importer)

  def initialize(path = './db/mp3s')
    @music_importer = MusicImporter.new(path)
    @music_importer.import
  end

  def call
    puts cli_start
    loop do
      prompt
      user_input = gets.chomp
      break if user_input == 'exit'
      check_input(user_input) ? send(cli_options[user_input]) : undefined
    end
  end

  def cli_start

    "
    =*=*=*=*=*=*=*=*=*=*=*=*=
          Music Library
    =*=*=*=*=*=*=*=*=*=*=*=*=
    ".cyan
  end

  def cli_commands
    puts "Commands:
    1. list songs\t #lists all songs
    2. list genres\t #lists all genres
    3. list genre\t #lists a particular genre
    4. list artist\t #lists a particular artist
    5. play song\t #play a particular song
    6. home\t #go to the home screen

    exit\t #exit Music Library
    ".green
  end

  def prompt
    print '<Groove>'
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

  def check_input(input)
    cli_options.include? input
  end

  def list_songs
    Song.all.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    Artist.all.each {|artist| puts artist.name.to_s}
  end

  def list_genres
    Genre.all.each {|genre| puts genre.name.to_s}
  end

  def play_song
    puts 'Enter a number to play '
    song_number = gets.chomp
    song = Song.all[song_number.to_i - 1]
    if song
      puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
    else
      puts "The song number #{song_number} could not be found"
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
      puts "#{genre} not found"
    end
  end

  def list_artist
    print 'Enter an artist to list '
    artist = gets.chomp
    artists = Artist.find_by_name(artist)
    if artists
      artists.songs.each{ |song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}" }
    else
      puts "#{artist} not found"
    end
  end

  def undefined
    puts "Command not found!!".yellow
    cli_commands
  end
end
# ms = MusicLibraryController.new('.\spec\fixtures\mp3s')
# ms.call
