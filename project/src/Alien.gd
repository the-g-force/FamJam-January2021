class_name Alien
extends Area2D


var go_to_left := true
var screensize:Vector2
export var pixels_from_screen_edge_to_die := 30
export var speed := 100
export var shoot_delay := 3
signal dead(location)

func _ready():
	screensize = get_viewport_rect().size
	$Timer.start(shoot_delay)


func _process(delta):
	if go_to_left:
		position.x -= delta*speed
		if position.x < -pixels_from_screen_edge_to_die:
			queue_free()
	else:
		position.x += delta*speed
		if position.x > screensize.x+pixels_from_screen_edge_to_die:
			queue_free()


func _draw():
	var color := Color.orange
	var radius:float = $CollisionShape2D.shape.radius
	var height:float = $CollisionShape2D.shape.height
	draw_rect(Rect2(Vector2(-height/2,-radius), Vector2(height, radius*2)), color)
	draw_circle(Vector2(height/2, 0), radius, color)
	draw_circle(Vector2(-height/2, 0), radius, color)


func _on_Alien_body_entered(body):
	if body is Bullet and body.good:
		emit_signal("dead", position)
		queue_free()


func _on_Timer_timeout():
	var bullet:KinematicBody2D = load("res://src/Bullet.tscn").instance()
	bullet.position = get_global_transform().origin
	bullet.good = false
	bullet.going_left = go_to_left
	get_tree().get_root().add_child(bullet)
