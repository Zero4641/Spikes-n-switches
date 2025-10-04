extends Area2D

@export_file("*.tscn") var next_room_path : String
@export_enum("Up", "Down", "Left", "Right") var Scroll_type = "Up"
@export var use_custom_player_pos : bool = false
@export var player_enter_pos : Vector2

var next_room_direction:= Vector2.ZERO
var enter_pos : Vector2

const room_size := Vector2(1904.0, 1232.0)

func _ready() -> void:
	transition_cooldown()
	
	match Scroll_type:
		"Up":
			next_room_direction = Vector2.DOWN
			enter_pos = Vector2(room_size.x/2, 168.0)
		"Down":
			next_room_direction = Vector2.UP
			enter_pos = Vector2(room_size.x/2, room_size.y-168.0)
		"Left":
			next_room_direction = Vector2.RIGHT
			enter_pos = Vector2(168.0, room_size.y/2)
		"Right":
			next_room_direction = Vector2.LEFT
			enter_pos = Vector2(room_size.x-168.0, room_size.y/2)
	
	if use_custom_player_pos:
		enter_pos = player_enter_pos

func transition_cooldown():
	await get_tree().create_timer(0.125).timeout
	monitoring = true

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.can_move == true:
			get_tree().current_scene.switch_scene_slide(next_room_path, next_room_direction, enter_pos)
