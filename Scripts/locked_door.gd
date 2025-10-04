extends Interactable

@export var ID : int

var door_id : String
func _ready() -> void:
	if SaveManager.is_door_unlocked(door_id):
		set_collision_layer_value(1, false)
		%AnimationPlayer.play("Key/Open")
	
	if player != null:
		player.interact.connect(_on_player_interact)

func _on_player_interact(_input_dir:Vector2):
	if interactable and in_trigger and !player.dead:
		if SaveManager.keys > 0:
			SaveManager.use_key()
			SaveManager.set_door_unlocked(door_id, true)
			set_collision_layer_value(1, false)
			%AnimationPlayer.play("Key/Open")
