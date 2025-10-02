extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("body deteceted")
	if body is Interactable:
		body.in_trigger = true
		print("body is an interactable")

func _on_body_exited(body: Node2D) -> void:
	print("body left")
	if body is Interactable:
		body.in_trigger = false
		print("body was a interactable")
