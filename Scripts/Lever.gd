extends Interactable

signal switch_toggle(state: bool)

var state := false
func _ready() -> void:
	if player != null:
		player.interact.connect(_on_player_interact)
	on_switch_toggle(SaveManager.get_switch_state())
	for child in get_parent().get_children():
		if (child != self) and child.has_signal("switch_toggle"):
			child.switch_toggle.connect(on_switch_toggle)

func on_switch_toggle(next_state: bool) -> void:
	state = next_state
	%Sprite2D.frame = state

func _on_player_interact(_input_dir:Vector2) -> void:
	if interactable and in_trigger:
		switch()

func switch() -> void:
	state = !state
	SaveManager.set_switch_state(state)
	%Sprite2D.frame = state
	switch_toggle.emit(state)
