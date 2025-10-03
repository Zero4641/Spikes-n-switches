extends StaticBody2D

@export var unlock_state := true

func _ready() -> void:
	state = SaveManager.switch_state
	%AnimationTree.set("parameters/blend_position", Vector2(unlock_state, state == unlock_state))
	for child in get_parent().get_children():
		if (child != self) and child.has_signal("switch_toggle"):
			child.switch_toggle.connect(on_switch_toggle)

var state := false
var open := false
func on_switch_toggle(next_state: bool):
	state = next_state
	print("state is:" + str(state))
	%AnimationTree.set("parameters/blend_position", Vector2(unlock_state, state == unlock_state))

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	print(anim_name)
	if anim_name.ends_with("Opening"):
		open = true
		process_mode = Node.PROCESS_MODE_DISABLED
		print(open)
	elif anim_name.ends_with("Closing"):
		open = false
		process_mode = Node.PROCESS_MODE_PAUSABLE
		print(open)
