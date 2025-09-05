extends Area3D

var timer: Timer = Timer.new()


func _ready() -> void:
	timer.wait_time = 5
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)


func _process(delta) -> void:
	global_translate(Vector3(0, 0, 0.25))
	rotate_y(5 * delta)


func _on_body_entered(body: Node3D) -> void:
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
