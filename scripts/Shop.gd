extends Node

# Shop items
var skins = []
var power_ups = []
var upgrades = []
var game_manager = null

func _ready():
	game_manager = get_tree().root.get_node("Main/GameManager")
	initialize_shop_items()

func initialize_shop_items():
	"""Initialize all shop items"""
	# Skins
	skins = [
		{"id": "skin_red", "name": "Red Thief", "price": 100, "description": "A classic red outfit"},
		{"id": "skin_blue", "name": "Blue Thief", "price": 100, "description": "A cool blue outfit"},
		{"id": "skin_gold", "name": "Gold Thief", "price": 500, "description": "A luxurious gold outfit"},
		{"id": "skin_shadow", "name": "Shadow Thief", "price": 1000, "description": "A mysterious shadow outfit"},
	]
	
	# Power-ups
	power_ups = [
		{"id": "speedboost", "name": "Speed Boost", "price": 50, "description": "Temporarily increase movement speed", "duration": 10},
		{"id": "shield", "name": "Shield", "price": 100, "description": "Protect your money for 15 seconds", "duration": 15},
		{"id": "magnet", "name": "Money Magnet", "price": 150, "description": "Attract nearby loot", "duration": 8},
	]
	
	# Upgrades
	upgrades = [
		{"id": "speed_upgrade", "name": "Speed Upgrade", "price": 200, "description": "Permanently increase movement speed by 10%"},
		{"id": "starting_cash", "name": "Starting Cash", "price": 300, "description": "Start next match with $100"},
		{"id": "loot_magnet", "name": "Loot Magnet", "price": 250, "description": "Attract loot from farther away"},
	]

func get_skins():
	"""Get all available skins"""
	return skins

func get_power_ups():
	"""Get all available power-ups"""
	return power_ups

func get_upgrades():
	"""Get all available upgrades"""
	return upgrades

func purchase_skin(skin_id):
	"""Purchase a skin"""
	var skin = find_item_by_id(skins, skin_id)
	if skin and can_afford(skin.price):
		game_manager.global_wallet -= skin.price
		game_manager.save_global_wallet()
		print("Purchased skin: ", skin.name)
		return true
	return false

func purchase_power_up(power_up_id):
	"""Purchase a power-up"""
	var power_up = find_item_by_id(power_ups, power_up_id)
	if power_up and can_afford(power_up.price):
		game_manager.global_wallet -= power_up.price
		game_manager.save_global_wallet()
		print("Purchased power-up: ", power_up.name)
		return true
	return false

func purchase_upgrade(upgrade_id):
	"""Purchase an upgrade"""
	var upgrade = find_item_by_id(upgrades, upgrade_id)
	if upgrade and can_afford(upgrade.price):
		game_manager.global_wallet -= upgrade.price
		game_manager.save_global_wallet()
		print("Purchased upgrade: ", upgrade.name)
		return true
	return false

func can_afford(price):
	"""Check if player can afford an item"""
	return game_manager.global_wallet >= price

func find_item_by_id(items, item_id):
	"""Find item by ID"""
	for item in items:
		if item.id == item_id:
			return item
	return null

func get_shop_info():
	"""Get full shop information"""
	return {
		"skins": skins,
		"power_ups": power_ups,
		"upgrades": upgrades,
		"global_wallet": game_manager.global_wallet
	}
