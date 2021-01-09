extends KinematicBody2D

export var gravity := 20.0
export var speed := 50
export var max_speed := 15

var _velocity := Vector2.ZERO

const _Bullet := preload("res://src/Bullet.tscn")

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
	
	position += _velocity
	position.y += gravity * delta
	
	if Input.is_action_just_pressed("fire"):
		var bullet := _Bullet.instance()
		bullet.position = position + $BulletSpawnPoint.position
		bullet.good = true
		bullet.going_left = false
		get_parent().add_child(bullet)
	

func _draw():
	var shape = $CollisionShape2D.shape
	draw_rect(Rect2(-shape.extents.x/2,-shape.extents.y/2,shape.extents.x*2, shape.extents.y*2), Color.tan)
