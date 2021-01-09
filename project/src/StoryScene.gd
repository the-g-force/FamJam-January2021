extends Node2D

func _ready():
	$AnimationPlayer.play("Story")


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://src/MenuScene.tscn")
