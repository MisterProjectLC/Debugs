extends CharacterBody2D

func _process(_delta):
	randomize()

func _on_area_2d_body_entered(body):
	randomize()
	if "player" in body.name and Global.alive <= 0:
		Global.index += 1
		match Global.index:
			1:
				Global.mark = randi_range(1,3)
				match Global.mark:
					1: get_tree().change_scene_to_file("res://scenes/sala_1.tscn")
					2: get_tree().change_scene_to_file("res://scenes/sala_2.tscn")
					3: get_tree().change_scene_to_file("res://scenes/sala_3.tscn")
			2:
				if Global.mark == 3:
					Global.mark -= 1
				else:
					Global.mark += 1
				match Global.mark:
					1: get_tree().change_scene_to_file("res://scenes/sala_1.tscn")
					2: get_tree().change_scene_to_file("res://scenes/sala_2.tscn")
					3: get_tree().change_scene_to_file("res://scenes/sala_3.tscn")
			3:
				Global.mark = randi_range(1,4)
				match Global.mark:
					1: get_tree().change_scene_to_file("res://scenes/sala_bb.tscn")
					2: get_tree().change_scene_to_file("res://scenes/sala_bt.tscn")
					3: get_tree().change_scene_to_file("res://scenes/sala_debbuger.tscn")
					4: get_tree().change_scene_to_file("res://scenes/sala_qsort.tscn")
			4:
				Global.mark = randi_range(1,3)
				match Global.mark:
					1: get_tree().change_scene_to_file("res://scenes/sala_4.tscn")
					2: get_tree().change_scene_to_file("res://scenes/sala_5.tscn")
					3: get_tree().change_scene_to_file("res://scenes/sala_6.tscn")
			5:
				if Global.mark == 3:
					Global.mark -= 1
				else:
					Global.mark += 1
				match Global.mark:
					1: get_tree().change_scene_to_file("res://scenes/sala_4.tscn")
					2: get_tree().change_scene_to_file("res://scenes/sala_5.tscn")
					3: get_tree().change_scene_to_file("res://scenes/sala_6.tscn")
			6:
				Global.mark = randi_range(1,3)
				match Global.mark:
					1: get_tree().change_scene_to_file("res://scenes/sala_minigun.tscn")
					2: get_tree().change_scene_to_file("res://scenes/sala_sniper.tscn")
					3: get_tree().change_scene_to_file("res://scenes/sala_shotgun.tscn")
			7:
				Global.mark = randi_range(1,3)
				match Global.mark:
					1: get_tree().change_scene_to_file("res://scenes/sala_7.tscn")
					2: get_tree().change_scene_to_file("res://scenes/sala_8.tscn")
					3: get_tree().change_scene_to_file("res://scenes/sala_9.tscn")
			8:
				if Global.mark == 3:
					Global.mark -= 1
				else:
					Global.mark += 1
				match Global.mark:
					1: get_tree().change_scene_to_file("res://scenes/sala_7.tscn")
					2: get_tree().change_scene_to_file("res://scenes/sala_8.tscn")
					3: get_tree().change_scene_to_file("res://scenes/sala_9.tscn")
			9:
				Global.mark = randi_range(1,4)
				while Global.upgrades[Global.mark - 1] == 1:
					Global.mark = randi_range(1,4)
				match Global.mark:
					1: get_tree().change_scene_to_file("res://scenes/sala_bb.tscn")
					2: get_tree().change_scene_to_file("res://scenes/sala_bt.tscn")
					3: get_tree().change_scene_to_file("res://scenes/sala_debbuger.tscn")
					4: get_tree().change_scene_to_file("res://scenes/sala_qsort.tscn")
			10:
				Global.mark = randi_range(1,3)
				match Global.mark:
					1: get_tree().change_scene_to_file("res://scenes/sala_10.tscn")
					2: get_tree().change_scene_to_file("res://scenes/sala_11.tscn")
					3: get_tree().change_scene_to_file("res://scenes/sala_12.tscn")
			11:
				if Global.mark == 3:
					Global.mark -= 1
				else:
					Global.mark += 1
				match Global.mark:
					1: get_tree().change_scene_to_file("res://scenes/sala_10.tscn")
					2: get_tree().change_scene_to_file("res://scenes/sala_11.tscn")
					3: get_tree().change_scene_to_file("res://scenes/sala_12.tscn")
			12:
				get_tree().change_scene_to_file("res://scenes/sala_boss.tscn")
			13:
				get_tree().change_scene_to_file("res://scenes/kill.tscn")
