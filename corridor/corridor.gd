extends Node3D

var timer: Timer = Timer.new()


func _ready() -> void:
	timer.wait_time = 5
	timer.autostart = true
	timer.timeout.connect(_timer_timeout)
	add_child(timer)


func _process(delta: float) -> void:
	global_translate(Vector3(0, 0, 0.25))


func _timer_timeout() -> void:
	queue_free()
