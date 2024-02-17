extends RigidBody2D

signal hit_own 

var is_eco
var is_in_area = false 

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

func check_if_trapped():
	if is_in_area:
		hit_own.emit()
		#queue_free()

func _on_area_2d_body_entered(body):
	print(body.name)
	if body.name == "player_manager":
		print("lasdf")
		is_in_area = true
		check_if_trapped()

func _on_area_2d_body_exited(body):
	if body.name == "player_manager":
		is_in_area = false
		check_if_trapped()
