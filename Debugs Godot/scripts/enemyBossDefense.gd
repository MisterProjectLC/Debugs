extends RigidBody2D
var life = 40

func _ready():
	pass

func _process(_delta):
	if Global.defense == 0:
		visible = false
		$CollisionShape2D.disabled = true
		$Area2D/CollisionShape2D.disabled = true
	else:
		visible = true
		$CollisionShape2D.disabled = false
		$Area2D/CollisionShape2D.disabled = false

func _on_area_2d_body_entered(body):
	if "bulletPlayer" in body.name:
		life -= Global.dmg
		call_deferred("damaged")
	if life <= 0:
		queue_free()

func damaged():
	$Sprite2D.play("damage")
	$Timer.start()

func _on_timer_timeout():
	$Sprite2D.play("normal")
