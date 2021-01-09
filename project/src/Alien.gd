class_name Alien
extends KinematicBody2D

signal destroyed(location)
signal went_off_screen

export var speed := 100
export var shoot_delay := 2.0
var _destroyed := false

onready var _AlienBullet := load("res://src/AlienBullet.tscn")
onready var _shoot_sound := $ShootSound


func _ready():
	var anim := randi()%7
	shoot_delay += rand_range(-0.5,1.5)
	$Sprite.play(str(anim))
	$Timer.start(shoot_delay)


func _process(delta):
	var yspeed := 0 if not _destroyed else 500*delta
	var xspeed = -(speed*delta) if not _destroyed else (-300*delta)
	
	var velocity := Vector2(xspeed, yspeed)
	var collision := move_and_collide(velocity)
	if position.y >= get_viewport_rect().size.y-40 and _destroyed:
		var _explosion:Node2D = load("res://src/Explosion.tscn").instance()
		_explosion.position = get_global_transform().origin
		get_parent().add_child(_explosion)
		queue_free()
	if collision!=null and not _destroyed:
		damage()
	
	if _destroyed:
		var wobble := randi()%2
		if wobble == 0:
			$Sprite.rotation_degrees += 5
		else:
			$Sprite.rotation_degrees -= 5


func _on_Timer_timeout():
	if not Global.duck_is_dead:
		var bullet:Node2D = _AlienBullet.instance()
		bullet.position = get_global_transform().origin
		get_parent().add_child(bullet)
		_shoot_sound.play()


func _on_VisibilityNotifier2D_screen_exited():
	if not _destroyed:
		emit_signal("went_off_screen")
		queue_free()


func damage():
	if not _destroyed:
		emit_signal("destroyed", self)
		$CollisionShape2D.set_deferred("disabled", true)
		_destroyed = true
		$Timer.stop()
