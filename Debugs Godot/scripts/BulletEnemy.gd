extends RigidBody2D

var speed = 400

func _ready():
	pass 

func _process(_delta):
	pass

func _on_area_2d_body_entered(body):
	if "player" in body.name or "enemyS" in body.name or "enemyBomb" in body.name or "enemyV" in body.name:
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
