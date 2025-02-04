extends RigidBody2D
var life = 2
var spawn = preload("res://scenes/enemySpawn_1.tscn")
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
		queue_free()

func _on_timer_timeout():
	if filhos < 2:
		filhos += 1
		var spawn_instance = spawn.instantiate()
		var direction = (Global.player_position - global_position).normalized()
		spawn_instance.global_position = global_position + direction * -40
		get_parent().add_child(spawn_instance)
		spawn_instance.rotation_degrees = rotation_degrees
