extends RigidBody2D


export(float) var engine_power = 100.0
export(float) var turn_speed = 1000.0

onready var trail = $Trail

onready var velocity_vector = $VelocityVector


func _integrate_forces(state):
	var turn_dir = Input.get_action_strength("turn_right")
	turn_dir -= Input.get_action_strength("turn_left")
	
	var thrust_dir = Input.get_action_strength("accelerate")
	thrust_dir -= Input.get_action_strength("decelerate")
	
	trail.emitting = thrust_dir != 0
	
	var thrust = Vector2(thrust_dir * engine_power, 0.0).rotated(rotation)
	
	state.add_central_force(thrust)
	state.add_torque(turn_dir * turn_speed)


func _process(_delta):
	var begin = Vector2(0.0, 0.0)
	var end = linear_velocity * 0.3
	
	velocity_vector.points = PoolVector2Array([begin, end])
	velocity_vector.rotation = -rotation
