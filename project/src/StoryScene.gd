extends Node2D

func _ready():
	$AnimationPlayer.play("Story")


func _on_MainMenuButton_pressed():
	var _ignored := get_tree().change_scene("res://src/MenuScene.tscn")
