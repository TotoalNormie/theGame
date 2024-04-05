extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#@export var sound: AudioStreamWAV = preload("res://static.wav")

# Define movement speed
@export var speed = 3
var direction : int = 1
@export var inventory: Dictionary = {}

func _process(delta):
	# Get user input
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
		direction = 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
		direction = -1
		
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
		
	$model.scale.x = direction * abs($model.scale.x)

	# Normalize input vector to prevent faster diagonal movement
	input_vector = input_vector.normalized()

	# Move the player
	var collision = move_and_collide(input_vector * speed)
	# Check for collision and stop movement if colliding
	if collision:
		speed = 0
	else:
		speed = 3

func addToInventory(itemId, itemData):
	inventory[itemId] = itemData
	
func removeFromInventory(itemId):
	inventory.erase(itemId)

#func _on_area_2d_body_entered(body):
	#print("Area entered")
	##$AudioStreamPlayer2D.play(sound)
	#pass # Replace with function body.
