extends RigidBody2D
var life = 7
var bullet = preload("res://scenes/bomb.tscn")
var blood = preload("res://scenes/blood.tscn")
var can_fire = false


func _ready():
	if Global.index >= 9:
		life = 16
	elif Global.index >= 6:
		life = 13
	elif Global.index >= 3:
		life = 10
	$Timer.set_wait_time(3)

func _process(_delta):
	if can_fire:
		$Timer.set_wait_time(2.5)


func _on_timer_timeout():
	var bullet_instance = bullet.instantiate()
	var direction = (Global.player_position - global_position).normalized()
	bullet_instance.global_position = global_position + direction * 100
	get_parent().add_child(bullet_instance)
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_central_impulse(direction * 900)
	can_fire = true

func _on_area_2d_body_entered(body):
	if "player" in body.name and Global.upgrades[3] == 1:
		Global.alive -= 1
		queue_free()
	if "bulletPlayer" in body.name:
		life -= Global.dmg
		call_deferred("damaged")
	elif "enemyExplosion" in body.name:
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
	$Timer2.start()

func _on_timer_2_timeout():
	$Sprite2D.play("normal")
