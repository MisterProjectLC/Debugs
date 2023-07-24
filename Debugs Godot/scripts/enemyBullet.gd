extends RigidBody2D
var life = 40

func _ready():
	pass

func _process(_delta):
	pass

func _on_area_2d_body_entered(body):
	if "bulletPlayer" in body.name:
		life -= Global.dmg
	elif "enemyBullet" in body.name:
		life -= 1
	if life <= 0:
		queue_free()
