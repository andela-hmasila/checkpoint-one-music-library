class Base
  extend Concerns::Findable
	@all = []
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  class << self
    attr_reader :all

    def create(name)
      new(name).save
    end

    def destroy_all
      all.clear
    end
  end

  def save
    self.class.all << self
    self
  end

  def add_song(song)
    @songs << song unless @songs.include? song
  end
end