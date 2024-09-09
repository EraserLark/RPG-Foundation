@tool
extends Step
class_name DLG_Walk

var pathRunner:= preload("res://PathRunner.tscn")

@export var cutsceneMarkOptions: Array[String]:
	#get:
		#return cutsceneMarks
	set(value):
		cutsceneMarkOptions.clear()
		cutsceneMarkOptions = value
@export var cutscenePathOptions: Array[String]:
	#get:
		#return cutscenePaths
	set(value):
		cutscenePathOptions.clear()
		cutscenePathOptions = value

var cutsceneMark: String
var cutscenePath: String
var actor: String
var walker

enum WALK_MODE {PATH_FOLLOW, PATH_FIND}
var walkMode: WALK_MODE = WALK_MODE.PATH_FOLLOW:
	get:
		return walkMode
	set(value):
		walkMode = value
		notify_property_list_changed()
#@export var targetPosition: Vector2

func _get_property_list() -> Array:
	var properties = []
	
	properties.append({
		"name": "actor",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": Helper.arrayToString(availableActors)
	})
	
	properties.append({
		"name": "walkMode",
		"type": TYPE_INT,
		"usage": PROPERTY_USAGE_DEFAULT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": ",".join(WALK_MODE.keys())
	})
	
	if(walkMode == WALK_MODE.PATH_FIND):
		properties.append({
			"name": "cutsceneMark",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": Helper.arrayToString(cutsceneMarkOptions)
		})
	elif(walkMode == WALK_MODE.PATH_FOLLOW):
		properties.append({
			"name": "cutscenePath",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": Helper.arrayToString(cutscenePathOptions)
		})
	
	return properties

func runStep():
	walker = dialogueManager.performingCast[actor]
	if(walkMode == WALK_MODE.PATH_FIND):
		walker.walkFinished.connect(walkFinished)
		var destination = dialogueManager.cutsceneMarks[cutsceneMark].position
		walker.setNavTarget(destination)
		walker.disableCollider(true)
	elif(walkMode == WALK_MODE.PATH_FOLLOW):
		var pathToRun = dialogueManager.cutsceneMarks[cutscenePath]
		var newPathRunner = PathRunner.newPathRunner(250, walker, pathToRun)
		newPathRunner.pathComplete.connect(walkFinished)

#func endStepEarly():
	#walkFinished(null)

func walkFinished(path):
	walker.disableCollider(false)
	
	if(walkMode == WALK_MODE.PATH_FIND):
		walker.walkFinished.disconnect(walkFinished)
	elif(walkMode == WALK_MODE.PATH_FOLLOW):
		path.pathComplete.disconnect(walkFinished)
	advanceNextStep(self)
