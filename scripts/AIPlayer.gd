extends KinematicBody2D

# Movement
const SPEED = 150
const ACCELERATION = 400
var velocity = Vector2.ZERO
var current_speed = 0

# Money and Collision
var current_money = 0
var game_manager = null

# AI Behavior
var target_position = Vector2.ZERO
var behavior_timer = 0
var behavior_change_interval = 2.0  # Change behavior every 2 seconds
var current_behavior = "wander"  # wander, chase, flee

# Map boundaries
var map_width = 1280
var map_height = 720

# Sprite
var sprite = null
var color = Color.white

func _ready():
	# Get reference to GameManager
	game_manager = get_tree().root.get_node("Main/GameManager")
	
	# Create sprite
	sprite = Sprite.new()
	randomize_color()
	sprite.modulate = color
	add_child(sprite)
	
	# Create collision shape
	var collision_shape = CollisionShape2D.new()
	var capsule_shape = CapsuleShape2D.new()
	capsule_shape.radius = 10
	capsule_shape.height = 20
	collision_shape.shape = capsule_shape
	add_child(collision_shape)
	
	# Add to player group
	add_to_group("player")
	
	# Set random starting position
	global_position = Vector2(randi() % map_width, randi() % map_height)
	
	# Initialize behavior
	choose_new_behavior()

func _process(delta):
	update_behavior(delta)
	update_movement(delta)
	check_collisions()

func randomize_color():
	"""Assign random color to AI player"""
	var colors = [Color.red, Color.green, Color.cyan, Color.magenta, Color.yellow, Color.orange]
	color = colors[randi() % colors.size()]

func update_behavior(delta):
	"""Update AI behavior"""
	behavior_timer -= delta
	
	if behavior_timer <= 0:
		choose_new_behavior()
		behavior_timer = behavior_change_interval

func choose_new_behavior():
	"""Choose a new random behavior"""
	var behaviors = ["wander", "chase", "flee"]
	current_behavior = behaviors[randi() % behaviors.size()]
	
	match current_behavior:
		"wander":
			target_position = Vector2(randi() % map_width, randi() % map_height)
		"chase":
			# Chase nearest player with more money
			var nearest_player = find_nearest_richer_player()
			if nearest_player:
				target_position = nearest_player.global_position
		"flee":
			# Flee from nearest player with more money
			var threatening_player = find_nearest_richer_player()
			if threatening_player:
				var flee_direction = (global_position - threatening_player.global_position).normalized()
				target_position = global_position + flee_direction * 200

func find_nearest_richer_player():
	"""Find nearest player with more money"""
	var players = get_tree().get_nodes_in_group("player")
	var nearest = null
	var nearest_distance = INF
	
	for player in players:
		if player == self:
			continue
		
		if player.get_money() > current_money:
			var distance = global_position.distance_to(player.global_position)
			if distance < nearest_distance:
				nearest = player
				nearest_distance = distance
	
	return nearest

func update_movement(delta):
	"""Update AI movement"""
	var direction = (target_position - global_position).normalized()
	
	if global_position.distance_to(target_position) > 10:
		current_speed = SPEED
	else:
		current_speed = 0
	
	velocity = direction * current_speed
	velocity = move_and_slide(velocity)
	
	# Keep within map boundaries
	global_position.x = clamp(global_position.x, 0, map_width)
	global_position.y = clamp(global_position.y, 0, map_height)

func check_collisions():
	"""Check for collisions with other players and loot"""
	var collisions = get_slide_count()
	for i in range(collisions):
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("player") and collision.collider != self:
			handle_player_collision(collision.collider)
		elif collision.collider.is_in_group("loot"):
			collect_loot(collision.collider)

func handle_player_collision(other_player):
	"""Handle collision with another player"""
	if current_money > 0:
		var other_money = other_player.get_money()
		
		if current_money > other_money:
			# This AI wins - steal all money from other
			current_money += other_money
			other_player.lose_money(other_money)
		else:
			# This AI loses - lose all money
			other_player.current_money += current_money
			current_money = 0

func collect_loot(loot_item):
	"""Collect loot item"""
	var loot_value = loot_item.get_value()
	current_money += loot_value
	loot_item.queue_free()

func lose_money(amount):
	"""Lose money"""
	current_money = max(0, current_money - amount)

func get_money():
	"""Get current money"""
	return current_money

func set_money(amount):
	"""Set current money"""
	current_money = amount
