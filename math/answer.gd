extends Area3D

signal answered(is_correct)

var timer: Timer = Timer.new()
var is_correct: bool = false

@onready var label: Label3D = $Label3D


func _ready() -> void:
	add_to_group("answer")
	timer.wait_time = 10
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)


func _process(delta: float) -> void:
	global_translate(Vector3(0, 0, 0.25))


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		answered.emit(is_correct)


func _on_timer_timeout() -> void:
	queue_free()


func set_answer(text: String, correct: bool) -> void:
	label.text = text
	is_correct = correct
