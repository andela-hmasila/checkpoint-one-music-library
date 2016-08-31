require 'colorize'
class CLI
  $song_path = "./db/Adele_Send_My_Love_To_Your_New_Lover.mp3"
  def start
    puts "
    =*=*=*=*=*=*=*=*=*=*=*=*=
       Groove On
    =*=*=*=*=*=*=*=*=*=*=*=*=
    ".cyan
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
    print '<Groove>'.cyan
  end

  def undefined
    puts "Command not found!!".red
    commands
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

  def play_song_for_real
    @pid = fork { exec 'afplay', $song_path }
  end

  def stop_song
    if process_running?
      fork { exec 'killall afplay' }
    else
      puts "Play song first!".red
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

  def follow_up_prompt(song_object)
    puts "Kindly Enter #{song_object}".yellow
  end

  def object_not_found(song_object)
    puts "#{song_object} not found".red
  end

  def process_running?
    return true if @pid
    false
  end
end
