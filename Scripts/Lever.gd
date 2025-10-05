extends Interactable

var state := false
func _ready() -> void:
	if player != null:
		player.interact.connect(_on_player_interact)
	on_switch_toggle(SaveManager.switch_state)
	SaveManager.switched_state.connect(on_switch_toggle)

func on_switch_toggle(next_state: bool) -> void:
	if next_state:
		%AnimationPlayer.play("flick_on")
	else:
		%AnimationPlayer.play("flick_off")
	state = next_state

func _on_player_interact(_input_dir:Vector2) -> void:
	if interactable and in_trigger and !player.dead:
		SaveManager.set_switch_state(!state)
		$LeversC.play()
