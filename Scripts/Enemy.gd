extends KinematicBody2D

export var limit_y = 350
export var score = 10
export var speed = 2.0
export var move_probability = 0.05
export var fire_probability = 0.5
var choice = randi()%4

onready var EnemyBullet = load("res://Scenes/EnemyBullet.tscn")

onready var rot_seg = get_node("/root/Game").rotate_segments


var ready = false

var new_position = Vector2(0,0)

func get_new_position():
	var VP = get_viewport_rect().size
	new_position.x = randi() % int(VP.x)
	new_position.y = min(randi() % int(VP.y), int(VP.y) - limit_y)
	$Tween.interpolate_property(self, "position", position, new_position, speed, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	rotation_degrees = choice * (360 / rot_seg)
	
	ready = true

func die():
	queue_free()

func _ready():
	randomize()
	get_new_position()


func _physics_process(delta):
	if ready:
		$Tween.start()
		ready = false
	


func _on_Timer_timeout():
	if randf() < move_probability:
		get_new_position()
	if randf() < fire_probability:
		var b = EnemyBullet.instance()
		b.position = position
		var vel_rot = deg2rad((choice * (360 / rot_seg)) - 90)
		b.position.x += cos(vel_rot) * 25
		b.position.y += sin(vel_rot) * 25
		b.rot = choice
		get_node("/root/Game/Enemy Bullets").add_child(b)
		
