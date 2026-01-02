extends CharacterBody2D

# Movement
const SPEED = 200.0
const ACCELERATION = 500.0

# Money and Collision
var current_money = 0
var game_manager = null

# Control
var virtual_joystick = null
var joystick_direction = Vector2.ZERO

# Animation
var sprite = null
var animation_player = null

func _ready():
	# Get reference to GameManager
	var main_node = get_tree().root.get_node_or_null("Main")
	if main_node:
		game_manager = main_node.get_node_or_null("GameManager")
	
	# Add to player group
	add_to_group("player")
	
	# Set name for identification
	name = "Player"
	
	# Connect signals
	if game_manager:
		game_manager.money_changed.connect(_on_money_changed)

func set_virtual_joystick(joystick):
	"""Set reference to virtual joystick"""
	virtual_joystick = joystick
	if virtual_joystick:
		virtual_joystick.direction_changed.connect(_on_joystick_direction_changed)

func _on_joystick_direction_changed(direction):
	"""Called when joystick direction changes"""
	joystick_direction = direction

func _process(delta):
	handle_input()
	update_movement(delta)
	check_collisions()

func handle_input():
	"""Handle player input from keyboard/mouse or virtual joystick"""
	var input_vector = Vector2.ZERO
	
	# Check if virtual joystick is active and being used
	var use_joystick = false
	if virtual_joystick and virtual_joystick.has_method("is_visible_and_active"):
		use_joystick = virtual_joystick.is_visible_and_active() and joystick_direction != Vector2.ZERO
	
	if use_joystick:
		# Use virtual joystick
		input_vector = joystick_direction
	else:
		# Use keyboard input (WASD or Arrow keys)
		if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
			input_vector.x += 1
		if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A):
			input_vector.x -= 1
		if Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S):
			input_vector.y += 1
		if Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W):
			input_vector.y -= 1
	
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector * SPEED
	else:
		velocity = Vector2.ZERO

func update_movement(delta):
	"""Update player position"""
	move_and_slide()

func check_collisions():
	"""Check for collisions with other players"""
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider and collider.is_in_group("player") and collider != self:
			handle_player_collision(collider)

func handle_player_collision(other_player):
	"""Handle collision with another player"""
	if current_money > 0 or other_player.get_money() > 0:
		var other_money = other_player.get_money()
		
		if current_money > other_money:
			# This player wins - steal all money from other
			var stolen = other_money
			current_money += stolen
			other_player.lose_money(stolen)
			if game_manager:
				game_manager.add_money(stolen)
			print("Player stole $%d from %s" % [stolen, other_player.name])
		elif other_money > current_money:
			# This player loses - lose all money
			var lost = current_money
			other_player.add_money_direct(lost)
			current_money = 0
			if game_manager:
				game_manager.subtract_money(lost)
			print("Player lost $%d to %s" % [lost, other_player.name])

func add_money_direct(amount):
	"""Add money directly (for AI collision)"""
	current_money += amount

func lose_money(amount):
	"""Lose money"""
	current_money = max(0, current_money - amount)

func get_money():
	"""Get current money"""
	return current_money

func set_money(amount):
	"""Set current money"""
	current_money = amount

func _on_money_changed(new_amount):
	"""Called when game manager money changes"""
	# Sync with game manager
	current_money = new_amount

func collect_loot(loot_value):
	"""Collect loot and add to money"""
	current_money += loot_value
	if game_manager:
		game_manager.add_money(loot_value)
	print("Player collected $%d" % loot_value)

func _on_Loot_area_entered(area):
	"""Called when player enters loot area"""
	if area.is_in_group("loot"):
		var loot_value = area.get_value()
		collect_loot(loot_value)
		area.queue_free()
