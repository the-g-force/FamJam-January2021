class_name Duck
extends KinematicBody2D

signal death_complete

export var gravity := 20.0
export var speed := 50
export var max_speed := 15

var _velocity := Vector2.ZERO
var _exploding := false
var _time_elapsed :float

onready var _DuckBullet := load("res://src/DuckBullet.tscn")
onready var _bullet_spawn_point := $BulletSpawnPoint
onready var _explosionfollow := $Explosionpath/PathFollow2D
onready var _screen_size := get_viewport_rect().size
onready var _max_y := _screen_size.y - 100
onready var _shoot_sound := $ShootSoundPlayer


func _physics_process(delta):
	if not _exploding:
		var direction := Vector2.ZERO
		
		if Input.is_action_pressed("move_up"):
			direction.y -= 1
		if Input.is_action_pressed("move_down"):
			direction.y += 1
		if Input.is_action_pressed("move_left"):
			direction.x -= 1
		if Input.is_action_pressed("move_right"):
			direction.x += 1
		direction = direction.normalized()
		
		if direction.length_squared() == 0:
			_velocity = Vector2.ZERO
		
		_velocity += direction * speed * delta
		_velocity = _velocity.clamped(max_speed)
		
		var collision := move_and_collide(_velocity)
		if collision != null:
					damage()
			
		# Keep duck in playable area
		position.x = clamp(position.x, 0, _screen_size.x/2)
		position.y = clamp(position.y, 0, _max_y)
		
		if Input.is_action_just_pressed("fire"):
			_shoot_sound.play()
			var bullet : Node2D = _DuckBullet.instance()
			bullet.position = position + $BulletSpawnPoint.position
			get_parent().add_child(bullet)
	
	elif _exploding:
		_time_elapsed += delta
		_explosionfollow.unit_offset = lerp(0,1,_time_elapsed)
		if _time_elapsed >= 0.9:
			var _explosion:Node2D = load("res://src/Explosion.tscn").instance()
			_explosion.position = $Explosionpath/PathFollow2D/JetDuck.get_global_transform().origin
			get_parent().add_child(_explosion)
			emit_signal("death_complete")
			queue_free()


func damage():
	if position.y <= 100:
		rotation_degrees += 90
	_exploding = true
	Global.duck_is_dead = true
	$CollisionShape2D.set_deferred("disabled", true)
