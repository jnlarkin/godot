extends KinematicBody2D

const FRICTION = 400
const ACCELERATION = 300
const MAX_SPEED = 70

var velocity = Vector2.ZERO
var direction = 0
var attacking = 0
var interpolation = 1
var t = 0.0

onready var animationPlayer = $AnimationPlayer
onready var sprite = $"Medieval-Sheet"
onready var sword = $"TestKatana"

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	var input_left_click = Input.is_action_just_pressed("ui_left_click")
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector * MAX_SPEED	
		if input_vector.x == 1 and input_vector.y == -1:
			if direction == 1:
				animationPlayer.play("RunRight")
			else:
				animationPlayer.play("RunLeft")
				direction = 2
		elif input_vector.x == 1 and input_vector.y == 1:
			if direction == 1:
				animationPlayer.play("RunRight")
			else:
				animationPlayer.play("RunLeft")
				direction = 2
		elif input_vector.x == -1 and input_vector.y == -1:
			if direction == 1:
				animationPlayer.play("RunRight")
			else:
				animationPlayer.play("RunLeft")
				direction = 2
		elif input_vector.x == -1 and input_vector.y == 1:
			if direction == 1:
				animationPlayer.play("RunRight")
			else:
				animationPlayer.play("RunLeft")
				direction = 2
		elif input_vector.x == 1 and input_vector.y == 0:
			animationPlayer.play("RunRight")
			direction = 1
		elif input_vector.x == -1 and input_vector.y == 0:
			animationPlayer.play("RunLeft")
			direction = 2
		elif input_vector.x == 0 and input_vector.y == 1:
			if direction == 1:
				animationPlayer.play("RunRight")
			else:
				animationPlayer.play("RunLeft")
				direction = 2
		elif input_vector.x == 0 and input_vector.y == -1:
			if direction == 1:
				animationPlayer.play("RunRight")
			else:
				animationPlayer.play("RunLeft")
				direction = 2
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		if direction == 1:
			animationPlayer.play("IdleRight")
		else:
			animationPlayer.play("IdleLeft")
	
	if input_left_click == true:
		attacking = 1
		
	if attacking == 1:
		
		var rotation = sword.rotation_degrees
		var drotation = 90
		var rotationspeed = 4
		
		if interpolation <= drotation and attacking == 1:
			interpolation += lerp(1,(drotation+1),delta*rotationspeed)
			sword.rotation_degrees = interpolation
			if interpolation >= drotation:
				attacking = 0
		
		if interpolation >= drotation and interpolation > 1:
			interpolation -= lerp(drotation,1,delta*0.0001)
			sword.rotation_degrees = interpolation
		
		
		
	print(interpolation)
	
		# while rotation < 30:
			# t += delta * 0.4
			# sword.rotation_degrees = t
		
		# for f in range(80):
			# t -= delta * 0.4
			
			# sword.rotation_degrees = 1*(1-t) + 30 * t
			# print(rotation)
	
	velocity = move_and_slide(velocity)
