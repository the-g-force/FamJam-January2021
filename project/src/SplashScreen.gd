extends Control

func _input(event):
	if _is_continue_trigger(event):
		var _ignored := get_tree().change_scene("res://src/MenuScene.tscn")


func _is_continue_trigger(event):
	if event is InputEventKey and event.is_pressed():
		return true
	elif event is InputEventMouseButton and event.is_pressed():
		return true
	else:
		return false
