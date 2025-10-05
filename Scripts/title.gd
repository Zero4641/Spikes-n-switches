extends Control

func _ready() -> void:
	$FieldDayLoop.play()

func _on_start_pressed() -> void:
	$UpdateFlashlightC.play()
	get_tree().current_scene.switch_scene_fade("res://Scenes/rooms/room_1.tscn", Vector2(616, 616), false, true)
