extends Control

@onready var music_index := AudioServer.get_bus_index("Music")
@onready var SFX_index := AudioServer.get_bus_index("SFX")

var options := false
func _ready() -> void:
	$Options/Fullscreen.button_pressed = (DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN)
	$"Options/SFX slider".value = AudioServer.get_bus_volume_linear(SFX_index)
	$"Options/Music slider".value = AudioServer.get_bus_volume_linear(music_index)
	$FieldDayLoop.play()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("interact"):
		if options:
			options = false
		else:
			get_tree().quit()

func _physics_process(_delta: float) -> void:
	$Main.visible = !options
	$Main/Start.disabled = !$Main.visible
	$Main/Options.disabled = !$Main.visible
	$Options.visible = options

func _on_start_pressed() -> void:
	$UpdateFlashlightC.play()
	SaveManager.reset()
	get_tree().current_scene.switch_scene_fade("res://Scenes/rooms/room_1.tscn", Vector2(616, 616), false, true)

func _on_options_pressed() -> void:
	options = true

func _on_sfx_slider_value_changed(value: float) -> void:
	$"Options/SFX lable".text = "SFX: " + str(int(value*100)) + "%"
	AudioServer.set_bus_volume_linear(SFX_index, value)

func _on_music_slider_value_changed(value: float) -> void:
	$"Options/Music lable".text = "Music:" + str(int(value*100)) + "%"
	AudioServer.set_bus_volume_linear(music_index, value)

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		if  DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
