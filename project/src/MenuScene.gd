extends Control


onready var _fullscreen_button := $sky/FullScreenButton

func _ready():
	_fullscreen_button.pressed = OS.window_fullscreen
	Jukebox.play_menu_track()


func _on_PlayButton_pressed():
	Global.play_button_sound()
	var _ignored := get_tree().change_scene("res://src/Level.tscn")


func _on_StoryButton_pressed():
	Global.play_button_sound()	
	var _ignored := get_tree().change_scene("res://src/StoryScene.tscn")


func _on_FullScreenButton_pressed():
	Global.play_button_sound()	
	OS.window_fullscreen = _fullscreen_button.pressed
