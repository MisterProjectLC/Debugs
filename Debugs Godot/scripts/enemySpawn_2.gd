extends RigidBody2D
var life = 2
var bullet = preload("res://scenes/BulletEnemy.tscn")
var blood = preload("res://scenes/blood - spawns.tscn")

func _ready():
	if Global.index >= 9:
		life = 5
	elif Global.index >= 6:
		life = 4
	elif Global.index >= 3:
		life = 3
	
func _process(_delta):
	position += (Global.player_position - position) / 60
	look_at(Global.player_position)
	move_and_collide(Vector2())

func _on_area_2d_body_entered(body):
	if "player" in body.name and Global.upgrades[3] == 1:
		queue_free()
	if "bulletPlayer" in body.name:
		life -= Global.dmg
		call_deferred("damaged")
	elif "enemyBullet" in body.name:
		life -= 1
		call_deferred("damaged")
	elif "enemyExplosion" in body.name:
		life -= 5
		call_deferred("damaged")
	if life <= 0:
		call_deferred("fire")
		queue_free()
		
func fire():
	var bullet_instance = bullet.instantiate()
	var direction = (Global.player_position - global_position).normalized()
	bullet_instance.global_position = global_position + direction
	get_parent().add_child(bullet_instance)
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_central_impulse(direction * 1100)
	var blood_instance = blood.instantiate()
	blood_instance.global_position = global_position
	blood_instance.rotation = (direction * -1).angle() 
	get_parent().add_child(blood_instance)


func _on_timer_timeout():
	fire()
	queue_free()

func damaged():
	$Sprite2D.play("damage")
	$Timer2.start()

func _on_timer_2_timeout():
	$Sprite2D.play("normal")
