extends Area2D
@onready var game_manager = %GameManager
@onready var score_count = %ScoreCount
@onready var animation_player = $PickUpSound/AnimationPlayer

func _on_body_entered(body):
	game_manager.add_point()
	score_count.text = str("X ", game_manager.score)
	animation_player.play("pickup")
