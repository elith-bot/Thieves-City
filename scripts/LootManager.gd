extends Node2D

# Loot spawning
const LOOT_SCENE = preload("res://scenes/Loot.tscn")
const SPAWN_RATE = 0.5  # Spawn every 0.5 seconds
const MAX_LOOT_ON_MAP = 100
const MAP_WIDTH = 1280
const MAP_HEIGHT = 720

var spawn_timer = 0
var loot_count = 0

func _ready():
	spawn_timer = SPAWN_RATE

func _process(delta):
	spawn_timer -= delta
	
	if spawn_timer <= 0 and loot_count < MAX_LOOT_ON_MAP:
		spawn_loot()
		spawn_timer = SPAWN_RATE

func spawn_loot():
	"""Spawn a random loot item on the map"""
	var loot = LOOT_SCENE.instance()
	
	# Random position
	var random_x = randi() % MAP_WIDTH
	var random_y = randi() % MAP_HEIGHT
	loot.global_position = Vector2(random_x, random_y)
	
	add_child(loot)
	loot_count += 1
	
	# Connect to tree_exited signal to track when loot is removed
	loot.connect("tree_exited", self, "_on_loot_removed")

func _on_loot_removed():
	"""Called when loot is removed from the scene"""
	loot_count -= 1
