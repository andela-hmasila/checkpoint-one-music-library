require 'colorize'
class MusicLibraryView
  def cli_start
    "
    =*=*=*=*=*=*=*=*=*=*=*=*=
          Music Library
    =*=*=*=*=*=*=*=*=*=*=*=*=
    ".cyan
  end

  def cli_commands
    "Commands:
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

  def undefined
    puts "Command not found!!".red
    cli_commands
  end
end
