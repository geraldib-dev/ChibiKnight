extends Area2D


@onready var timer = $Timer
@onready var knight = %Knight

func _on_body_entered(body):
	knight.die()
	timer.start()


func _on_timer_timeout():
	get_tree().reload_current_scene()
