extends Node

# Active upgrades
var active_upgrades = {
	"speed_boost": false,
	"starting_cash": false,
	"loot_magnet": false
}

# Upgrade values
var speed_multiplier = 1.0
var starting_cash_amount = 0
var loot_magnet_range = 0

var game_manager = null

func _ready():
	game_manager = get_tree().root.get_node("Main/GameManager")

func activate_upgrade(upgrade_id):
	"""Activate an upgrade for the next match"""
	if upgrade_id in active_upgrades:
		active_upgrades[upgrade_id] = true
		apply_upgrade_effect(upgrade_id)
		print("Upgrade activated: ", upgrade_id)

func deactivate_upgrade(upgrade_id):
	"""Deactivate an upgrade"""
	if upgrade_id in active_upgrades:
		active_upgrades[upgrade_id] = false
		remove_upgrade_effect(upgrade_id)
		print("Upgrade deactivated: ", upgrade_id)

func apply_upgrade_effect(upgrade_id):
	"""Apply upgrade effect"""
	match upgrade_id:
		"speed_boost":
			speed_multiplier = 1.1  # 10% speed increase
		"starting_cash":
			starting_cash_amount = 100
		"loot_magnet":
			loot_magnet_range = 100

func remove_upgrade_effect(upgrade_id):
	"""Remove upgrade effect"""
	match upgrade_id:
		"speed_boost":
			speed_multiplier = 1.0
		"starting_cash":
			starting_cash_amount = 0
		"loot_magnet":
			loot_magnet_range = 0

func get_speed_multiplier():
	"""Get current speed multiplier"""
	return speed_multiplier

func get_starting_cash():
	"""Get starting cash for next match"""
	return starting_cash_amount

func get_loot_magnet_range():
	"""Get loot magnet range"""
	return loot_magnet_range

func get_active_upgrades():
	"""Get list of active upgrades"""
	var active = []
	for upgrade_id in active_upgrades:
		if active_upgrades[upgrade_id]:
			active.append(upgrade_id)
	return active

func reset_upgrades():
	"""Reset all upgrades (called at match start)"""
	for upgrade_id in active_upgrades:
		active_upgrades[upgrade_id] = false
	speed_multiplier = 1.0
	starting_cash_amount = 0
	loot_magnet_range = 0

func get_upgrade_cost(upgrade_id):
	"""Get cost of an upgrade"""
	var costs = {
		"speed_boost": 200,
		"starting_cash": 300,
		"loot_magnet": 250
	}
	return costs.get(upgrade_id, 0)
