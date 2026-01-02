extends Node

# Game Configuration
const MATCH_DURATION = 120  # 120 seconds per match
const NUM_AI_PLAYERS = 30
const LOOT_SPAWN_RATE = 0.5  # Spawn loot every 0.5 seconds

# Game State
var current_match_money = 0
var global_wallet = 0
var is_match_active = false
var match_time_remaining = MATCH_DURATION
var player_rank = 1
var ai_players = []
var loot_items = []

# Signals
signal match_started()
signal match_ended()
signal money_changed(new_amount)
signal rank_changed(new_rank)
signal player_collided(other_player)

func _ready():
	# Initialize game
	load_global_wallet()
	setup_match()

func _process(delta):
	if is_match_active:
		update_match_timer(delta)
		update_leaderboard()

func setup_match():
	"""Initialize a new match"""
	current_match_money = 0
	match_time_remaining = MATCH_DURATION
	is_match_active = true
	match_started.emit()
	print("Match started!")

func update_match_timer(delta):
	"""Update the match timer"""
	match_time_remaining -= delta
	if match_time_remaining <= 0:
		end_match()

func end_match():
	"""End the current match and save earnings"""
	is_match_active = false
	global_wallet += current_match_money
	save_global_wallet()
	match_ended.emit()
	print("Match ended! Total earnings: ", current_match_money)
	print("Global wallet: ", global_wallet)

func add_money(amount):
	"""Add money to current match"""
	current_match_money += amount
	money_changed.emit(current_match_money)

func subtract_money(amount):
	"""Subtract money from current match"""
	current_match_money = max(0, current_match_money - amount)
	money_changed.emit(current_match_money)

func update_leaderboard():
	"""Update player ranking"""
	# This will be expanded when AI players are added
	pass

func load_global_wallet():
	"""Load global wallet from save file"""
	var save_file = "user://game_save.json"
	if FileAccess.file_exists(save_file):
		var file = FileAccess.open(save_file, FileAccess.READ)
		if file:
			var json_string = file.get_as_text()
			file.close()
			
			var json = JSON.new()
			var parse_result = json.parse(json_string)
			
			if parse_result == OK:
				var data = json.data
				global_wallet = data.get("global_wallet", 0)
			else:
				print("Error parsing save file")
				global_wallet = 0
		else:
			print("Error opening save file")
			global_wallet = 0
	else:
		global_wallet = 0

func save_global_wallet():
	"""Save global wallet to file"""
	var save_file = "user://game_save.json"
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	if file:
		var data = {"global_wallet": global_wallet}
		file.store_string(JSON.stringify(data))
		file.close()
	else:
		print("Error saving game")

func get_match_time_remaining():
	"""Get remaining match time"""
	return match_time_remaining

func get_current_money():
	"""Get current match money"""
	return current_match_money

func get_global_wallet():
	"""Get global wallet balance"""
	return global_wallet
