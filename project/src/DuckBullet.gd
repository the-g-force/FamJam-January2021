extends Area2D

export var speed := 500

func _physics_process(delta):
	position.x += speed * delta


func _draw():
	var shape = $CollisionShape2D.shape
	draw_rect(Rect2(-shape.extents.x/2, -shape.extents.y/2, shape.extents.x*2, shape.extents.y*2), Color.whitesmoke)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_DuckBullet_body_entered(body):
	if body is Alien:
		body.damage()
		queue_free()
