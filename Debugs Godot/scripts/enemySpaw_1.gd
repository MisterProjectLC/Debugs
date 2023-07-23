extends RigidBody2D
var life = 3

func _ready():
	if Global.index >= 9:
		life = 6
	elif Global.index >= 6:
		life = 5
	elif Global.index >= 3:
		life = 4
	
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
