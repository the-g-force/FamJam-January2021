extends Node2D


const alien := preload("res://src/Alien.tscn")

var screensize : Vector2
var scrolling_left := true #If true, aliens come from right

export var alien_spawn_interval := 2.0
export var background_scroll_speed := 75.0


func _ready():
	randomize()
	$Timer.start(alien_spawn_interval)
	screensize = get_viewport_rect().size


func _process(delta):
	$ParallaxBackground.scroll_offset.x -= background_scroll_speed * delta


func _alien_died(location:Vector2):
	pass


func _on_Timer_timeout():
	var alien_location := rand_range(0, screensize.y)
	var alien_instance := alien.instance()
	if scrolling_left:
		alien_instance.position = Vector2(screensize.x, alien_location)
		alien_instance.go_to_left = true
	else:
		alien_instance.position = Vector2(0, alien_location)
		alien_instance.go_to_left = false
	var _ignore = alien_instance.connect("dead", self, "_alien_died")
	$Aliens.add_child(alien_instance)
