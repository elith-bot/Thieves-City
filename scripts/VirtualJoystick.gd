extends Control

# Virtual joystick for mobile/touch devices
signal direction_changed(direction)

var is_pressed = false
var touch_index = -1
var center_position = Vector2.ZERO
var current_direction = Vector2.ZERO
var max_distance = 50

# Visual elements
var base_circle = null
var stick_circle = null

# Auto-detection
var keyboard_mouse_detected = false
var last_keyboard_time = 0
var last_mouse_time = 0
var detection_timeout = 2.0  # Hide joystick after 2 seconds of keyboard/mouse use

func _ready():
	# Create base circle
	base_circle = ColorRect.new()
	base_circle.rect_size = Vector2(100, 100)
	base_circle.rect_position = Vector2(-50, -50)
	base_circle.color = Color(0.3, 0.3, 0.3, 0.5)
	add_child(base_circle)
	
	# Create stick circle
	stick_circle = ColorRect.new()
	stick_circle.rect_size = Vector2(50, 50)
	stick_circle.rect_position = Vector2(-25, -25)
	stick_circle.color = Color(0.6, 0.6, 0.6, 0.8)
	add_child(stick_circle)
	
	# Set position (bottom-left corner)
	rect_position = Vector2(100, get_viewport().size.y - 150)
	center_position = rect_size / 2
	
	# Start hidden if keyboard/mouse available
	update_visibility()

func _input(event):
	# Detect keyboard input
	if event is InputEventKey:
		keyboard_mouse_detected = true
		last_keyboard_time = OS.get_ticks_msec() / 1000.0
		update_visibility()
	
	# Detect mouse input
	elif event is InputEventMouse:
		keyboard_mouse_detected = true
		last_mouse_time = OS.get_ticks_msec() / 1000.0
		update_visibility()
	
	# Handle touch events
	elif event is InputEventScreenTouch:
		keyboard_mouse_detected = false
		update_visibility()
		
		if event.pressed:
			# Check if touch is within joystick area
			var touch_pos = event.position - rect_global_position
			if touch_pos.length() < 100:
				is_pressed = true
				touch_index = event.index
				update_stick_position(touch_pos)
		else:
			if event.index == touch_index:
				is_pressed = false
				touch_index = -1
				reset_stick()
	
	# Handle touch drag
	elif event is InputEventScreenDrag:
		if is_pressed and event.index == touch_index:
			var touch_pos = event.position - rect_global_position
			update_stick_position(touch_pos)

func _process(delta):
	# Auto-hide joystick if keyboard/mouse is being used
	var current_time = OS.get_ticks_msec() / 1000.0
	if keyboard_mouse_detected:
		if current_time - last_keyboard_time > detection_timeout and current_time - last_mouse_time > detection_timeout:
			# No keyboard/mouse input for a while, show joystick again
			keyboard_mouse_detected = false
			update_visibility()

func update_visibility():
	"""Update joystick visibility based on input method"""
	# Show joystick if:
	# 1. Touch screen is available AND
	# 2. No recent keyboard/mouse input
	visible = OS.has_touchscreen_ui_hint() or not keyboard_mouse_detected

func update_stick_position(touch_pos):
	"""Update stick position based on touch"""
	var offset = touch_pos - center_position
	
	# Limit to max distance
	if offset.length() > max_distance:
		offset = offset.normalized() * max_distance
	
	# Update stick visual position
	stick_circle.rect_position = center_position + offset - stick_circle.rect_size / 2
	
	# Calculate direction
	current_direction = offset / max_distance
	emit_signal("direction_changed", current_direction)

func reset_stick():
	"""Reset stick to center"""
	stick_circle.rect_position = center_position - stick_circle.rect_size / 2
	current_direction = Vector2.ZERO
	emit_signal("direction_changed", current_direction)

func get_direction():
	"""Get current direction"""
	return current_direction

func is_visible_and_active():
	"""Check if joystick is visible and should be used"""
	return visible and not keyboard_mouse_detected
