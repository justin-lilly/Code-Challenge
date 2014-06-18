class Banking
	attr_reader :bank_name
	
	#defines initialize class to set bank name and create a listing hash
	def initialize (bank_name)
		@bank_name = bank_name
		@bank_listing = Hash.new
		puts "Welcome aboard #{bank_name}."
	end
	
	#opens an account and places persons name and worth in hash
	def open ( person )
		@bank_listing[person.id_number] = {:name => person.name, :balance => 0}
		puts "#{@bank_name}:Thank you for joining, #{person.name}! Your balance is currently #{@bank_listing[person.id_number][:balance]}!"
	end
	
	#allows money to be removed from the account without over draw
	def withdraw ( person, amount )
		if @bank_listing[person.id_number][:balance] >= amount
			@bank_listing[person.id_number][:balance]-=amount
			puts "#{@bank_name}: Thanks #{person.name}, here's your $#{amount}. Your current balance is $#{@bank_listing[person.id_number][:balance]}."
		else
			puts "#{@bank_name}: Sorry #{person.name}, insufficient funds."
		end
	end
	
	#allows addition of money to an account
	def deposit ( person, amount )
		if person.worth >= amount
		@bank_listing[person.id_number][:balance]+=amount
		puts "#{@bank_name}: Thanks #{person.name}, you deposited #{amount}. Your current balance is $#{@bank_listing[person.id_number][:balance]}."
		else
			puts "#{@bank_name}: Sorry, you don't have enough on hand."
		end
	end
	
	#removes money from current bank account and calls deposit method for another bank
	def transfer ( bank, person, amount)
		if @bank_listing[person.id_number][:balance] >= amount
			@bank_listing[person.id_number][:balance]-=amount
			puts "#{@bank_name}: #{person.name}, your transfer of #{amount} to #{bank.bank_name} is complete."
			bank.deposit(person, amount)
		else
			puts "#{@bank_name}: Sorry #{person.name}, insufficient funds."
		end
			
	end
	
	def balance (person)
		puts "#{@bank_name}: #{person.name}, your current balance is $#{@bank_listing[person.id_number][:balance]}."
	end
	
	def bank_total
		@total=0
		@bank_listing.each{|id, information| @total+=information[:balance]}
		puts "#{@bank_name}: The bank total is $#{@total}."
	end
	
	#prints listing of current bank hash bank_listing
	# hash format [id_number] = {[ name, account_balance, cc_number, cc_limit ]}
	def bank_information
		puts "\n-- #{@bank_name}--"
		@bank_listing.each { |id, info| puts "Account #: #{id} \nAccount Holder: #{info[:name]} \nAccount Balance: #{info[:balance]} \nCredit card number: #{info[:cc_number]} \nCredit card limit: #{info[:cc_limit]} \nCredit card balance: #{info[:cc_spent]}\n\n" }
		
	end
	
	############################################ Begining of credit card system #####################################################################
	
	#opens a credit card on person account with proper limit
	def open_cc (person, cc_limit)
		
		#not quite robust yet
		case cc_limit.downcase
			when "silver"
				@cc_limit = 2_000
			when "gold" 
				@cc_limit = 3_000
			when "platinum"
				@cc_limit = 5_000
			when "black"
				@cc_limit = 10000000000000000000000000
			else
				@cc_limit = 1_000
		end
		
		if @bank_listing[person.id_number][:cc_number] == nil
			@bank_listing[person.id_number][:cc_number] = 1234  #used for testing withdraw
			#@bank_listing[person.id_number][:credit] = 1_000_000_000_000_000 + rand(10_000_000_000_000_000)
			@bank_listing[person.id_number][:cc_limit] = @cc_limit
			@bank_listing[person.id_number][:cc_spent] = 0

			#@bank_listing[person.id_number][:credit_limit] = @cc_limit
			puts "#{@bank_name}: Thanks for opening up a #{cc_limit.capitalize} level credit card, #{person.name}. Your limit is $#{@cc_limit}." 
			puts "#{@bank_name}: Your credit card number is: #{@bank_listing[person.id_number][:cc_number]}."
		else
			puts "#{@bank_name}: #{person.name} already has a credit card."
		end
	end
	
	#allows purchases with credit card
	def cc_purchase (person, cc_number, amount)
		if @bank_listing[person.id_number][:cc_spent] < @bank_listing[person.id_number][:cc_limit] && cc_number == @bank_listing[person.id_number][:cc_number]
			@bank_listing[person.id_number][:cc_spent]+=amount
			puts "#{@bank_name}: Card accepted."
		else
			puts "#{@bank_name}: Card has been declined."
		end
	end
	
	#payment for card
	def cc_payment (person, cc_number, amount)
		if cc_number == @bank_listing[person.id_number][:cc_number]
			@bank_listing[person.id_number][:cc_spent]-= amount
			puts "#{@bank_name}: Thank you for the payment #{person.name}, your new credit card balance is $#{@bank_listing[person.id_number][:cc_spent]}"
		else
			puts "#{@bank_name}: Invalid credit card number."
		end
	end
	
	#view balance
	def cc_balance (person, cc_number)
		if cc_number == @bank_listing[person.id_number][:cc_number]
			puts "#{@bank_name}: Your current credit card balance is $#{@bank_listing[person.id_number][:cc_spent]}."
		else
			puts "#{@bank_name}: Invalid credit card number."
		end
	end
	
end