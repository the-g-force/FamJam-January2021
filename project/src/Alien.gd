class_name Alien
extends KinematicBody2D

signal destroyed(location)

export var speed := 100
export var shoot_delay := 2

onready var _AlienBullet := load("res://src/AlienBullet.tscn")


func _ready():
	$Timer.start(shoot_delay)


func _process(delta):
	var velocity := Vector2(-delta*speed, 0)
	var collision := move_and_collide(velocity)
	if collision!=null:
		damage()


func _draw():
	var color := Color.orange
	var radius:float = $CollisionShape2D.shape.radius
	var height:float = $CollisionShape2D.shape.height
	draw_rect(Rect2(Vector2(-height/2,-radius), Vector2(height, radius*2)), color)
	draw_circle(Vector2(height/2, 0), radius, color)
	draw_circle(Vector2(-height/2, 0), radius, color)


func _on_Timer_timeout():
	var bullet:Node2D = _AlienBullet.instance()
	bullet.position = get_global_transform().origin
	get_tree().get_root().add_child(bullet)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func damage():
	emit_signal("destroyed", self)
	var _explosion:Node2D = load("res://src/Explosion.tscn").instance()
	_explosion.position = get_global_transform().origin
	get_tree().get_root().add_child(_explosion)
	queue_free()
