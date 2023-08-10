extends Node
@onready var player_position 
var explosion = 0
var bullet_distance = 40
var defense = 0
var dmg = 2
var alive = 0
var index = 0
var mark = 0 
var gun = "p"
var firetime = 0.33
var upgrades = [0,0,0,0]
var bullet_speed = 1500
var change_gun = ["p", 0.33, 2, 1500, 45]

func _ready():
	pass 

func _process(_delta):
	pass
