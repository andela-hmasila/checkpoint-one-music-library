# MusicLibraryController that contains the CLI and controllers
class MusicLibraryController
  attr_reader(:path)
<<<<<<< HEAD
=======

>>>>>>> master
  def initialize(path = './db/mp3s')
    self.path = path if path
  end

  def path=(file_path)
    @path = file_path
    @music_importer = MusicImporter.new(file_path)
    @music_importer.import
  end

  def call
    puts cli_start
    input = ''
<<<<<<< HEAD

    while input != 'exit'
      input = gets.chomp

    if cli_options.include? input
      send(cli_options[input])
    elsif input == 'help'
      puts cli_commands
    else
      puts undefined
      break if input == 'exit'

=======
    while input != 'exit'
      input = gets.chomp
      if cli_options.include? input
        send(cli_options[input])
      elsif input == 'help'
        puts cli_commands
      else
        puts undefined
        break if input == 'exit'
      end
>>>>>>> master
    end
  end

  def cli_start
    "
    =*=*=*=*=*=*=*=*=*=*=*=*=
          Music Library
    =*=*=*=*=*=*=*=*=*=*=*=*=
    "
  end

  def cli_commands
    "Commands:
    1. list songs\t #lists all songs
    2. list genres \t #lists all genres
    3. list genre \t #lists a particular genre
    4. list artist \t #lists a particular artist
    5. play song \t #play a particular song
    exit\t #exit Music Library
    "
  end

  end
  def cli_start
    "
    ========================
          Music Library
    ========================
    "
  end
  def cli_commands
    "Commands:
    1. list songs\t #lists all songs
    2. list genres\t #lists all genres
    3. list genre\t #lists a particular genre
    4. list artist\t #lists a particular artist
    5. play song\t #play a particular song

    exit\t #quit Ruby Muse
    "
  end

  def cli_options
    {
      'list songs' => :list_songs ,
      'list artists' => :list_artists,
      'list genres' => :list_genres,
      'play song' => :play_song,
      'list artist' => :list_artist,
      'list genre' => :list_genre
    }
  end

  def list_songs
    Song.all.each_with_index do |song, idx|
      puts "#{idx + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
<<<<<<< HEAD
    Artist.all.each do
      |artist|
      puts "#{artist.name}"
    end
  end

  def list_genres
    Genre.all.each do
      |genre|
      puts "#{genre.name}"
    end
  end

  def play_song
    puts 'Enter a song to play '
    song_number = gets.chomp

    song = Song.all[song_number.to_i-1]
    puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"

  end

  def list_genre
    print 'Enter a genre to list '
    genre = gets.chomp
    genres = Genre.find_by_name(genre)
    genres.songs.each do |song|
      puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artist
    print 'Enter an artist to list '
    artist = gets.chomp
    artists = Artist.find_by_name(artist)
    artists.songs.each do |song|
      puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def undefined
    'I did not understand you'
=======
    Artist.all.each do |artist|
      puts artist.name.to_s
    end
  end

  def list_genres
    Genre.all.each do |genre|
      puts genre.name.to_s
    end
  end

  def play_song
    puts 'Enter a song to play '
    song_number = gets.chomp
    song = Song.all[song_number.to_i - 1]
    puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
  end

  def list_genre
    print 'Enter a genre to list '
    genre = gets.chomp
    genres = Genre.find_by_name(genre)
    genres.songs.each do |song|
      puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artist
    print 'Enter an artist to list '
    artist = gets.chomp
    artists = Artist.find_by_name(artist)
    artists.songs.each do |song|
      puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def undefined
    puts 'I did not understand you'
    cli_commands
>>>>>>> master
  end
end
