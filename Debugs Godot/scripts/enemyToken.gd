extends RigidBody2D
var life = 7
@export var spawn_distance = 85
var bullet = preload("res://scenes/BulletEnemy.tscn")

func _ready():
	if Global.index >= 9:
		life = 16
	elif Global.index >= 6:
		life = 13
	elif Global.index >= 3:
		life = 10

func _process(_delta):
	var posx = global_position.x - Global.player_position.x
	if posx > 0 and posx < 900 and global_position.x < 1820:
		position.x += 2
	elif posx > 0 and posx > 1000 and global_position.x < 1820:
		position.x -= 2
	elif posx < 0 and posx > -900 and global_position.x > 100:
		position.x -= 2
	elif posx < 0 and posx < -1000 and global_position.x > 100:
		position.x += 2
	rotation_degrees = rotation_degrees

func _on_timer_timeout():
	var bullet_instance = bullet.instantiate()
	var direction = (Global.player_position - global_position).normalized()
	bullet_instance.global_position = global_position + direction * spawn_distance
	get_parent().add_child(bullet_instance)
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_central_impulse(direction * 900)

func _on_area_2d_body_entered(body):
	if "bulletPlayer" in body.name:
		life -= Global.dmg
	elif "enemyExplosion" in body.name:
		life -= 5
	if life <= 0:
		Global.alive -= 1
		queue_free()
