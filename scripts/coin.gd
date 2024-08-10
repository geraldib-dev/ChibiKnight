extends Area2D


func _on_body_entered(body):
	print("catched coin!")
	queue_free()
