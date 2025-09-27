extends Node3D

@export var player: CharacterBody3D
@export var corridor: PackedScene = preload("res://corridor/corridor.tscn")
@export var money: PackedScene = preload("res://money/money.tscn")
@export var obstacle: PackedScene = preload("res://obstacles/obstacle.tscn")
@export var answer: PackedScene
@export var corridor_timer: Timer
@export var money_timer: Timer
@export var obstacle_timer: Timer
@onready var hud: CanvasLayer = $HUD

var startz: float = -36
const LANES: Array[int] = [-3, 0, 3]
var last_obstacle_lane: int = -1

var corridor_count: int = 0
var is_math_time: bool = false


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

	corridor_count += 1

	if not is_math_time and corridor_count > 0 and corridor_count % 4 == 0:
		_start_math_time()


func _on_money_timer_timeout() -> void:
	if is_math_time:
		return

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
	if is_math_time:
		return

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


func _start_math_time() -> void:
	is_math_time = true
	money_timer.stop()
	obstacle_timer.stop()

	var num1 = randi_range(1, 10)
	var num2 = randi_range(1, 10)
	var operator = ["+", "-", "*"][randi() % 3]
	var expression = "%d %s %d" % [num1, operator, num2]

	var correct_answer: int
	match operator:
		"+":
			correct_answer = num1 + num2
		"-":
			if num1 < num2:
				var temp = num1
				num1 = num2
				num2 = temp
				expression = "%d %s %d" % [num1, operator, num2]
			correct_answer = num1 - num2
		"*":
			correct_answer = num1 * num2

	hud.show_math_question(expression + " = ?")

	var answers = [correct_answer]
	while answers.size() < 3:
		var wrong_answer = correct_answer + randi_range(-5, 5)
		if wrong_answer != correct_answer and not answers.has(wrong_answer) and wrong_answer > 0:
			answers.append(wrong_answer)

	answers.shuffle()

	for i in range(answers.size()):
		var answer_instance = answer.instantiate()
		add_child(answer_instance)
		answer_instance.global_transform.origin = Vector3(LANES[i], 1.0, startz)
		var is_correct = answers[i] == correct_answer
		answer_instance.set_answer(str(answers[i]), is_correct)
		answer_instance.answered.connect(_on_answered)

	var math_timer = get_tree().create_timer(20.0)
	math_timer.timeout.connect(_on_math_timeout)


func _on_answered(is_correct: bool) -> void:
	if not is_math_time:
		return

	if is_correct:
		Score.add_score(500)
		_end_math_time()
	else:
		get_tree().change_scene_to_file("res://game-over/game-over.tscn")


func _end_math_time() -> void:
	is_math_time = false
	money_timer.start()
	obstacle_timer.start()
	hud.hide_math_question()
	get_tree().call_group("answer", "queue_free")


func _on_math_timeout() -> void:
	if is_math_time:
		_end_math_time()
