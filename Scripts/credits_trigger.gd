extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().current_scene.switch_scene_fade("res://Scenes/title.tscn", Vector2.ZERO, true)
