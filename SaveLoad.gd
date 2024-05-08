# This script manages saving, loading, updating, and resetting game data using JSON format.

extends Node

static var json = JSON.new()	# Initialize JSON parser
static var path = "user://data.json"	# File path for saving data

var default_data = {	# Default data to be used if no save file is found
	"completed_tasks": []
}

var save_data = default_data	# Initialize default data
var logging:bool = true		# Toggles all debug print statements (turn off when exporting)


func _ready():
	load_game()		# Load the game data when the game starts


# Save the game data to a file
func save_game():
	print(save_data)
	var file = FileAccess.open(path, FileAccess.WRITE)
	# Convert save_data dictionary to JSON string and write it to the file
	file.store_line(json.stringify(save_data, "\t"))
	file.close()
	log_info("Data Saved!")


# Load the game data from a file
func load_game():
	var file = FileAccess.open(path, FileAccess.READ)
	# Check if the file exists or is empty
	if file == null or file.get_length() < 1:
		# If no save file exists, save the default data
		log_info("Save File Not Found! Creating one...")
		save_game()
		file = FileAccess.open(path, FileAccess.READ)
	
	# Parse the JSON string from the file and store it as save_data
	save_data = json.parse_string(file.get_as_text())
	file.close()
	log_info("Data Loaded!")
	return save_data


# Update a specific key in the game data dictionary
func update_data(key:String, value):
	if save_data[key] is Array:
		var current_array:Array = save_data[key]
		current_array.append(value)
		save_data[key] = current_array
		print("appending")
	else:
		# Update the value associated with the specified key
		save_data[key] = value
	log_info("Data Updated!")
	save_game()
	

# Retrieve a value from the game data dictionary based on a key
func get_data(key):
	return save_data[key]


# Reset the game data to its default values
func reset_data():
	save_data = default_data
	log_info("Data Reset!")


func log_info(text):
	if logging: print(text)
