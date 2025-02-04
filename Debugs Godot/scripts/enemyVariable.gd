extends RigidBody2D
var life = 10
var blood = preload("res://scenes/blood.tscn")

func _ready():
	if Global.index >= 9:
		life = 22
	elif Global.index >= 6:
		life = 18
	elif Global.index >= 3:
		life = 14
	
func _process(_delta):
	position += (Global.player_position - position) / 50
	move_and_collide(Vector2())

func _on_area_2d_body_entered(body):
	if "player" in body.name and Global.upgrades[3] == 1:
		Global.alive -= 1
		queue_free()
	if "bulletPlayer" in body.name:
		life -= Global.dmg
		call_deferred("damaged")
	if "enemyBullet" in body.name:
		life -= 1
		call_deferred("damaged")
	if "enemyExplosion" in body.name:
		life -= 5
		call_deferred("damaged")
	if life <= 0:
		Global.alive -= 1
		var blood_instance = blood.instantiate()
		blood_instance.global_position = global_position
		var direction = (Global.player_position - global_position).normalized()
		blood_instance.rotation = (direction * -1).angle() 
		get_parent().add_child(blood_instance)
		queue_free()

func damaged():
	$Sprite2D.play("damage")
	$Timer.start()

func _on_timer_timeout():
	$Sprite2D.play("normal")
