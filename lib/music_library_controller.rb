class MusicLibraryController
  attr_accessor :cli

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
    @cli = CLI.new
  end

  def call
    cli.start
    cli.commands
    application_loop
  end

  def application_loop
    loop do
      cli.prompt
      user_input = gets.chomp.strip
      break if user_input == "exit"
      check_input(user_input)
    end
  end

  def check_input(command)
    if options.include? command
      check_for_additional_input(command)
      send(options[command])
    else
      cli.undefined
    end
  end

  def check_for_additional_input(command)
    return if ["list songs", "list artists", "list genres", "stop song"] \
              .include? command
    song_object = if command == "play song"
      "song number"
    else
      command.gsub("list ", "")
    end
    cli.follow_up_prompt(song_object)
  end

  def options
    {
      'list songs' => :list_songs,
      'list artists' => :list_artists,
      'list genres' => :list_genres,
      'play song' => :play_song,
      'list artist' => :list_artist,
      'list genre' => :list_genre,
      'stop song' => :stop_song
    }
  end

  def list_songs
    cli.list_songs
  end

  def list_artists
    cli.list_artists
  end

  def list_genres
    cli.list_genres
  end

  def list_genre
    cli.songs_by_category(Genre.find_by_name(gets.chomp.strip))
  end

  def list_artist
    cli.songs_by_category(Artist.find_by_name(gets.chomp.strip))
  end

  def play_song
    song = check_song_number
    cli.playing_song(song)
    cli.play_song_for_real
  end

  def check_song_number
    begin
      song_number = Integer(gets.chomp.strip)
    rescue ArgumentError
      exit if song_number == "exit"
      cli.follow_up_prompt("a valid integer")
      retry
    end
    get_song(song_number)
  end

  def get_song(song_number)
    if song_number > 0
      Song.all[song_number.to_i - 1]
    else
      cli.follow_up_prompt("a valid integer")
      check_song_number
    end
  end

  def stop_song
    cli.stop_song
  end
end
