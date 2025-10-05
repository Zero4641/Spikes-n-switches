extends CanvasLayer

func _ready() -> void:
	SaveManager.key_collected.connect(_on_key_collected)
	SaveManager.key_used.connect(_on_key_collected)
	SaveManager.final_key_collected.connect(_on_final_key_collected)

func _on_key_collected(keys:int) -> void:
	%Label.text = "x " + str(keys)

func _on_final_key_collected(has_key:bool) -> void:
	%"Final key".visible = has_key
