class MusicLibraryController
  attr_accessor :view

  def initialize(path = './db/mp3s')
    MusicImporter.new(path).import
    @view = MusicLibraryView.new
  end

  def call
    view.cli_start
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
      'help' => :cli_commands
    }
  end

  def check_input
    loop do
      view.prompt
      user_input = gets.chomp.strip
      break if user_input == 'exit'
      if cli_options.include? user_input
        send(cli_options[user_input])
      else
        view.undefined
      end
    end
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

  def list_artist
    view.songs_by_artist
  end

  def list_genre
    view.songs_by_genre
  end

  def play_song
    view.play_song
  end

  def cli_commands
    view.cli_commands
  end
end
