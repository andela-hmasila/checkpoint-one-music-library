#Music Library Application
![Groove on](http://classroom.tis.edu.mo/grade1/wp-content/uploads/sites/4/2016/06/music.jpg)

##Overview

Music Library Application is a Command Line Interface that allows a user to import `.mp3` files from a path. 
The user can then use commands to list all `songs`, `artists` or `genres`. It also allows a user to list songs based on a genre or artist. Lastly, a user can `play a song` ... not literally but a message that the song is playing will be displayed.

##Commands and Features
The commands are:
    
    list songs - lists all the songs in the path
    
    list artists - lists all the artists in the path
    
    list genres - lists all thr genres in the path
    
    list artist - lists all the songs in the path based on the artist given
    
    list genre - lists all the songs in the path based on the genre given
    
    play song - plays the song on the provided number
    
    help - gives the list of commands
    
    exit - exits the program
    
##Instructions for getting started
###Installation

Clone the repo: 
    
    $  git clone https://github.com/andela-hmasila/checkpoint-one-music-library.git

Enter the repo's directory: 
    
    $  cd checkpoint-one-music-library

Install dependancies:
    
    $  bundle install

###Running the application

In the checkpoint-one-music-library directory, run this command
    
    $  bin/musiclibrary
    
###Running the tests

In the checkpoint-one-music-library directory, run this command:
   
`$  bundle exec rspec` for the first time then 

`rspec` after the first time

The application should pass all the 70 tests    

##Creating a similar application

To create a similar application from scratch, follow the instructions [here](https://github.com/andela-hmasila/checkpoint-one-music-library/wiki/Instructions-of-creating-the-music-library-application)

##Limitations:
    
    The files must be saved in ruby-music-library/db/mp3s directory (path) to be recognised by the application
    
    The files MUST be named in the format "artist name" - "song name" - "genre"
    
    You cannot play a song by typing the song name. Type its special (index) number instead.
