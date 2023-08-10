extends RigidBody2D
var life = 2
var spawn = preload("res://scenes/enemySpawn_1.tscn")
var blood = preload("res://scenes/blood - spawns.tscn")
var filhos = 0

func _ready():
	if Global.index >= 9:
		life = 5
	elif Global.index >= 6:
		life = 4
	elif Global.index >= 3:
		life = 3
	
func _process(_delta):
	position += (Global.player_position - position) / 40
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
		var blood_instance = blood.instantiate()
		blood_instance.global_position = global_position
		var direction = (Global.player_position - global_position).normalized()
		blood_instance.rotation = (direction * -1).angle() 
		get_parent().add_child(blood_instance)
		queue_free()

func _on_timer_timeout():
	if filhos < 2:
		filhos += 1
		var spawn_instance = spawn.instantiate()
		var direction = (Global.player_position - global_position).normalized()
		spawn_instance.global_position = global_position + direction * -40
		get_parent().add_child(spawn_instance)
		spawn_instance.rotation_degrees = rotation_degrees


func damaged():
	$Sprite2D.play("damage")
	$Timer2.start()

func _on_timer_2_timeout():
	$Sprite2D.play("normal")


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
