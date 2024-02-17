extends RigidBody2D

var is_eco

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func is_eco_player(is_eco):
	if is_eco:
		$Sprite2D.texture = load("res://sprites/Piege-eco-poser.png")
	else:
		$Sprite2D.texture = load("res://sprites/Piege-indu-poser.png")
