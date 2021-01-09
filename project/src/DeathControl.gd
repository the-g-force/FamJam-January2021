extends Control

func play_animation()->void:
	$AnimationPlayer.play("death")
	

func _on_MenuButton_pressed():
	Global.play_button_sound()
	Global.duck_is_dead = false
	var _ignored := get_tree().change_scene("res://src/MenuScene.tscn")


func _on_PlayAgainButton_pressed():
	Global.play_button_sound()
	Global.duck_is_dead = false
	var _ignored := get_tree().change_scene("res://src/Level.tscn")
