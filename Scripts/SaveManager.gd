extends Node

var doors_unlocked := {}
var keys_collected := {}
var keys : int = 0
var final_key := false
var switch_state := false

signal key_collected(keys:int)
signal key_used(keys:int)
signal final_key_collected()

# Set a door's unlocked state
func set_door_unlocked(door_id: String, unlocked: bool) -> void:
	doors_unlocked[door_id] = unlocked

# Check if a door is unlocked
func is_door_unlocked(door_id: String) -> bool:
	return doors_unlocked.get(door_id, false)

# Add a key to the collection
func collect_key(key_id: String) -> void:
	keys += 1
	keys_collected[key_id] = true
	key_collected.emit(keys_collected)

func collect_final_key(key_id: String) -> void:
	final_key = true
	keys_collected[key_id] = true
	final_key_collected.emit()

func use_key() -> void:
	keys -= 1
	key_used.emit(keys_collected)

func has_key(key_id: String) -> bool:
	return keys_collected.get(key_id, false)

#toggles switch state
func set_switch_state(next_state) -> void:
	switch_state = next_state
