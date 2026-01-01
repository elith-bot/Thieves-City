extends Node

const SAVE_FILE = "user://thieves_city_save.json"
const SETTINGS_FILE = "user://thieves_city_settings.json"

# Save data structure
var save_data = {
	"global_wallet": 0,
	"total_matches": 0,
	"total_earnings": 0,
	"best_rank": 1,
	"owned_skins": ["skin_red"],  # Default skin
	"active_skin": "skin_red",
	"purchased_upgrades": [],
	"active_upgrades": {},
	"last_played": 0
}

var settings_data = {
	"volume": 1.0,
	"music_enabled": true,
	"sfx_enabled": true,
	"difficulty": "normal",
	"language": "en"
}

func _ready():
	load_game()

func save_game():
	"""Save game data to file"""
	var file = File.new()
	if file.open(SAVE_FILE, File.WRITE) != OK:
		print("Error saving game data")
		return
	
	file.store_line(to_json(save_data))
	file.close()
	print("Game saved successfully")

func load_game():
	"""Load game data from file"""
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		print("No save file found, creating new game")
		save_game()
		return
	
	if file.open(SAVE_FILE, File.READ) != OK:
		print("Error loading game data")
		return
	
	var json_string = file.get_as_text()
	file.close()
	
	var loaded_data = parse_json(json_string)
	if loaded_data:
		save_data = loaded_data
		print("Game loaded successfully")
	else:
		print("Error parsing save file")

func save_settings():
	"""Save settings to file"""
	var file = File.new()
	if file.open(SETTINGS_FILE, File.WRITE) != OK:
		print("Error saving settings")
		return
	
	file.store_line(to_json(settings_data))
	file.close()
	print("Settings saved successfully")

func load_settings():
	"""Load settings from file"""
	var file = File.new()
	if not file.file_exists(SETTINGS_FILE):
		print("No settings file found, using defaults")
		save_settings()
		return
	
	if file.open(SETTINGS_FILE, File.READ) != OK:
		print("Error loading settings")
		return
	
	var json_string = file.get_as_text()
	file.close()
	
	var loaded_data = parse_json(json_string)
	if loaded_data:
		settings_data = loaded_data
		print("Settings loaded successfully")
	else:
		print("Error parsing settings file")

func update_global_wallet(amount):
	"""Update global wallet"""
	save_data.global_wallet = amount
	save_game()

func update_match_stats(earnings, rank):
	"""Update match statistics"""
	save_data.total_matches += 1
	save_data.total_earnings += earnings
	if rank < save_data.best_rank:
		save_data.best_rank = rank
	save_data.last_played = OS.get_unix_time()
	save_game()

func purchase_skin(skin_id):
	"""Add skin to owned skins"""
	if not skin_id in save_data.owned_skins:
		save_data.owned_skins.append(skin_id)
		save_game()

func set_active_skin(skin_id):
	"""Set active skin"""
	if skin_id in save_data.owned_skins:
		save_data.active_skin = skin_id
		save_game()

func get_save_data():
	"""Get save data"""
	return save_data

func get_settings_data():
	"""Get settings data"""
	return settings_data

func set_setting(setting_name, value):
	"""Set a setting"""
	if setting_name in settings_data:
		settings_data[setting_name] = value
		save_settings()

func delete_save():
	"""Delete save file"""
	var file = File.new()
	if file.file_exists(SAVE_FILE):
		file.open(SAVE_FILE, File.READ)
		file.close()
		# In Godot, we can't directly delete, but we can reset
		save_data = {
			"global_wallet": 0,
			"total_matches": 0,
			"total_earnings": 0,
			"best_rank": 1,
			"owned_skins": ["skin_red"],
			"active_skin": "skin_red",
			"purchased_upgrades": [],
			"active_upgrades": {},
			"last_played": 0
		}
		save_game()
		print("Save file deleted")
