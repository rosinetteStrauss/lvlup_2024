extends RigidBody2D

var move_asked = false
var target_vector: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _integrate_forces(state):
	if move_asked:
		state.transform = Transform2D(0.0, target_vector)
		move_asked = false

func my_set_position(target):
	target_vector = target
	move_asked = true
