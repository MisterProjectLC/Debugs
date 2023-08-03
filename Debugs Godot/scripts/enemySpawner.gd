extends RigidBody2D
var life = 8
var spawn1 = preload("res://scenes/enemySpawn_1.tscn")
var spawn2 = preload("res://scenes/enemySpawn_2.tscn")
var blood = preload("res://scenes/blood.tscn")

func _ready():
	if Global.index >= 9:
		life = 20
	elif Global.index >= 6:
		life = 16
	elif Global.index >= 3:
		life = 12
	
func _process(delta):
	var posx = global_position.x - Global.player_position.x
	var posy = global_position.y - Global.player_position.y
	var velocity = Vector2()
	if posx > 0 and posx < 700 and global_position.x < 1820:
		velocity.x += 3
	if posx < 0 and posx > -700 and global_position.x > 100:
		velocity.x -= 3
	if posy > 0 and posy < 350 and global_position.y < 1060:
		velocity.y += 3
	if posy < 0 and posy > -350 and global_position.y > 70:
		velocity.y -= 3
	move_and_collide(velocity.normalized() * 300 * delta)

func _on_area_2d_body_entered(body):
	if "player" in body.name and Global.upgrades[3] == 1:
		Global.alive -= 1
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
		Global.alive -= 1
		call_deferred("_on_timer_timeout")
		call_deferred("_on_timer_timeout")
		call_deferred("_on_timer_timeout")
		var blood_instance = blood.instantiate()
		blood_instance.global_position = global_position
		var direction = (Global.player_position - global_position).normalized()
		blood_instance.rotation = (direction * -1).angle() 
		get_parent().add_child(blood_instance)
		queue_free()


func _on_timer_timeout():
	var mark = randi_range(1,5)
	var spawn_instance
	match mark:
		1,2,3,4: 	
			spawn_instance = spawn1.instantiate()
		5:
			spawn_instance = spawn2.instantiate()
	var direction = (Global.player_position - global_position).normalized()
	spawn_instance.global_position = global_position + direction * 85
	get_parent().add_child(spawn_instance)
	spawn_instance.rotation_degrees = rotation_degrees

func damaged():
	$Sprite2D.play("damage")
	$Timer2.start()

func _on_timer_2_timeout():
	$Sprite2D.play("normal")
