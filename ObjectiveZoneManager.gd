extends Node

@export var spawn_offset_x = 10
@export var spawn_offset_y = 10
@export var nb_zone = 2

@export var ground_middle_left_lim = 0
@export var ground_middle_right_lim = 0
@export var ground_middle_y = 0

var objective_zone_template

var player_is_eco = true
signal increase_score_current(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	objective_zone_template = get_node("ObjectiveZone")
	reset_zone()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset_zone():
	deploy_zone()

func deploy_zone():
	#TODO : extend the random placement to other layers
	var crt_zone
	var x_coor
	var x_l
	var x_lim_left = ground_middle_left_lim + spawn_offset_x
	var x_lim_right = ground_middle_right_lim - spawn_offset_x
	for i in range(nb_zone):
		x_coor = randi_range(x_lim_left, x_lim_right)
		var y_coor = ground_middle_y - spawn_offset_y
		crt_zone = objective_zone_template.duplicate()
		crt_zone.position = Vector2(x_coor, y_coor)
		get_tree().root.add_child.call_deferred(crt_zone)
		crt_zone.visible = true
		$ObjectiveZone/CollisionShape2D.disabled = false
		if player_is_eco:
			$ObjectiveZone/Sprite2D.texture = load("res://sprites/zone_eco1_light.png")
		else:
			$ObjectiveZone/Sprite2D.texture = load("res://sprites/zone_indu1_light.png")

func is_complete():
	$ObjectiveZone/CollisionShape2D.disabled = true
	if player_is_eco:
		$ObjectiveZone/Sprite2D.texture = load("res://sprites/objective_eco1.png")
	else:
		$ObjectiveZone/Sprite2D.texture = load("res://sprites/objective1_indu.png")

func _on_player_manager_objective_complete():
	is_complete()
