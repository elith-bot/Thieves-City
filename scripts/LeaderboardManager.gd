extends Node

# Leaderboard data
var leaderboard = []
var player_rank = 1
var game_manager = null
var player_node = null

func _ready():
	game_manager = get_tree().root.get_node("Main/GameManager")
	# Find player node (will be set when player is created)

func _process(delta):
	update_leaderboard()

func update_leaderboard():
	"""Update leaderboard rankings"""
	var all_players = get_tree().get_nodes_in_group("player")
	
	# Create list of players with their money
	var player_data = []
	for player in all_players:
		player_data.append({
			"node": player,
			"money": player.get_money(),
			"is_player": player.name == "Player"  # Main player
		})
	
	# Sort by money in descending order
	player_data.sort_custom(self, "_sort_by_money")
	
	# Update ranks
	for i in range(player_data.size()):
		var rank = i + 1
		var player = player_data[i]
		
		if player.is_player:
			player_rank = rank
			if game_manager:
				game_manager.emit_signal("rank_changed", rank)

func _sort_by_money(a, b):
	"""Sort players by money (descending)"""
	return a.money > b.money

func get_player_rank():
	"""Get current player rank"""
	return player_rank

func get_leaderboard():
	"""Get full leaderboard"""
	var all_players = get_tree().get_nodes_in_group("player")
	var leaderboard_data = []
	
	for player in all_players:
		leaderboard_data.append({
			"name": player.name,
			"money": player.get_money()
		})
	
	# Sort by money
	leaderboard_data.sort_custom(self, "_sort_leaderboard_by_money")
	
	return leaderboard_data

func _sort_leaderboard_by_money(a, b):
	"""Sort leaderboard entries by money (descending)"""
	return a.money > b.money

func print_leaderboard():
	"""Print leaderboard to console"""
	var leaderboard_data = get_leaderboard()
	print("\n=== LEADERBOARD ===")
	for i in range(leaderboard_data.size()):
		var entry = leaderboard_data[i]
		print("%d. %s - $%d" % [i + 1, entry.name, entry.money])
	print("===================\n")
