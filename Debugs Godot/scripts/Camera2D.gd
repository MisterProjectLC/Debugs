extends Camera2D
var alive

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.alive + 1 == alive or Global.explosion == 1:
		var tween = create_tween()
		tween.tween_property(self, "position", Vector2(957, 542), 0.02)
		tween.chain().tween_property(self, "position", Vector2(967, 552), 0.02)
		tween.chain().tween_property(self, "position", Vector2(957, 542), 0.02)
		tween.chain().tween_property(self, "position", Vector2(967, 552), 0.02)
		tween.chain().tween_property(self, "position", Vector2(957, 542), 0.02)
		tween.chain().tween_property(self, "position", Vector2(967, 552), 0.02)
		tween.chain().tween_property(self, "position", Vector2(957, 542), 0.02)
		tween.chain().tween_property(self, "position", Vector2(967, 552), 0.02)
		Global.explosion = 0
	position = Vector2(962,547)
	alive = Global.alive
