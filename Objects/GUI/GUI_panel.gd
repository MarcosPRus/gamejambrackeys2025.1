extends PanelContainer

var broken: bool = false
var mouse_inside: bool = false

@export var speed : float = 1.5
@export var damping : float = 0.999
@export var max_angle : float = PI/2

var angular_vel : float = 0.0
var offset_angle : float = PI/4


func _ready() -> void:
	rotation = 0.0
	offset_angle = (size/2).angle()
	
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)

func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouse_inside:
		fix()
	
	if broken:
		rotate(delta)

func rotate(delta: float) -> void:
	var accel = cos(rotation+offset_angle) * speed
	angular_vel += accel*delta
	angular_vel *= damping
	
	rotation += angular_vel*delta

func fix() -> void:
	broken = false
	rotation = 0.0


func _on_mouse_entered() -> void:
	mouse_inside = true

func _on_mouse_exited() -> void:
	mouse_inside = false
