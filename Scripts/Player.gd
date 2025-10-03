extends CharacterBody2D
class_name Player

signal interact(interact_dir:Vector2)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		interact.emit(last_faced_direction)

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
	%AnimationTree.set("parameters/conditions/Dead", dead)
	%AnimationTree.set("parameters/conditions/Alive", !dead)
	%AnimationTree.set("parameters/Alive idle/blend_position", last_faced_direction)
	%AnimationTree.set("parameters/Alive move/blend_position", last_faced_direction)
	%AnimationTree.set("parameters/Dead idle/blend_position", last_faced_direction)
	%AnimationTree.set("parameters/Dead move/blend_position", last_faced_direction)

var dead := false
var body_scene = preload("res://Scenes/Entities/dead_body.tscn")
func die() -> void:
	dead = true
	var dead_body = body_scene.instantiate()
	dead_body.global_position = global_position
	get_tree().current_scene.get_node("Level container/Body container").add_child(dead_body)
	self.set_collision_mask_value(2, false)

func live() -> void:
	dead = false
	self.set_collision_mask_value(2, true)
