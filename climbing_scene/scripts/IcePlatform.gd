extends StaticBody2D

func _on_SlipperyArea_body_entered(body : PhysicsBody2D) -> void:
	if body is PlayerGoatFixedJump:
		body.slip(true)


func _on_SlipperyArea_body_exited(body : PhysicsBody2D) -> void:
	if body is PlayerGoatFixedJump:
		body.slip(false)
