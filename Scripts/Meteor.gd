extends RigidBody2D

var velocity = Vector2(0,0)
export var min_speed = 100
export var max_speed = 600
export var damage = 50

onready var Explosion = load("res://Scenes/Explosion.tscn")


func _ready():
	randomize()
	var direction = randi()%4+1
	if direction == 1:
		position.x = randi() % int(get_viewport_rect().size.x)
		velocity.y = max(randi() % max_speed, min_speed)
	elif direction == 2:
		position.y = randi() % int(get_viewport_rect().size.y)
		velocity.x = max(randi() % max_speed, min_speed)
	elif direction == 3:
		position.x = randi() % int(get_viewport_rect().size.x)
		position.y = 775
		velocity.y = -(max(randi() % max_speed, min_speed))
	else:
		position.x = 1025
		position.y = randi() % int(get_viewport_rect().size.y)
		velocity.x = -(max(randi() % max_speed, min_speed))
	contact_monitor = true
	set_max_contacts_reported(4)
	linear_velocity = velocity

func _physics_process(delta):
	var colliding = get_colliding_bodies()
	for c in colliding:
		if c.name != "Bullet_R":
			var explosion = Explosion.instance()
			explosion.position = position
			explosion.get_node("Sprite").playing = true
			get_node("/root/Game/Explosions").add_child(explosion)
		if c.name == "Player":
			c.change_health(-damage)
		queue_free()
		
	if position.y > get_viewport_rect().size.y + 50:
		queue_free()

func _integrate_forces(state):
	#state.set_linear_velocity(velocity)
	pass
