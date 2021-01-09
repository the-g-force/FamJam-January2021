extends Node2D

const alien := preload("res://src/Alien.tscn")
const _DeathControl := preload("res://src/DeathControl.tscn")

var screensize : Vector2
var scrolling_left := true #If true, aliens come from right
var score := 0

export var alien_spawn_interval := 2.0
export var background_scroll_speed := 75.0

onready var _death_control := $DeathControl


func _ready():
	randomize()
	$Timer.start(alien_spawn_interval)
	screensize = get_viewport_rect().size


func _process(delta):
	$ParallaxBackground.scroll_offset.x -= background_scroll_speed * delta
	$HUD/Label.text = "Aliens Destroyed: "+str(score)


func _on_Timer_timeout():
	var alien_location := rand_range(0, screensize.y)
	var alien_instance := alien.instance()
	alien_instance.position = Vector2(screensize.x, alien_location)
	var _ignore = alien_instance.connect("destroyed", self, "_on_Alien_destroyed")
	$Aliens.add_child(alien_instance)


func _on_Alien_destroyed(_alien:Object):
	print("Alien was destroyed, get some points")
	score += 1


func _on_Duck_death_complete():
	_death_control.visible = true
