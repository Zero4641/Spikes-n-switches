extends CharacterBody2D
class_name Player

signal interact(interact_dir:Vector2)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		interact.emit(last_faced_direction)
		print("interact sent")

var speed : float = 25.0
var input_dir := Vector2.ZERO
func _physics_process(_delta: float) -> void:
	input_dir = Vector2.ZERO
	input_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_dir = input_dir.normalized()
	
	velocity = input_dir * speed
	move_and_slide()
	update_animations()

var Idle := true
var last_faced_direction := Vector2.DOWN
func update_animations() -> void:
	if input_dir.length() > 0:
		Idle = false
		last_faced_direction = input_dir.normalized()
	else:
		Idle = true
	
	%AnimationTree.set("parameters/conditions/Idle", Idle)
	%AnimationTree.set("parameters/conditions/Move", !Idle)
	%AnimationTree.set("parameters/Alive idle/blend_position", last_faced_direction)
	%AnimationTree.set("parameters/Alive move/blend_position", last_faced_direction)
