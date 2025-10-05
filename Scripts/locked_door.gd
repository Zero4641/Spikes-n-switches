extends Interactable

@export var ID : int
@export var is_final : bool

var door_id : String
func _ready() -> void:
	if is_final:
		door_id = "Final door:" + str(ID)
		%Sprite2D.frame = 14
		if SaveManager.is_door_unlocked(door_id):
			set_collision_layer_value(1, false)
			%AnimationPlayer.play("Key/Final_open")
	else: 
		door_id = "door:" + str(ID)
		%Sprite2D.frame = 21
		if SaveManager.is_door_unlocked(door_id):
			set_collision_layer_value(1, false)
			%AnimationPlayer.play("Key/open")
	
	if player != null:
		player.interact.connect(_on_player_interact)

func _on_player_interact(_input_dir:Vector2):
	if interactable and in_trigger and !player.dead:
		if is_final:
			if SaveManager.final_key:
				SaveManager.set_door_unlocked(door_id, true)
				set_collision_layer_value(1, false)
				%AnimationPlayer.play("Key/Final_open")
				$UpdateChimeB.play()
		else:
			if SaveManager.keys > 0:
				SaveManager.use_key()
				SaveManager.set_door_unlocked(door_id, true)
				set_collision_layer_value(1, false)
				%AnimationPlayer.play("Key/open")
				$Lock.play()
