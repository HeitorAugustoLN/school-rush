extends Node3D

@export var player: CharacterBody3D
@export var corridor: PackedScene = preload("res://corridor/corridor.tscn")
@export var money: PackedScene = preload("res://money/money.tscn")
@export var corridor_timer: Timer
@export var money_timer: Timer

var startz: float = -36
const LANES: Array[int] = [-3, 0, 3]


func _ready() -> void:
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
	randomize()
	money_timer.wait_time = randi() % 5 + 1

	var random_line_num = randi() % 3
	var prev_rand_line_n = null

	var line_count: int = randi() % 4 + 1

	for i in line_count:
		while prev_rand_line_n != null and prev_rand_line_n == random_line_num:
			random_line_num = randi() % 3
		prev_rand_line_n = random_line_num

		for n in randf_range(4, 10):
			var money_instance: Area3D = money.instantiate()
			add_child(money_instance)
			money_instance.global_transform.origin = Vector3(
				LANES[random_line_num], 1.0, startz + i * 2.5
			)
