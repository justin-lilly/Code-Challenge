require 'fox16'
require '.\button_control'

include Fox

class MainInterface < FXMainWindow

	def initialize (app)
		super( app, "Banking Application", :width =>600, :height => 400)

		$person_list = Hash.new
		$bank_list = Hash.new

		@control = ButtonControl.new
		control_frame = FXVerticalFrame.new(self, :opts => LAYOUT_FILL_X|LAYOUT_CENTER_Y)

		create_person_button = FXButton.new(control_frame, "Create a person", 
			:opts => BUTTON_NORMAL|LAYOUT_CENTER_X)
		create_person_button.connect(SEL_COMMAND) do |sender, sel, data|
			@control.create_person(app)
		end

		create_bank_button = FXButton.new(control_frame, "Create a bank", 
			:opts => BUTTON_NORMAL|LAYOUT_CENTER_X)
		create_bank_button.connect(SEL_COMMAND) do |sender, sel, data|
			@control.create_bank(app)
		end

		account_open_button = FXButton.new(control_frame, "Open Account", 
			:opts => BUTTON_NORMAL|LAYOUT_CENTER_X)
		account_open_button.connect(SEL_COMMAND) do |sender, sel, data|
			@control.account_open(app)
		end

		exit_app_button = FXButton.new(control_frame, "Exit", 
			:opts => BUTTON_NORMAL|LAYOUT_CENTER_X)
		exit_app_button.connect(SEL_COMMAND) do |sender, sel, data|
			@control.exit_app
		end

	end

	def create
		super
		show( PLACEMENT_SCREEN )
	end

end

if __FILE__ == $0
	FXApp.new do |app|
		MainInterface.new(app)
		app.create
		app.run
	end
end
