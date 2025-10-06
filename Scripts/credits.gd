extends Control

func _ready() -> void:
	get_parent().transition_over.connect(_on_transition_over)

func _on_transition_over() -> void:
	await get_tree().create_timer(0.75).timeout
	$FieldDayLoop.play()
	$AnimationPlayer.play("credits roll")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	await get_tree().create_timer(1).timeout
	get_tree().current_scene.switch_scene_fade("res://Scenes/title.tscn")
