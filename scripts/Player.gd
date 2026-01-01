extends KinematicBody2D

# Movement
const SPEED = 200
const ACCELERATION = 500
var velocity = Vector2.ZERO
var current_speed = 0

# Money and Collision
var current_money = 0
var game_manager = null

# Animation
var sprite = null
var animation_player = null

func _ready():
	# Get reference to GameManager
	game_manager = get_tree().root.get_node("Main/GameManager")
	
	# Create sprite
	sprite = Sprite.new()
	sprite.modulate = Color.blue
	add_child(sprite)
	
	# Create collision shape
	var collision_shape = CollisionShape2D.new()
	var capsule_shape = CapsuleShape2D.new()
	capsule_shape.radius = 10
	capsule_shape.height = 20
	collision_shape.shape = capsule_shape
	add_child(collision_shape)
	
	# Connect signals
	if game_manager:
		game_manager.connect("money_changed", self, "_on_money_changed")

func _process(delta):
	handle_input()
	update_movement(delta)
	check_collisions()

func handle_input():
	"""Handle player input"""
	var input_vector = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		current_speed = SPEED
	else:
		current_speed = 0
	
	velocity = input_vector * current_speed

func update_movement(delta):
	"""Update player position"""
	velocity = move_and_slide(velocity)

func check_collisions():
	"""Check for collisions with other players"""
	var collisions = get_slide_count()
	for i in range(collisions):
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("player"):
			handle_player_collision(collision.collider)
		elif collision.collider.is_in_group("loot"):
			collect_loot(collision.collider)

func handle_player_collision(other_player):
	"""Handle collision with another player"""
	if current_money > 0:
		var other_money = other_player.get_money()
		
		if current_money > other_money:
			# This player wins - steal all money from other
			current_money += other_money
			other_player.lose_money(other_money)
			if game_manager:
				game_manager.add_money(other_money)
		else:
			# This player loses - lose all money
			other_player.current_money += current_money
			current_money = 0
			if game_manager:
				game_manager.subtract_money(current_money)

func collect_loot(loot_item):
	"""Collect loot item"""
	var loot_value = loot_item.get_value()
	current_money += loot_value
	if game_manager:
		game_manager.add_money(loot_value)
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

func _on_money_changed(new_amount):
	"""Called when game manager money changes"""
	# Update UI or visuals based on money change
	pass

func get_position_2d():
	"""Get current position"""
	return global_position
