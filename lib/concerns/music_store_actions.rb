module Concerns
  module MusicStoreActions
    def save
      self.class.all << self
      self
    end

    def add_current_song(song)
      @songs << song unless @songs.include? song
    end
  end
end
