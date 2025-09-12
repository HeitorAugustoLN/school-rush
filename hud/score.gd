extends Node

signal score_changed(score_amount)
signal money_changed(money_amount)

var money: int = 0
var score: int = 0


func add_money() -> void:
	money += 1
	money_changed.emit(money)


func add_score(amount: int = 1) -> void:
	score += amount
	score_changed.emit(score)
