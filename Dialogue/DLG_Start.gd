extends Step
class_name DLG_Start

@export var focusDestination: Step

#List of actors that will be performing in this scene
@export var requiredActors: Array[String]
@export var camStartPosition: Vector2

#Set to null while testing in isolated scene. Change when implemeting
#func _init(dm: DialogueManager = null):
	#super(dm)

func _ready():
	##Assert that:
	# all actors exist
		#Scan current room's castList, match which actors there are needed for the interaction
		#if not all actors exist, instantiate the ones needed
	# all actors are in correct positions
		#if not, have them walk to correct positions
	#Camera is in correct position
		#if not, have it move to correct position
	
	##Don't need to worry about:
	# Flags. Timeline is selected based off what flags are/aren't set in FlagManager
	
	##Implementation:
	#Iterate through requiredActors list (array of actor names)
		#For actorName in actorNames
			#For actor in world.currentRoom.castList
				#if actor.name == actorName:
					#dialogueManager.performingCast += {actorName, actor}
				#else	(If cannot find actor)
					#var ow_npc = load(owNPCPath)		##Instantiate actor scene
					#var inst = ow_npc.instantiate()
					#var npcinfo = NPC_Database.getInfo(actorName)	##Get npc info for actor
					#inst.setActorInfo(npcinfo)						##Set data for npc
					#world.currentScene.castList.add_child(inst)	
					#inst.position = somewhere offscreen
				
				#if actor.position != destination:
					#actor.walkTo(destination)
	#Do not move forward until all actors exist and are in their correct spots
	#Move cam to camStartPosition as well
	
	pass

func runStep():
	if(focusDestination == null):
		focusDestination = get_child(0)
	
	dialogueManager.jumpTo(focusDestination)
