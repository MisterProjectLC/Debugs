extends RigidBody2D
var life = 200
var bullet = preload("res://scenes/enemyBossBullet.tscn")

func _ready():
	pass

func _process(_delta):
	pass


func _on_timer_timeout():
	var Pdirection = (Global.player_position - global_position).normalized()
	for i in range(8):
		var bullet_instance = bullet.instantiate()
		var angle_rad = deg_to_rad(i * 45)
		var angle_to_player = atan2(Pdirection.y, Pdirection.x)
		var rotated_direction = Vector2(cos(angle_to_player + angle_rad), sin(angle_to_player + angle_rad))
		var bullet_direction = rotated_direction.normalized()
		bullet_instance.global_position = global_position
		get_parent().add_child(bullet_instance)
		bullet_instance.apply_central_impulse(bullet_direction * 800)
		bullet_instance.rotation_degrees = rad_to_deg(angle_to_player + angle_rad)

func _on_area_2d_body_entered(body):
	if "bulletPlayer" in body.name:
		life -= Global.dmg
	if life <= 0:
		Global.alive -= 1
		queue_free()
