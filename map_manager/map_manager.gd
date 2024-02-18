extends Node2D

@export var spawn_offset_x = 10
@export var spawn_offset_y = 10
@export var nb_shared_trap = 3

@export var ground_top_left_lim = 0
@export var ground_top_right_lim = 0
@export var ground_top_y = 0
@export var ground_middle_left_lim = 0
@export var ground_middle_right_lim = 0
@export var ground_middle_y = 0
@export var ground_bottom_left_lim = 0
@export var ground_bottom_right_lim = 0
@export var ground_bottom_y = 0

var rng = RandomNumberGenerator.new()

var ground_above
var ground_middle
var ground_below

var trap_shared_template

var shared_traps = []


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
	for t in shared_traps:
		if is_instance_valid(t):
			t.queue_free()
	deploy_shared_trap()

func deploy_shared_trap():
	for i in range(nb_shared_trap):
		var line = randi_range(0,2)
		var trap
		var trap_transform
		var x_coor
		var x_lim_left
		var x_lim_right
		var y_coor
		if line==0:	#bottom
			x_lim_left = ground_bottom_left_lim + spawn_offset_x
			x_lim_right = ground_bottom_right_lim - spawn_offset_x
			y_coor = ground_bottom_y - spawn_offset_y
		elif line == 1:	#middle
			x_lim_left = ground_middle_left_lim + spawn_offset_x
			x_lim_right = ground_middle_right_lim - spawn_offset_x
			y_coor = ground_middle_y - spawn_offset_y
		else:	#top
			x_lim_left = ground_top_left_lim + spawn_offset_x
			x_lim_right = ground_top_right_lim - spawn_offset_x
			y_coor = ground_top_y - spawn_offset_y
		x_coor = randi_range(x_lim_left, x_lim_right)
		trap = trap_shared_template.duplicate()
		trap.my_set_position(Vector2(x_coor, y_coor))
		add_child.call_deferred(trap)
		trap.visible = true
		shared_traps.append(trap)

func execute_trap():
	var t
	for index in shared_traps.size():
		t = shared_traps[index]
		t.activate_trap()


func _on_input_manager_activate_shared_jec(trap_id):
	execute_trap()


func _on_game_manager_new_round_signal():
	reset_map()
