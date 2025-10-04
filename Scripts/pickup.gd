extends Area2D

@export_enum("Health", "Key", "Final Key") var Pickup_type = "Health"

@export var ID : int

var key_id : String
func _ready() -> void:
	match Pickup_type:
		"Key":
			key_id = "Key:" + str(ID)
			%Sprite2D.frame = 0
			if SaveManager.has_key(key_id):
				queue_free()
		"Final Key":
			key_id = "Final Key:" + str(ID)
			%Sprite2D.frame = 2
			if SaveManager.final_key:
				queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		match Pickup_type:
			"Health":
				if body.dead:
					body.live()
					queue_free()
			"Key":
				if !body.dead:
					SaveManager.collect_key(key_id)
					queue_free()
			"Final Key":
				if !body.dead:
					SaveManager.collect_final_key(key_id)
					queue_free()
