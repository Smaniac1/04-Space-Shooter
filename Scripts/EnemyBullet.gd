extends RigidBody2D

export var speed = 500
export var damage = 10
onready var Explosion = load("res://Scenes/Explosion.tscn")
onready var Player = get_node("/root/Game/Player")
onready var Enemy = get_node("/root/Game/Enemies")
func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)

func _physics_process(delta):
	var colliding = get_colliding_bodies()
	for c in colliding:
		var explosion = Explosion.instance()
		explosion.position = position
		explosion.get_node("Sprite").playing = true
		get_node("/root/Game/Explosions").add_child(explosion)
		if c.name == "Player":
			Player.change_health(-damage)
		queue_free()

	if position.y > get_viewport_rect().size.y + 10:
		queue_free()

func _integrate_forces(state):
	if Enemy.rotation == 0 :
		state.set_linear_velocity(Vector2(0,speed))
		state.set_angular_velocity(0)
	elif Enemy.rotation == 90 or Enemy.rotation == -270:
		state.set_linear_velocity(Vector2(-speed,0))
		state.set_angular_velocity(0)
	elif Enemy.rotation == 180 or Enemy.rotation == -180:
		state.set_linear_velocity(Vector2(0,-speed))
		state.set_angular_velocity(0)
	elif Enemy.rotation == 270 or Enemy.rotation == -90:
		state.set_linear_velocity(Vector2(speed,0))
		state.set_angular_velocity(0)
