#Air.gd
extends PlayerState


func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		player.velocity.y = player.max_jump_velocity 
	elif msg.has("falling"):
		player.coyote_timer.start()
		

func physics_update(delta: float) -> void:
	var input_direction_x: float = (
			Input.get_action_strength("move_right")
			- Input.get_action_strength("move_left")
		) 
	
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	if player.is_on_floor():
		if is_equal_approx(player.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
	else:
		if Input.is_action_just_pressed("jump") and !player.coyote_timer.is_stopped():
			player.velocity.y = player.max_jump_velocity 
			player.coyote_timer.stop()
			
		
func _on_CoyoteTimer_timeout() -> void:
	pass # Replace with function body.
