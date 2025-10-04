extends Node2D

signal transition_start()
signal transition_over()

func start_slide_transition(old_room: Node2D, new_room: Node2D, player_target_pos: Vector2, offset: Vector2):
	emit_signal("transition_start")
	
	var duration = 0.375
	var tween1 = create_tween()
	var tween2 = create_tween()
	var tween3 = create_tween()
	
	tween1.tween_property(old_room, "position", old_room.position - offset, duration)
	tween2.tween_property(new_room, "position", new_room.position - offset, duration)
	tween3.tween_property($Player, "position", player_target_pos, duration)
	
	tween3.finished.connect(_on_slide_transition_finished)

func fade_out():
	emit_signal("transition_start")
	%TransitionPlayer.play("Fade_out")

func fade_in():
	%TransitionPlayer.play("Fade_in")

func _on_transition_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Fade_out":
		$"..".load_next_scene()
	elif anim_name == "Fade_in":
		emit_signal("transition_over")

func _on_slide_transition_finished():
	emit_signal("transition_over")
	$".."._on_slide_transition_finished()
