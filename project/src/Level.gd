extends Node2D

export var background_scroll_speed := 75.0

func _process(delta):
	$ParallaxBackground.scroll_offset.x -= background_scroll_speed * delta
