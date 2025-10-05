extends CharacterBody2D
class_name Interactable

@onready var player : Player = get_tree().current_scene.get_node("Level container/Player")

var in_trigger := false
var interactable := true
func _ready() -> void:
	if player != null:
		player.interact.connect(_on_player_interact)

func _on_player_interact(_input_dir:Vector2):
	pass
