extends Node

var player : Player
var current_scene_path:= "Title"
var next_scene_path:= ""
var player_next_start_pos:= Vector2.ZERO
var old_room : Object = null
var offset
var new_room
var next_room_direction
var credits_transition : bool
var gameplay : bool
var loading : bool

const room_size := Vector2(1904.0, 1232.0)

func switch_scene_slide(new_scene_path: String, direction: Vector2, next_start_pos: Vector2):
	if !FileAccess.file_exists(new_scene_path):
		print("File path "+new_scene_path+" doen't exist")
	next_room_direction = direction
	next_scene_path = new_scene_path
	player_next_start_pos = next_start_pos
	offset = room_size * direction
	var progress = []
	ResourceLoader.load_threaded_request(next_scene_path)
	loading = true
	while loading:
		var status = ResourceLoader.load_threaded_get_status(next_scene_path, progress)
		match status:
			ResourceLoader.THREAD_LOAD_LOADED:
				for child in %"Level container".get_children():
					if !(child is Player) and !child.is_in_group("container"):
						old_room = child
					elif child is Player:
						player = child
				var packed_scene = ResourceLoader.load_threaded_get(next_scene_path)
				new_room = packed_scene.instantiate()
				%"Level container".call_deferred("add_child", new_room)
				loading = false
			ResourceLoader.THREAD_LOAD_FAILED:
				print("Error: Scene load fail: ", next_scene_path)
				return
	new_room.position = old_room.position + offset
	
	%"Level container".start_slide_transition(old_room, new_room, player_next_start_pos, offset)

func switch_scene_fade(new_scene_path: String, next_start_pos = Vector2.ZERO, credits = false, add_player = false) -> void:
	if !FileAccess.file_exists(new_scene_path):
		print("File path "+new_scene_path+" doen't exist")
	
	next_scene_path = new_scene_path
	player_next_start_pos = next_start_pos
	%"Level container".fade_out()
	credits_transition = credits
	gameplay = add_player

func load_next_scene() -> void:
	var progress = []
	ResourceLoader.load_threaded_request(next_scene_path)
	
	while true:
		var status = ResourceLoader.load_threaded_get_status(next_scene_path, progress)
		match status:
			ResourceLoader.THREAD_LOAD_LOADED:
				if gameplay:
					var player_scene = load("res://Scenes/Entites/player.tscn")
					player_scene = player_scene.instantiate()
					%"Level container".add_child(player_scene)
				for child in %"Level container".get_children():
					if !credits_transition:
						if !(child is Player):
							child.queue_free()
						else:
							child.position = player_next_start_pos
					else:
						child.queue_free()
				var packed_scene = ResourceLoader.load_threaded_get(next_scene_path)
				var new_scene = packed_scene.instantiate()
				%"Level container".add_child(new_scene)
				await get_tree().create_timer(0.5).timeout
				set_new_scene()
				return
			ResourceLoader.THREAD_LOAD_FAILED:
				print("Error: Scene load fail: ", next_scene_path)
				return
		await get_tree().create_timer(0.1).timeout

func _on_slide_transition_finished():
	old_room.queue_free()
	current_scene_path = next_scene_path
	next_scene_path = ""
	player_next_start_pos = Vector2.ZERO
	old_room = null
	player = null

func set_new_scene() -> void:
	await %"Level container".fade_in()
	current_scene_path = next_scene_path
	next_scene_path = ""
	player_next_start_pos = Vector2.ZERO
	old_room = null
