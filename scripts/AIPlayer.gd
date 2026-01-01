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
	var main_node = get_tree().root.get_node_or_null("Main")
	if main_node:
		game_manager = main_node.get_node_or_null("GameManager")
	
	# Add to player group
	add_to_group("player")
	
	# Set random color
	randomize_color()
	var sprite_node = get_node_or_null("Sprite")
	if sprite_node:
		sprite_node.modulate = color
	
	# Set random starting position
	global_position = Vector2(rand_range(100, map_width - 100), rand_range(100, map_height - 100))
	
	# Initialize behavior
	choose_new_behavior()

func randomize_color():
	"""Assign random color to AI player"""
	var colors = [Color(1, 0, 0, 1), Color(0, 1, 0, 1), Color(1, 1, 0, 1), 
	              Color(1, 0, 1, 1), Color(0, 1, 1, 1), Color(1, 0.5, 0, 1)]
	color = colors[randi() % colors.size()]

func _process(delta):
	update_behavior(delta)
	update_movement(delta)
	check_collisions()

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
			target_position = Vector2(rand_range(50, map_width - 50), rand_range(50, map_height - 50))
		"chase":
			# Chase nearest loot
			var nearest_loot = find_nearest_loot()
			if nearest_loot:
				target_position = nearest_loot.global_position
			else:
				target_position = Vector2(rand_range(50, map_width - 50), rand_range(50, map_height - 50))
		"flee":
			# Flee from nearest richer player
			var threatening_player = find_nearest_richer_player()
			if threatening_player:
				var flee_direction = (global_position - threatening_player.global_position).normalized()
				target_position = global_position + flee_direction * 200
			else:
				target_position = Vector2(rand_range(50, map_width - 50), rand_range(50, map_height - 50))

func find_nearest_loot():
	"""Find nearest loot item"""
	var loot_items = get_tree().get_nodes_in_group("loot")
	var nearest = null
	var nearest_distance = INF
	
	for loot in loot_items:
		var distance = global_position.distance_to(loot.global_position)
		if distance < nearest_distance:
			nearest = loot
			nearest_distance = distance
	
	return nearest

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
	"""Check for collisions with other players"""
	var collisions = get_slide_count()
	for i in range(collisions):
		var collision = get_slide_collision(i)
		var collider = collision.collider
		
		if collider.is_in_group("player") and collider != self:
			handle_player_collision(collider)

func handle_player_collision(other_player):
	"""Handle collision with another player"""
	if current_money > 0 or other_player.get_money() > 0:
		var other_money = other_player.get_money()
		
		if current_money > other_money:
			# This AI wins - steal all money from other
			var stolen = other_money
			current_money += stolen
			other_player.lose_money(stolen)
			print("%s stole $%d from %s" % [name, stolen, other_player.name])
		elif other_money > current_money:
			# This AI loses - lose all money
			var lost = current_money
			other_player.add_money_direct(lost)
			current_money = 0
			print("%s lost $%d to %s" % [name, lost, other_player.name])

func add_money_direct(amount):
	"""Add money directly"""
	current_money += amount

func collect_loot(loot_value):
	"""Collect loot item"""
	current_money += loot_value
	print("%s collected $%d" % [name, loot_value])

func _on_Loot_area_entered(area):
	"""Called when AI enters loot area"""
	if area.is_in_group("loot"):
		var loot_value = area.get_value()
		collect_loot(loot_value)
		area.queue_free()

func lose_money(amount):
	"""Lose money"""
	current_money = max(0, current_money - amount)

func get_money():
	"""Get current money"""
	return current_money

func set_money(amount):
	"""Set current money"""
	current_money = amount
