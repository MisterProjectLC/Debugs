extends RigidBody2D

func _ready():
	$AnimatedSprite2D.play()

func _process(_delta):
	pass

func _on_timer_timeout():
	queue_free()

