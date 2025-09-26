extends Area3D

var timer: Timer = Timer.new()
@onready var obstacles: Array[Node3D] = [$lockers, $chair]


func _ready() -> void:
	randomize()
	timer.wait_time = 5
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	obstacles[randi() % obstacles.size()].visible = true


func _process(delta) -> void:
	global_translate(Vector3(0, 0, 0.25))


func _on_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://game-over/game-over.tscn")


func _on_timer_timeout() -> void:
	queue_free()
