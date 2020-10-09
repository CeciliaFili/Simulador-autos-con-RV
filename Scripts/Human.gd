extends KinematicBody

func _physics_process(delta):
	movement()

func movement():	
	var move_speed = 10
	var rotate_speed = 2 
 
	var move_vec = Vector3()
	if Input.is_key_pressed(KEY_W):
		move_vec.z -= 1
	if Input.is_key_pressed(KEY_S):
		move_vec.z += 1
	if Input.is_key_pressed(KEY_D):
		self.rotate_y(deg2rad(-rotate_speed))
	if Input.is_key_pressed(KEY_A):
		self.rotate_y(deg2rad(rotate_speed))
 
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
	move_vec *= move_speed
	move_and_slide(move_vec, Vector3(0, 1, 0))
 



