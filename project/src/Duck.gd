extends KinematicBody2D

export var GRAVITY := 1.0
export var SPEED := 10
export var MAX_SPEED := 15

var _velocity := Vector2.ZERO

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
	
	_velocity += direction * SPEED
	_velocity.y += GRAVITY
	
	_velocity = _velocity.clamped(MAX_SPEED)
	
	position += _velocity
	

func _draw():
	var shape = $CollisionShape2D.shape
	draw_rect(Rect2(0,0,shape.extents.x, shape.extents.y), Color.tan)
