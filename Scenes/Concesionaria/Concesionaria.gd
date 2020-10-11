extends Spatial

onready var podiums := $Podiums.get_children()
onready var podiums_amount := $Podiums.get_child_count()
var current := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	get_input()


func get_input():
	if Input.is_action_just_pressed("ui_left"):
		print("left")
		select_previous()
	if Input.is_action_just_pressed("ui_right"):
		print("right")
		select_next()
	if Input.is_action_just_pressed("ui_accept"):
		print(Singleton)
		print(Singleton.Car)
		get_tree().change_scene("res://Scenes/Driving/Driving.tscn")

func select_next():
	if current < podiums_amount - 1: 
		current += 1
	else:
		current = 0
	focus()

func select_previous():
	if current > 0:
		current -= 1
	else:
		current = podiums_amount - 1
	focus()

func focus():
	print(current)
	podiums[current].focus_camera()
