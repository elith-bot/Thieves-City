extends Area2D

# Loot properties
var loot_value = 0
var loot_type = "cash"  # cash, jewel, wallet
var sprite = null

# Loot values
const LOOT_VALUES = {
	"cash": 10,
	"jewel": 50,
	"wallet": 100
}

func _ready():
	# Create sprite
	sprite = Sprite.new()
	add_child(sprite)
	
	# Create collision shape
	var collision_shape = CollisionShape2D.new()
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = 5
	collision_shape.shape = circle_shape
	add_child(collision_shape)
	
	# Set loot properties
	randomize_loot()
	update_sprite()

func randomize_loot():
	"""Randomly select loot type and value"""
	var loot_types = LOOT_VALUES.keys()
	loot_type = loot_types[randi() % loot_types.size()]
	loot_value = LOOT_VALUES[loot_type]

func update_sprite():
	"""Update sprite based on loot type"""
	match loot_type:
		"cash":
			sprite.modulate = Color.green
		"jewel":
			sprite.modulate = Color.red
		"wallet":
			sprite.modulate = Color.yellow

func get_value():
	"""Get loot value"""
	return loot_value

func get_type():
	"""Get loot type"""
	return loot_type
