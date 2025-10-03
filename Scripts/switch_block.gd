extends StaticBody2D

@export var unlock_state := true

var state := false
func _ready() -> void:
	on_switch_toggle(SaveManager.switch_state)
	for child in get_parent().get_children():
		if (child != self) and child.has_signal("switch_toggle"):
			child.switch_toggle.connect(on_switch_toggle)

func on_switch_toggle(next_state: bool):
	state = next_state
	if state == unlock_state:
		self.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		self.process_mode = Node.PROCESS_MODE_PAUSABLE
	$Sprite2D.frame = !(state == unlock_state)
