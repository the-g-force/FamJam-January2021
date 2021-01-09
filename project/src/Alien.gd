class_name Alien
extends KinematicBody2D

signal destroyed(location)

export var speed := 100
export var shoot_delay := 2
var destroyed := false

onready var _AlienBullet := load("res://src/AlienBullet.tscn")


func _ready():
	var anim := randi()%7
	$Sprite.play(str(anim))
	$Timer.start(shoot_delay)


func _process(delta):
	var yspeed := 0 if not destroyed else 500*delta
	var xspeed = -(speed*delta) if not destroyed else (-300*delta)
	
	var velocity := Vector2(xspeed, yspeed)
	var collision := move_and_collide(velocity)
	if position.y >= get_viewport_rect().size.y-40 and destroyed:
		var _explosion:Node2D = load("res://src/Explosion.tscn").instance()
		_explosion.position = get_global_transform().origin
		get_tree().get_root().add_child(_explosion)
		queue_free()
	if collision!=null and not destroyed:
		damage()
	
	if destroyed:
		var wobble := randi()%2
		if wobble == 0:
			$Sprite.rotation_degrees += 5
		else:
			$Sprite.rotation_degrees -= 5


func _on_Timer_timeout():
	var bullet:Node2D = _AlienBullet.instance()
	bullet.position = get_global_transform().origin
	get_tree().get_root().add_child(bullet)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func damage():
	emit_signal("destroyed", self)
	destroyed = true
	$Timer.stop()
