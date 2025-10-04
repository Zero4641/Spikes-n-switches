extends CharacterBody2D
class_name Player

signal interact(interact_dir:Vector2)

func _ready() -> void:
	get_parent().connect("transition_start", Callable(self, "_take_control"))
	get_parent().connect("transition_over", Callable(self, "_return_control"))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		interact.emit(last_faced_direction)

var speed : float = 300
var input_dir := Vector2.ZERO
var can_move := true
func _physics_process(_delta: float) -> void:
	input_dir = Vector2.ZERO
	if can_move:
		input_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		input_dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_dir = input_dir.normalized()
	
	velocity = input_dir * speed
	move_and_slide()
	update_animations()

var Blob_texture = preload("res://Resources/Textures/Blobbert.png")
var Ghost_texture = preload("res://Resources/Textures/Ghost.png")
var Idle := true
var last_faced_direction := Vector2.DOWN
func update_animations() -> void:
	if input_dir.length() > 0:
		Idle = false
		last_faced_direction = input_dir.normalized()
	else:
		Idle = true
	
	if dead:
		%Sprite2D.texture = Ghost_texture
	else:
		%Sprite2D.texture = Blob_texture
	
	%AnimationTree.set("parameters/conditions/Idle", Idle)
	%AnimationTree.set("parameters/conditions/Move", !Idle)
	%AnimationTree.set("parameters/conditions/Dead", dead)
	%AnimationTree.set("parameters/conditions/Alive", !dead)
	%AnimationTree.set("parameters/Alive idle/blend_position", last_faced_direction)
	%AnimationTree.set("parameters/Alive move/blend_position", last_faced_direction)
	%AnimationTree.set("parameters/Dead/blend_position", last_faced_direction)

var dead := false
func die() -> void:
	dead = true
	self.set_collision_mask_value(2, false)

func live() -> void:
	dead = false
	self.set_collision_mask_value(2, true)

func _take_control() -> void:
	can_move = false

func _return_control() -> void:
	can_move = true
