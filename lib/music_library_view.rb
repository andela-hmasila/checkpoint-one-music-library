require 'colorize'
class MusicLibraryView
  def cli_start
    puts "
    =*=*=*=*=*=*=*=*=*=*=*=*=
       Groove On 
    =*=*=*=*=*=*=*=*=*=*=*=*=
    ".cyan
  end

  def cli_commands
    puts "Commands:
    1. list songs\t #lists all songs
    2. list genres\t #lists all genres
    3. list artists\t #lists a artists
    4. list artist\t #lists a particular artist
    5. list genre\t #lists a particular genre
    6. play song\t #play a particular song
    exit\t #exit Music Library
    ".green
  end

  def prompt
    print '<Groove>'.cyan
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

  def songs_by_category(category)
    if category
      category.songs.each do |song|
        puts "#{song.artist.name} - #{song.name}" \
        " - #{song.genre.name}".light_blue
      end
    else
      object_not_found(category.to_s)
    end
  end

  def playing_song(song)
    if song
      puts "Playing #{song.artist.name} - #{song.name}" \
      " - #{song.genre.name}".light_blue
    else
      object_not_found("song")
    end
  end
  # TODO:
  # system "afplay `/filename` "
  # implement real playing!!

  def follow_up_question(song_object)
    puts "Kindly Enter #{song_object}".yellow
  end

  def object_not_found(song_object)
    puts "#{song_object} not found".red
  end
end