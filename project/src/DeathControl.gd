extends Control


func _on_MenuButton_pressed():
	get_tree().paused = false
	var _ignored := get_tree().change_scene("res://src/MenuScene.tscn")


func _on_PlayAgainButton_pressed():
	get_tree().paused = false
	var _ignored := get_tree().change_scene("res://src/Level.tscn")
