extends Node2D

func _ready():
	$AnimationPlayer.play("Story")


func _on_MainMenuButton_pressed():
	_go_to_main_menu()


func _go_to_main_menu()->void:
	var _ignored := get_tree().change_scene("res://src/MenuScene.tscn")


func _on_AnimationPlayer_animation_finished(_anim_name):
	_go_to_main_menu()
