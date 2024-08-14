@tool
extends Step
class_name DLG_Start

#List of actors that will be performing in this scene
@export var requiredActors: Array[String]#: set = setRequiredActors
@export var focusDestination: Step
@export var camStartPosition: Vector2
var timeline: Array

func _enter_tree():
	if(requiredActors.size() > 0):
		timeline = Helper.getAllChildren(self)
		self.availableActors = requiredActors
		for step in timeline:
			if(step is Step):
				step.availableActors = requiredActors
	else:
		printerr("Set required actors")

#func setRequiredActors(ra: Array[String]):
	#requiredActors = ra

func runStep():
	for actorName in requiredActors:
		for actor in DialogueSystem.world.currentRoom.castList.get_children():
			if actor.name == actorName:
				dialogueManager.performingCast[actorName] = actor	#Add actor to dictionary
				break
			else:	#(If cannot find actor)
				var npc = NPC_Database.createNPC(actorName, DialogueSystem.world.currentRoom.castList)
				npc.position = Vector2(800,300)
				dialogueManager.performingCast[actorName] = npc		#Add actor to dictionary
				break
	
	if(focusDestination == null):
		focusDestination = get_child(0)
	
	dialogueManager.jumpTo(focusDestination)
