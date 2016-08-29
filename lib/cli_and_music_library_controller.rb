class MusicLibraryController
  attr_accessor :view

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
    @view = MusicLibraryView.new
  end

  def call
    view.cli_start
    view.cli_commands
    application_loop
  end

  def application_loop
    loop do
      view.prompt
      user_input = gets.chomp.strip
      break if user_input == "exit"
      check_input(user_input)
    end
  end

  def check_input(command)
    if cli_options.include? command
      check_for_additional_input(command)
      send(cli_options[command])
    else
      view.undefined
    end
  end

  def check_for_additional_input(command)
    song_object = ""
    exit if command == "exit"
    if command == "play song"
      song_object = "song number"
    else
      song_object = command.gsub("list ", "")
    end
    view.follow_up_question(song_object)
  end

  def cli_options
    {
      'list songs' => :list_songs,
      'list artists' => :list_artists,
      'list genres' => :list_genres,
      'play song' => :play_song,
      'list artist' => :list_artist,
      'list genre' => :list_genre,
      'help' => :cli_commands
    }
  end

  def list_songs
    view.list_songs
  end

  def list_artists
    view.list_artists
  end

  def list_genres
    view.list_genres
  end

  def play_song
    song = check_song_number
    view.playing_song(song)
  end

  def list_genre
    view.songs_by_category(Genre.find_by_name(gets.chomp.strip))
  end

  def list_artist
    view.songs_by_category(Artist.find_by_name(gets.chomp.strip))
  end

  def check_song_number
    begin
      song_number = Integer(gets.chomp.strip)
    rescue
      exit if song_number == "exit"
      view.follow_up_question("a valid integer")
      retry
    end
    get_song(song_number)
  end

  def get_song(song_number)
    if song_number > 0
      Song.all[song_number.to_i - 1]
    else
      view.follow_up_question("a valid integer")
      check_song_number
    end
  end
end
