extends Node2D

@export var spawn_offset_x = 10
@export var spawn_offset_y = 10
@export var nb_shared_trap = 3

@export var ground_middle_left_lim = 0
@export var ground_middle_right_lim = 0
@export var ground_middle_y = 0

var rng = RandomNumberGenerator.new()

var ground_above
var ground_middle
var ground_below

var trap_shared_template


# Called when the node enters the scene tree for the first time.
func _ready():
	ground_middle = get_node("ground_middle")
	trap_shared_template = get_node("trap_shared")
	trap_shared_template.visible = false
	reset_map()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset_map():
	#TODO : anything that may be required at the very first start
	deploy_shared_trap()

func deploy_shared_trap():
	#TODO : extend the random placement to other layers
	var trap
	var trap_transform
	var x_coor
	var x_lim_left = ground_middle_left_lim + spawn_offset_x
	var x_lim_right = ground_middle_right_lim - spawn_offset_x
	var y_coor = ground_middle_y - spawn_offset_y
	for i in range(nb_shared_trap):
		x_coor = randi_range(x_lim_left, x_lim_right)
		trap = trap_shared_template.duplicate()
		trap.my_set_position(Vector2(x_coor, y_coor))
		get_tree().root.add_child.call_deferred(trap)
		trap.visible = true
