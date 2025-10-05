extends StaticBody2D

@export var unlock_state := true
var state := false
var open := false
func _ready() -> void:
	on_switch_toggle(SaveManager.switch_state)
	SaveManager.switched_state.connect(on_switch_toggle)

func on_switch_toggle(next_state: bool):
	state = next_state
	#print("state is:" + str(state))
	if state == unlock_state:
		#print("Checking if door is closed")
		if !open:
			#print("opening door")
			match unlock_state:
				true:
					%AnimationPlayer.play("True/Opening")
				false:
					%AnimationPlayer.play("False/Opening")
			open = true
	else:
		#print("Checking if door is open")
		if open:
			#print("closing door")
			match unlock_state:
				true:
					%AnimationPlayer.play("True/Closing")
				false:
					%AnimationPlayer.play("False/Closing")
			open = false
	#print(open)
	set_collision_layer_value(1, !(open))
	set_collision_layer_value(2, !(open))
