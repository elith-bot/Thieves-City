extends Node2D

# References
var player = null
var game_manager = null
var loot_manager = null
var virtual_joystick = null

# AI Players
const NUM_AI_PLAYERS = 30
var ai_player_scene = null

func _ready():
	# Load AI player scene
	ai_player_scene = load("res://scenes/AIPlayer.tscn")
	
	# Get references
	player = get_node_or_null("Player")
	game_manager = get_node_or_null("GameManager")
	loot_manager = get_node_or_null("LootManager")
	
	# Get virtual joystick from UI
	var ui_node = get_node_or_null("UI")
	if ui_node:
		virtual_joystick = ui_node.get_node_or_null("VirtualJoystick")
	
	# Connect virtual joystick to player
	if player and virtual_joystick:
		player.set_virtual_joystick(virtual_joystick)
	
	# Spawn AI players
	spawn_ai_players()
	
	print("Game initialized!")
	print("Controls:")
	print("  Desktop: Arrow keys or WASD")
	print("  Mobile: Virtual joystick (bottom-left)")

func spawn_ai_players():
	"""Spawn AI players"""
	if ai_player_scene == null:
		print("Error: AI player scene not loaded")
		return
	
	for i in range(NUM_AI_PLAYERS):
		var ai_player = ai_player_scene.instance()
		ai_player.name = "AIPlayer%d" % i
		add_child(ai_player)
	
	print("Spawned %d AI players" % NUM_AI_PLAYERS)
