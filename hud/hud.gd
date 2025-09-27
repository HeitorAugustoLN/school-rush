extends CanvasLayer

@onready var money_score: Label = $MoneyScore
@onready var score: Label = $Score
@onready var math_question_label: Label = $MathQuestion


func _ready() -> void:
	money_score.text = str(Score.money)
	score.text = str(Score.score)
	Score.money_changed.connect(_on_money_changed)
	Score.score_changed.connect(_on_score_changed)


func _on_money_changed(amount: int) -> void:
	money_score.text = str(amount)


func _on_score_changed(amount: int) -> void:
	score.text = str(amount)


func show_math_question(expression: String) -> void:
	math_question_label.text = expression
	math_question_label.visible = true


func hide_math_question() -> void:
	math_question_label.visible = false
