extends RigidBody2D
var life = 40
@export var spawn_distance = 85

func _ready():
	pass

func _process(_delta):
	if Global.defense == 0:
		visible = false
		collision_layer = 2
	else:
		visible = true
		collision_layer = 1

func _on_area_2d_body_entered(body):
	if "bulletPlayer" in body.name:
		life -= Global.dmg
	elif "enemyBullet" in body.name:
		life -= 1
	if life <= 0:
		queue_free()
