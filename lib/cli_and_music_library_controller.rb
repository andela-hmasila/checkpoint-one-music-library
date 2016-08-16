class MusicLibraryController

  attr_reader(:path)
  def initialize (path = "./db/mp3s")
    self.path = path if path
  end

  def path=(file_path)
    @path = file_path
    @music_importer = MusicImporter.new(file_path)
    @music_importer.import
  end

  def call
    puts "Kindly enter a command"
    input = gets.chomp.downcase!
    if cli_options.include? input
      send(cli_options[input])
    else
      self.undefined
    end
  end


  def cli_options
    {
      'list songs' => :list_songs,
      'list artists' => :list_artists,
      'list genres' => :list_genres,
      'play song' => :play_song,
      'list artist' => :list_artist,
      'list genre' => :list_genre,
      'exit' => :exit
    }
  end
  def list_songs
    Song.all.each.with_index(1) do |song, idx|
     puts "#{idx}. #{song}".colorize(:light_blue)
  #  @music_importer.import
  end
end
  def list_artists
    Artist.all
  end
  def list_genres
    Artist.all
  end
  def undefined
    puts "I did not understand you"
  end

  def cli_start
    "
    ========================
          Ruby Muse
    ========================
    ".colorize(:cyan)
    " Commands:
    1.) list songs # lists all songs
    2.) list artists # lists all artists
    3.) list genres # lists all genres
    4.) list genre # lists a particular genre
    5.) list artist # lists a particular artist
    6.) play song # play a particular song

    exit # quit Ruby Muse
    ".colorize(:green)
    puts call
  end


end
