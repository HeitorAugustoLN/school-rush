extends Node3D

@export var player: CharacterBody3D
@export var corridor: PackedScene = preload("res://corridor/corridor.tscn")
@export var money: PackedScene = preload("res://money/money.tscn")
@export var obstacle: PackedScene = preload("res://obstacles/obstacle.tscn")
@export var corridor_timer: Timer
@export var money_timer: Timer
@export var obstacle_timer: Timer

var startz: float = -36
const LANES: Array[int] = [-3, 0, 3]
var last_obstacle_lane: int = -1


func _ready() -> void:
	randomize()
	var corridor_asset = corridor.instantiate()
	add_child(corridor_asset)
	corridor_asset.global_transform.origin = Vector3(0, 0, startz)
	corridor_asset.global_transform.basis = Basis(Vector3.UP, deg_to_rad(90))


func _on_corridor_timer_timeout() -> void:
	var corridor_asset = corridor.instantiate()
	add_child(corridor_asset)
	corridor_asset.global_transform.origin = Vector3(0, 0, startz)
	corridor_asset.global_transform.basis = Basis(Vector3.UP, deg_to_rad(90))


func _on_money_timer_timeout() -> void:
	var lane_index = randi() % LANES.size()
	var attempts = 0
	while lane_index == last_obstacle_lane and attempts < 5:
		lane_index = randi() % LANES.size()
		attempts += 1

	var lane_pos = LANES[lane_index]

	var trail_length = randi_range(5, 10)
	for i in range(trail_length):
		var money_instance: Area3D = money.instantiate()
		add_child(money_instance)
		var z_pos = startz + i * 2.5
		money_instance.global_transform.origin = Vector3(lane_pos, 1.0, z_pos)


func _on_obstacle_timer_timeout() -> void:
	obstacle_timer.wait_time = randf_range(2.0, 4.0)

	var lane_index = randi() % LANES.size()
	var attempts = 0
	while lane_index == last_obstacle_lane and attempts < 5:
		lane_index = randi() % LANES.size()
		attempts += 1
	last_obstacle_lane = lane_index

	var lane_pos = LANES[lane_index]

	var obstacle_instance: Area3D = obstacle.instantiate()
	add_child(obstacle_instance)
	var z_pos = startz + randf_range(0, 5)
	obstacle_instance.global_transform.origin = Vector3(lane_pos, 1.0, z_pos)
