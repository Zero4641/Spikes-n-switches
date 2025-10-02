extends Interactable

func _ready() -> void:
	if player != null:
		player.interact.connect(_on_player_interact)

func _on_player_interact(input_dir:Vector2):
	pass
