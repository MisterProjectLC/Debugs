extends RigidBody2D
var life = 7
var bullet = preload("res://scenes/bomb.tscn")
var can_fire = false

func _ready():
	if Global.index >= 9:
		life = 16
	elif Global.index >= 6:
		life = 13
	elif Global.index >= 3:
		life = 10

func _process(_delta):
	var posx = global_position.x - Global.player_position.x
	var posy = global_position.y - Global.player_position.y
	if posx > 0 and posx < 1000 and global_position.x < 1820:
		position.x += 6
	if posx < 0 and posx > -1000 and global_position.x > 100:
		position.x -= 6
	if posy > 0 and posy < 500 and global_position.y < 1040:
		position.y += 6
	if posy < 0 and posy > -500 and global_position.y > 70:
		position.y -= 6


func _on_timer_timeout():
	var bullet_instance = bullet.instantiate()
	var direction = (Global.player_position - global_position).normalized()
	bullet_instance.global_position = global_position + direction
	get_parent().add_child(bullet_instance)
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_central_impulse(direction * 900)

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
