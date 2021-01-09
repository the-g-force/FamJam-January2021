extends Control

func _input(event):
	if event is InputEventKey and event.is_pressed():
		get_tree().change_scene("res://src/MenuScene.tscn")
