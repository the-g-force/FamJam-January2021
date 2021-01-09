extends Control


onready var _fullscreen_button := $FullScreenButton

func _ready():
	_fullscreen_button.pressed = OS.window_fullscreen


func _on_PlayButton_pressed():
	get_tree().change_scene("res://src/Level.tscn")


func _on_StoryButton_pressed():
	get_tree().change_scene("res://src/StoryScene.tscn")


func _on_FullScreenButton_pressed():
	OS.window_fullscreen = _fullscreen_button.pressed
