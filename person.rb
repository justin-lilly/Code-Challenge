class Person
	#allows access to the value of name and worth
	attr_reader :name
	attr_reader :worth
	attr_reader :id_number
	
	#defines initialize class to set a name a worth
	def initialize ( name, worth=0, id_number)
		@name = name
		@worth = worth
		@id_number = id_number
		
		puts "Hello #{name}! Your ID# is #{@id_number}. You are holding $#{worth}."
	end

end