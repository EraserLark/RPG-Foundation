extends PathFollow2D
class_name PathRunner

const selfScene: PackedScene = preload("res://PathRunner.tscn")

var speed: float
var path: Path2D
@onready var remoteTransform:= $RemoteTransform2D
var rtFocus: Node2D

signal pathComplete(path)

static func newPathRunner(_speed, _rtFocus, _parent) -> PathRunner:
	var newPR: PathRunner = selfScene.instantiate()
	newPR.speed = _speed
	newPR.rtFocus = _rtFocus
	_parent.add_child(newPR)
	return newPR

func _ready():
	path = get_parent()
	var nodePth = remoteTransform.get_path_to(rtFocus)
	remoteTransform.remote_path = nodePth

func _physics_process(delta):
	self.progress += speed * delta
	if(progress_ratio >= 1):
		emit_signal("pathComplete", self)
		self.queue_free()
