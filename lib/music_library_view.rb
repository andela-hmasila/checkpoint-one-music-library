require 'colorize'
class MusicLibraryView
  def cli_start
    puts "
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

  def undefined
    puts "Command not found!!".red
    cli_commands
  end

  def list_songs
    Song.all.each_with_index do |song, index|
       puts "#{index + 1}. #{song.artist.name} - #{song.name}" \
       " - #{song.genre.name}".light_blue
    end
  end

  def list_artists
    Artist.all.each { |artist| puts artist.name.to_s.light_blue }
  end

  def list_genres
    Genre.all.each { |genre| puts genre.name.to_s.light_blue }
  end

  def play_song
    song = check_for_integer
    if song
      puts "Playing #{song.artist.name} - #{song.name}" \
      " - #{song.genre.name}".light_blue
    else
      puts "The song number could not be found".red
    end
  end

  def songs_by_genre
    print "Enter a genre to list ".green
    genre = Genre.find_by_name(gets.chomp.strip)
    if genre
      genre.songs.each do |song|
        puts "#{song.artist.name} - #{song.name}" \
        " - #{song.genre.name}".light_blue
      end
    else
      puts "Genre not found".red
    end
  end

  def songs_by_artist
    print "Enter an artist to list ".green
    artist = Artist.find_by_name(gets.chomp.strip)
    if artist
      artist.songs.each do |song|
        puts "#{song.artist.name} - #{song.name}" \
        " - #{song.genre.name}".light_blue
      end
    else
      puts "Artist not found".red
    end
  end

  def check_for_integer
    print "Enter a number to play ".green
    begin
      song_number = Integer(gets.chomp.strip)
    rescue
      puts "Kindly enter an integer".red
      retry
    end
    Song.all[song_number.to_i - 1]
  end
end
