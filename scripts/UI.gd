extends CanvasLayer

# UI Elements
var money_label = null
var timer_label = null
var rank_label = null
var game_manager = null

func _ready():
	# Get reference to GameManager
	game_manager = get_tree().root.get_node("Main/GameManager")
	
	# Create UI elements
	var container = Control.new()
	container.anchor_right = 1.0
	container.anchor_bottom = 1.0
	add_child(container)
	
	# Money label
	money_label = Label.new()
	money_label.text = "Money: $0"
	money_label.position = Vector2(10, 10)
	money_label.add_theme_font_size_override("font_size", 24)
	container.add_child(money_label)
	
	# Timer label
	timer_label = Label.new()
	timer_label.text = "Time: 120"
	timer_label.position = Vector2(10, 40)
	timer_label.add_theme_font_size_override("font_size", 24)
	container.add_child(timer_label)
	
	# Rank label
	rank_label = Label.new()
	rank_label.text = "Rank: 1/31"
	rank_label.position = Vector2(10, 70)
	rank_label.add_theme_font_size_override("font_size", 24)
	container.add_child(rank_label)
	
	# Connect signals
	if game_manager:
		game_manager.money_changed.connect(_on_money_changed)
		game_manager.rank_changed.connect(_on_rank_changed)

func _process(delta):
	if game_manager:
		update_timer()

func update_timer():
	"""Update timer display"""
	var time_remaining = game_manager.get_match_time_remaining()
	timer_label.text = "Time: %d" % int(time_remaining)

func _on_money_changed(new_amount):
	"""Update money display"""
	money_label.text = "Money: $%d" % new_amount

func _on_rank_changed(new_rank):
	"""Update rank display"""
	rank_label.text = "Rank: %d/31" % new_rank
