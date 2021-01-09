extends Node2D

signal alien_created(alien)
signal new_wave(wave)
signal wave_over
signal alien_destroyed

const _Alien := preload("res://src/Alien.tscn")

var screensize:Vector2
var _enemies_in_wave := 0
var _time_between_waves := 3
var _wave_size := 1
var _group_0 := [Vector2(0, 150), Vector2(0, 300), Vector2(0, 450)]
var _group_1 := [Vector2(150, 150), Vector2(0, 300), Vector2(150, 450)]
var _group_2 := [Vector2(0, 150), Vector2(150, 300), Vector2(0, 450)]


func _ready():
	$Timer.start(_time_between_waves)
	screensize = get_viewport_rect().size
	$PreliminaryTimer.start()
	print(str(Global.duck_is_dead))


func _new_wave():
	var groups := []
	for _i in _wave_size:
		var wave_type := randi()%3
		var wave:Array = get("_group_"+str(wave_type))
		groups.append(wave)
		_enemies_in_wave += wave.size()
	for wave in groups:
		if not Global.duck_is_dead:
			for point in wave:
				var alien := _Alien.instance()
				alien.position.y = point.y
				alien.position.x = screensize.x+point.x
				var _error = alien.connect("destroyed", self, "_alien_destroyed")
				_error = alien.connect("went_off_screen", self, "_alien_off_screen")
				emit_signal("alien_created", alien)
		yield(get_tree().create_timer(4), "timeout")
	_wave_size += 1


func _alien_off_screen():
	_enemies_in_wave -= 1
	if _enemies_in_wave == 0:
		$Timer.start(_time_between_waves)
		$PreliminaryTimer.start()


func _alien_destroyed(_what):
	_enemies_in_wave -= 1
	emit_signal("alien_destroyed")
	if _enemies_in_wave == 0:
		$Timer.start(_time_between_waves)
		emit_signal("wave_over")
		$PreliminaryTimer.start()


func _on_Timer_timeout():
	_new_wave()


func _on_PreliminaryTimer_timeout():
	emit_signal("new_wave", _wave_size)
