extends RigidBody2D
var life = 8
var spawn1 = preload("res://scenes/enemySpaw_1.tscn")
var spawn2 = preload("res://scenes/enemySpawn_2.tscn")

func _ready():
	if Global.index >= 9:
		life = 20
	elif Global.index >= 6:
		life = 16
	elif Global.index >= 3:
		life = 12
	
func _process(_delta):
	var posx = global_position.x - Global.player_position.x
	var posy = global_position.y - Global.player_position.y
	if posx > 0 and posx < 700:
		position.x += 2
	if posx < 0 and posx > -700:
		position.x -= 2
	if posy > 0 and posy < 350:
		position.y += 2
	if posy < 0 and posy > -350:
		position.y -= 2

	

func _on_area_2d_body_entered(body):
	if "player" in body.name and Global.upgrades[3] == 1:
		Global.alive -= 1
		queue_free()
	if "bulletPlayer" in body.name:
		life -= Global.dmg
	elif "enemyBullet" in body.name:
		life -= 1
	elif "enemyExplosion" in body.name:
		life -= 5
	if life <= 0:
		Global.alive -= 1
		call_deferred("_on_timer_timeout")
		call_deferred("_on_timer_timeout")
		call_deferred("_on_timer_timeout")
		queue_free()


func _on_timer_timeout():
	var mark = randi_range(1,5)
	match mark:
		1,2,3,4: 	
			var spawn_instance = spawn1.instantiate()
			spawn_instance.global_position = global_position
			get_parent().add_child(spawn_instance)
			spawn_instance.rotation_degrees = rotation_degrees
		5:
			var spawn_instance = spawn2.instantiate()
			spawn_instance.global_position = global_position
			get_parent().add_child(spawn_instance)
			spawn_instance.rotation_degrees = rotation_degrees
