extends Interactable

var pushing := false
func _on_player_interact(input_dir:Vector2) -> void:
	if !pushing and interactable and !player.Idle and in_trigger:
		push(snap_to_cardinal(input_dir))

var target_pos := Vector2.ZERO
func push(push_dir) -> void:
	if !test_move(transform, push_dir*8):
		target_pos = position + push_dir*8
		pushing = true

func _physics_process(delta: float) -> void:
	if pushing:
		position = position.move_toward(target_pos, delta*25)
		if position == target_pos:
			pushing = false

func snap_to_cardinal(Input_vector: Vector2) -> Vector2:
	if Input_vector == Vector2.ZERO:
		return Vector2.ZERO
	var abs_x = abs(Input_vector.x)
	var abs_y = abs(Input_vector.y)
	if abs_x > abs_y:
		return Vector2(sign(Input_vector.x), 0) # Left or Right
	else:
		return Vector2(0, sign(Input_vector.y)) # Up or Down
