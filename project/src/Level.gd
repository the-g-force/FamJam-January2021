extends Node2D

const _DeathControl := preload("res://src/DeathControl.tscn")

var screensize : Vector2
var scrolling_left := true #If true, aliens come from right
var score := 0

export var background_scroll_speed := 75.0

onready var _death_control := $DeathControl


func _ready():
	randomize()
	screensize = get_viewport_rect().size
	Jukebox.play_game_track()


func _process(delta):
	$ParallaxBackground.scroll_offset.x -= background_scroll_speed * delta
	$HUD/Label.text = "Score: "+str(score)


func _on_Alien_destroyed(_alien:Object):
	print("Alien was destroyed, get some points")
	score += 1


func _on_Duck_death_complete():
	_death_control.visible = true


func _on_Spawner_alien_created(alien:Node2D):
	$Aliens.add_child(alien)


func _on_Spawner_alien_destroyed():
	score += 1


func _on_Spawner_new_wave(wave:int):
	$HUD/WaveLabel.visible = true
	$HUD/WaveLabel.text = "WAVE "+str(wave)
	yield(get_tree().create_timer(2), "timeout")
	$HUD/WaveLabel.visible = false


func _on_Spawner_wave_over():
	score += 5
