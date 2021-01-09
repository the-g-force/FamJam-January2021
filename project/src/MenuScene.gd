extends Control



func _on_PlayButton_pressed():
	get_tree().change_scene("res://src/Level.tscn")


func _on_StoryButton_pressed():
	get_tree().change_scene("res://src/StoryScene.tscn")
