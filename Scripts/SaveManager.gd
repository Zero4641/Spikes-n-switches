extends Node

var doors_unlocked := {}
var keys_collected := {}
var switch_state := false

# Set a door's unlocked state
func set_door_unlocked(door_id: String, unlocked: bool) -> void:
	doors_unlocked[door_id] = unlocked

# Check if a door is unlocked
func is_door_unlocked(door_id: String) -> bool:
	return doors_unlocked.get(door_id, false)

# Add a key to the collection
func collect_key(key_id: String) -> void:
	keys_collected[key_id] = true

# Check if a key has been collected
func has_key(key_id: String) -> bool:
	return keys_collected.get(key_id, false)

#toggles switch state
func set_switch_state(next_state) -> void:
	switch_state = next_state

#get switch state
func get_switch_state() -> bool:
	return switch_state
