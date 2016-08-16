module Concerns::Findable
  #Finds all occurences of a name
  def find_by_name(name)
    all.find { |s| s.name == name }
  end

  #checks if the name is found in the array and if not creates it
  def find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

end
