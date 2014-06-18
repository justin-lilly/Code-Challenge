require 'fox16'
include Fox

require '.\person'
require '.\banking'

class ButtonControl < FXMainWindow

	def initialize
		@control = nil
	end

	def create_person(app)
		new_name = FXInputDialog.getString("NAME", app, "New Person", "Name:")
		new_amount = FXInputDialog.getString("0", app, "New Person", "Amount:")
		
		begin
		id_number = 1_000_000_000 + rand(10_000_000_000)
		end while $person_list[id_number] != nil

		$person_list[id_number] = Person.new(new_name, new_amount.to_f, id_number)
	end

	def create_bank(app)
		new_bank_name = FXInputDialog.getString("NAME", app, "New Bank", "Bank name:")
			if $bank_list.include? 'new_bank_name'
				prints "Bank already exists."
			else
				$bank_list[new_bank_name] = Banking.new(new_bank_name)
			end
	end

	def account_open(app)
		bank_name = FXInputDialog.getString("NAME", app, "Open Account", "Name of Bank:")
		account_id = FXInputDialog.getString("xxxxxxxxxx", app, "Open Account", "ID Number:")
		if $bank_list[bank_name] == nil
			puts "Bank does not exist."
		elsif $person_list[account_id.to_i] == nil
			puts "ID number does not exist."
		else
			$bank_list[bank_name].open($person_list[account_id.to_i])
		end
	end

	def exit_app
		exit
	end

end
