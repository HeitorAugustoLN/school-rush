extends Node3D

@export var player: CharacterBody3D
@export var corridor: PackedScene = preload("res://corridor/corridor.tscn")

var startz: float = -36

var timer: Timer = Timer.new()


func _ready():
	timer.wait_time = 2
	timer.autostart = true
	timer.timeout.connect(_timer_timeout)
	add_child(timer)

	var corridor_asset = corridor.instantiate()
	add_child(corridor_asset)
	corridor_asset.global_transform.origin = Vector3(0, 0, startz)
	corridor_asset.global_transform.basis = Basis(Vector3.UP, deg_to_rad(90))


func _timer_timeout():
	var corridor_asset = corridor.instantiate()
	add_child(corridor_asset)
	corridor_asset.global_transform.origin = Vector3(0, 0, startz)
	corridor_asset.global_transform.basis = Basis(Vector3.UP, deg_to_rad(90))
