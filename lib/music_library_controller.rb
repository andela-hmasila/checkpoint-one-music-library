class MusicLibraryController
  attr_accessor :cli

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
    @cli = CLI.new
  end

  def call
    cli.start
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
    send(command.tr(" ", "_"))
    rescue NoMethodError
      cli.undefined
  end

  def list_songs
    Song.all.each_with_index do |song, index|
      cli.list_songs(song, index)
    end
  end

  def list_artists
    Artist.all.each { |artist| cli.list_artists(artist) }
  end

  def list_genres
    Genre.all.each { |genre| cli.list_genres(genre) }
  end

  def list_genre
    cli.follow_up_prompt("a genre")
    genre = gets.chomp.strip
    songs_by_category(Genre.find_by_name(genre)) || cli.not_found(genre)
  end

  def list_artist
    cli.follow_up_prompt("an artist")
    artist = gets.chomp.strip
    songs_by_category(Artist.find_by_name(artist)) || cli.not_found(artist)
  end

  def songs_by_category(category)
    if category
      category.songs.each do |song|
        cli.songs_by_category(song)
      end
    end
  end

  def play_song
    cli.follow_up_prompt("a song number to play")
    song = check_song_number
    if song
      cli.playing_song(song)
      play_song_for_real
    else
      cli.not_found("song")
    end
  end

  def check_song_number
    song_number = Integer(gets.chomp.strip)
    if (1..Song.all.length).cover? song_number
      Song.all[song_number.to_i - 1]
    end
    rescue ArgumentError
      cli.follow_up_prompt("a valid integer")
      retry
  end

  def play_song_for_real
    @process_id = fork { exec 'afplay', $song_path }
  end

  def stop_song
    if process_running?
      fork { exec 'killall afplay' }
    else
      cli.follow_up_prompt("a song to play first")
    end
  end

  def process_running?
    return true if @process_id
    false
  end
end
