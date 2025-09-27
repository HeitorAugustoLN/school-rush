extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $"player/AnimationPlayer"

const MOVE_SPEED: float = 8.0
const JUMP_VELOCITY: float = 8.0
const GRAVITY: float = 24.0

const LANES: Array[int] = [-3, 0, 3]
var current_lane: int = 1
var target_lane: int = 1

var starting_point: Vector3 = Vector3.ZERO

var is_jumping: bool = false
var is_dead: bool = false


func _ready() -> void:
	add_to_group("player")
	starting_point = global_transform.origin
	animation_player.get_animation("mixamo_com").loop_mode = Animation.LOOP_LINEAR
	animation_player.play("mixamo_com")


func _process(delta: float) -> void:
	Score.add_score(int(delta * 100))


func _physics_process(delta: float) -> void:
	var direction: Vector3 = Vector3.ZERO

	if Input.is_action_just_pressed("ui_left") and target_lane > 0:
		target_lane -= 1
	if Input.is_action_just_pressed("ui_right") and target_lane < LANES.size() - 1:
		target_lane += 1

	var target_x: float = LANES[target_lane]
	var current_x: float = global_transform.origin.x
	global_transform.origin.x = lerp(current_x, target_x, MOVE_SPEED * delta)

	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	else:
		velocity.y = 0

	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = JUMP_VELOCITY

	move_and_slide()
