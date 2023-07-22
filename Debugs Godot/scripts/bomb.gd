extends RigidBody2D
var bomb = preload("res://scenes/Explosion.tscn")

func _ready():
	pass
	
func _process(_delta):
	pass

func _on_timer_timeout():
	var bomb_instance = bomb.instantiate()
	bomb_instance.global_position = global_position
	get_parent().add_child(bomb_instance)
	bomb_instance.rotation_degrees = rotation_degrees
	queue_free()
