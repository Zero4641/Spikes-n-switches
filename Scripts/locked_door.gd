extends Interactable

@export var ID : int
@export var boss_door := false

var door_id : String
func _ready() -> void:
	if boss_door:
		door_id = "Boss_door:" + str(ID)
		%Sprite2D.frame = 1
	else :
		door_id = "Door:" + str(ID)
	
	if SaveManager.is_door_unlocked(door_id):
		self.process_mode = Node.PROCESS_MODE_DISABLED
		%Sprite2D.frame = 0
	
	if player != null:
		player.interact.connect(_on_player_interact)

func _on_player_interact(_input_dir:Vector2):
	if interactable and in_trigger and !player.dead:
		if boss_door and SaveManager.final_key:
			SaveManager.set_door_unlocked(door_id, true)
			self.process_mode = Node.PROCESS_MODE_DISABLED
			%Sprite2D.frame = 0
		elif !boss_door and SaveManager.keys > 0:
			SaveManager.set_door_unlocked(door_id, true)
			self.process_mode = Node.PROCESS_MODE_DISABLED
			%Sprite2D.frame = 0
