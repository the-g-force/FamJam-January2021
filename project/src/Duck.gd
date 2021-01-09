class_name Duck
extends KinematicBody2D

export var gravity := 20.0
export var speed := 50
export var max_speed := 15

var _velocity := Vector2.ZERO

onready var _DuckBullet := load("res://src/DuckBullet.tscn")
onready var _bullet_spawn_point := $BulletSpawnPoint

func _physics_process(delta):
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
	_velocity.y += gravity * delta
	
	var collision := move_and_collide(_velocity)
	if collision != null:
		print("Dead")
		queue_free()
	
	if Input.is_action_just_pressed("fire"):
		var bullet : Node2D = _DuckBullet.instance()
		bullet.position = position + $BulletSpawnPoint.position
		get_parent().add_child(bullet)


func damage():
	print("quack")
	queue_free()
