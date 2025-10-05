extends StaticBody2D

@export var unlock_state := true
var state := false
var open := false
func _ready() -> void:
	load_state(SaveManager.switch_state)
	SaveManager.switched_state.connect(on_switch_toggle)

func load_state(next_state:bool) -> void:
	state = next_state
	if state == unlock_state:
		if !open:
			%Sprite2D.frame = 11
			open = true
	else:
		if open:
			match unlock_state:
				true:
					%Sprite2D.frame = 0
				false:
					%Sprite2D.frame = 6
			open = false
	set_collision_layer_value(1, !(open))
	set_collision_layer_value(2, !(open))

func on_switch_toggle(next_state: bool) -> void:
	state = next_state
	if state == unlock_state:
		if !open:
			match unlock_state:
				true:
					%AnimationPlayer.play("True/Disappear")
				false:
					%AnimationPlayer.play("False/Disappear")
			open = true
	else:
		if open:
			match unlock_state:
				true:
					%AnimationPlayer.play("True/Appear")
				false:
					%AnimationPlayer.play("False/Appear")
			open = false
	set_collision_layer_value(1, !(open))
	set_collision_layer_value(2, !(open))
