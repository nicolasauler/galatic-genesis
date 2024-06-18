extends Camera3D

@export var target: NodePath

@onready var player = get_node(target)

var fixed_y: float

# Called when the node enters the scene tree for the first time.
func _ready():
	fixed_y = position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Atualiza a posiÃ§Ã£o da cÃ¢mera para seguir o player no eixo XZ
	position.x = player.position.x
	position.z = player.position.z
	position.y = fixed_y
