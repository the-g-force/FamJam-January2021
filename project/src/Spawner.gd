extends Node2D

signal alien_created(alien)

const _Alien := preload("res://src/Alien.tscn")

var screensize:Vector2


func _ready():
	screensize = get_viewport_rect().size


func _on_Timer_timeout():
	var alien := _Alien.instance()
	alien.position.y = rand_range(0, screensize.y)
	alien.position.x = screensize.x
	emit_signal("alien_created", alien)
