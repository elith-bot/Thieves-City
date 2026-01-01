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
	# Add to loot group
	add_to_group("loot")
	
	# Set loot properties
	randomize_loot()
	update_sprite()
	
	# Connect area entered signal
	connect("body_entered", self, "_on_body_entered")

func randomize_loot():
	"""Randomly select loot type and value"""
	var loot_types = LOOT_VALUES.keys()
	loot_type = loot_types[randi() % loot_types.size()]
	loot_value = LOOT_VALUES[loot_type]

func update_sprite():
	"""Update sprite based on loot type"""
	var sprite_node = get_node_or_null("Sprite")
	if sprite_node:
		var texture_path = ""
		match loot_type:
			"cash":
				texture_path = "res://assets/sprites/loot_cash.png"
			"jewel":
				texture_path = "res://assets/sprites/loot_jewel.png"
			"wallet":
				texture_path = "res://assets/sprites/loot_wallet.png"
		
		if texture_path != "":
			var texture = load(texture_path)
			if texture:
				sprite_node.texture = texture

func _on_body_entered(body):
	"""Called when a body enters the loot area"""
	if body.is_in_group("player"):
		# Player collected this loot
		if body.has_method("collect_loot"):
			body.collect_loot(loot_value)
		queue_free()

func get_value():
	"""Get loot value"""
	return loot_value

func get_type():
	"""Get loot type"""
	return loot_type
