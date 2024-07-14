extends Event
class_name Action

var sender : Entity
var target : Entity
var targetOptions : Array

func _init(eManager, send, targ, targOpts):
	super(eManager)
	sender = send
	target = targ
	targetOptions = targOpts
