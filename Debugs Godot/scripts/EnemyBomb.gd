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
	if can_fire:
		fire()

func fire():
	can_fire = false
	var bullet_instance = bullet.instantiate()
	bullet_instance.global_position = Global.player_position
	get_parent().add_child(bullet_instance)
	bullet_instance.rotation_degrees = rotation_degrees
	$Timer.start()

func _on_timer_timeout():
	can_fire = true

func _on_area_2d_body_entered(body):
	if "bulletPlayer" in body.name:
		life -= Global.dmg
	elif "enemyBullet" in body.name:
		life -= 1
	elif "enemyExplosion" in body.name:
		life -= 5
	if life <= 0:
		Global.alive -= 1
		queue_free()
