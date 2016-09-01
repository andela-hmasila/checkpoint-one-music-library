require 'colorize'
class CLI
  $song_path = "./db/Adele_Send_My_Love_To_Your_New_Lover.mp3"
  def start
    puts "
    =*=*=*=*=*=*=*=*=*=*=*=*=
       Groove On
    =*=*=*=*=*=*=*=*=*=*=*=*=
    ".cyan
    commands
  end

  def commands
    puts "Commands:
    1. list songs\t #lists all songs
    2. list genres\t #lists all genres
    3. list artists\t #lists a artists
    4. list artist\t #lists a particular artist
    5. list genre\t #lists a particular genre
    6. play song\t #play a particular song
    7. stop song\t #stops the song that is playing
    exit\t #exit Music Library
    ".green
  end

  def prompt
    print "<Groove>".cyan
  end

  def undefined
    puts "Command not found!!".red
    commands
  end

  def list_songs(song, index)
    puts "#{index + 1}. #{song.artist.name} - #{song.name}" \
      " - #{song.genre.name}".light_blue
  end

  def list_artists(artist)
    puts artist.name.to_s.light_blue
  end

  def list_genres(genre)
    puts genre.name.to_s.light_blue
  end

  def songs_by_category(song)
    puts "#{song.artist.name} - #{song.name} - #{song.genre.name}".light_blue
  end

  def playing_song(song)
    puts "Playing #{song.artist.name} - #{song.name}" \
      " - #{song.genre.name}".light_blue
  end

  def follow_up_prompt(additional_input)
    puts "Kindly Enter #{additional_input}".yellow
  end

  def not_found(user_input)
    puts "#{user_input} not found".red
  end
end
