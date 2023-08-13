extends RigidBody2D

@export var speed = 500 
var screen_size
var bullet = preload("res://scenes/Bullet.tscn")
var blood = preload("res://scenes/blood - player.tscn")
var debbug = preload("res://scenes/debbuger - broken.tscn")
var can_fire = true

func _ready():
	$Timer.set_wait_time(Global.firetime)
	screen_size = get_viewport_rect().size
	
func _process(delta):
	Global.player_position = self.global_position
	match (Global.gun):
		"p": $AnimatedSprite2D.play("default")
		"s": $AnimatedSprite2D.play("shotgun")
		"a": $AnimatedSprite2D.play("ak47")
		"n": $AnimatedSprite2D.play("sniper")
	var velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1   
	if Input.is_action_pressed("move_down"):
		velocity.y += 1  
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("fire") and can_fire: 
		fire(Global.gun)
	if Input.is_action_just_pressed("change_gun"): 
		var aux = [Global.gun, Global.firetime, Global.dmg, Global.bullet_speed, Global.bullet_distance]
		Global.gun = Global.change_gun[0]
		Global.firetime = Global.change_gun[1]
		$Timer.set_wait_time(Global.firetime)
		Global.dmg = Global.change_gun[2]
		Global.bullet_speed = Global.change_gun[3]
		Global.bullet_distance = Global.change_gun[4]
		Global.change_gun[0] = aux[0]
		Global.change_gun[1] = aux[1]
		Global.change_gun[2] = aux[2]
		Global.change_gun[3] = aux[3]
		Global.change_gun[4] = aux[4]
		
	move_and_collide(velocity.normalized() * speed * delta)
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	look_at(get_global_mouse_position())
	
func fire(gun):
	if gun == "p" or gun == "a" or gun == "n":
		can_fire = false
		var bullet_instance = bullet.instantiate()
		get_parent().add_child(bullet_instance)
		var direction = (get_global_mouse_position() - global_position).normalized()
		bullet_instance.position = global_position + direction * Global.bullet_distance
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_central_impulse(direction * Global.bullet_speed)
	elif gun == "s":
		can_fire = false
		var bullet_instance = bullet.instantiate()
		var bullet_instance1 = bullet.instantiate()
		var bullet_instance2 = bullet.instantiate()
		var bullet_instance3 = bullet.instantiate()
		get_parent().add_child(bullet_instance)
		get_parent().add_child(bullet_instance1)
		get_parent().add_child(bullet_instance2)
		get_parent().add_child(bullet_instance3)
		var direction = (get_global_mouse_position() - global_position).normalized()
		bullet_instance.position = global_position + direction * Global.bullet_distance
		bullet_instance1.position = global_position + direction * Global.bullet_distance
		bullet_instance2.position = global_position + direction * Global.bullet_distance
		bullet_instance3.position = global_position + direction * Global.bullet_distance
		bullet_instance.apply_central_impulse(direction * Global.bullet_speed - Vector2(0,30))
		bullet_instance1.apply_central_impulse(direction * Global.bullet_speed + Vector2(100,500))
		bullet_instance2.apply_central_impulse(direction * Global.bullet_speed - Vector2(200,200))
		bullet_instance3.apply_central_impulse(direction * Global.bullet_speed)
	$Timer.start()

func _on_timer_timeout():
	can_fire = true
	
func _on_area_2d_body_entered(body): 
	if "enemy" in body.name:
		if Global.upgrades[3] == 1:
			Global.upgrades[3] = 0
			var debbug_instance = debbug.instantiate()
			debbug_instance.global_position = global_position 
			get_parent().add_child(debbug_instance)
		else: 
			var blood_instance = blood.instantiate()
			blood_instance.global_position = global_position 
			get_parent().add_child(blood_instance)
			queue_free()
			get_tree().change_scene_to_file("res://scenes/kill.tscn")
	if "shotgun" in body.name:
		Global.gun = "s"
		Global.firetime = 0.75
		$Timer.set_wait_time(Global.firetime)
		Global.dmg = 3
		Global.bullet_speed = 1500
		Global.bullet_distance = 55
		body.queue_free()
	elif "sniper" in body.name:
		Global.gun = "n"
		Global.dmg = 12
		Global.bullet_speed = 2000
		Global.firetime = 1
		Global.bullet_distance = 80
		$Timer.set_wait_time(Global.firetime)
		body.queue_free()
	elif "ak47" in body.name:
		Global.gun = "a"
		Global.firetime = 0.2
		$Timer.set_wait_time(Global.firetime)
		Global.bullet_distance = 63
		body.queue_free()
	if "RTX" in body.name:
		speed = 600
		Global.upgrades[0] = 1
		body.queue_free()
	if "BB" in body.name:
		Global.upgrades[1] = 1
		body.queue_free()
		match Global.gun:
			"p": Global.dmg = 3
			"s": Global.dmg = 4
			"m": Global.dmg = 3
			"n": Global.dmg = 18
		match  Global.change_gun[0]:
			"p": Global.change_gun[2] = 3
			"s": Global.change_gun[2] = 4
			"m": Global.change_gun[2] = 3
			"n": Global.change_gun[2] = 15
	if "qsort" in body.name:
		Global.upgrades[2] = 1
		body.queue_free()
		match Global.gun:
			"p": Global.firetime = 0.25
			"s": Global.firetime = 0.6
			"m": Global.firetime = 0.15
			"n": Global.firetime = 0.8
		match Global.change_gun[0]:
			"p": Global.change_gun[1] = 0.25
			"s": Global.change_gun[1] = 0.6
			"m": Global.change_gun[1] = 0.15
			"n": Global.change_gun[1] = 0.8
		$Timer.set_wait_time(Global.firetime)
	if "debbuger" in body.name:
		Global.upgrades[3] = 1
		body.queue_free()
