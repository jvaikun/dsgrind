extends Resource

const NAMES = {
	"first":[
		"Abandoned","Absolute","Abyssal","Alien","Ancient","Angry","Awful","Bad","Barbarous",
		"Bare","Bared","Bedazzled","Beginner's","Bestial","Big","Bitter","Black","Bleak",
		"Bloodstained","Bloody","Blue","Blunt","Bold","Brave","Bright","Brisk","Broken",
		"Bronze","Brutal","Buried","Burning","Calm","Carnal","Carnivorous","Cimmerian","Clean",
		"Clouded","Cold","Colossal","Compact","Corroded","Corrosive","Corrupt","Covered","Covetous",
		"Coward's","Crazy","Creeping","Crimson","Cruel","Crumbling","Crumbly","Crying","Dark",
		"Darkest","Dastardly","Dead","Deadly","Dead Man's","Decayed","Deep","Defect","Desperate",
		"Devil's","Dim","Dirty","Distant","Divine","Dreadful","Dry","Duplicitous",
		"Dusty","Emerald","Empty","Endless","Eternal","Everlasting","Evil","Exposed",
		"Fast","Fathomless","Fearful","Fearless","Feral","Fierce","Final","First","Foggy",
		"Fool's","Forbidden","Forgotten","Forsaken","Foul","Fractured","Fragile","Freak","Frightened",
		"Frozen","Full","Furious","Gangrenous","Gargantuan","Giant","Glowing","Great","Green",
		"Gunner's","Gutless","Hard","Heavy","Hermit's","Hidden","Hideous","High","Hunter's",
		"Illuminated","Imperfect","Impure","Infernal","Infested","Infinity","Insane","Irrational","Jagged",
		"Jealous","Last","Loaded","Loser's","Loud","Low","Lucky",
		"Mad","Mad Man's","Mammoth","Massive","Meek","Mighty","Mild","Morning","Murderous",
		"Murky","Mythic","Naked","Natural","Noble","Old","Open","Outrageous","Pale",
		"Peeled","Petrified","Pure","Purified","Raging","Rancid","Ranger's","Rapid","Raw",
		"Red","Rejected","Rippled","Rocky","Rotten","Rough","Ruptured","Sacred","Sad",
		"Scarred","Scout's","Second","Secret","Secure","Shallow","Sharp","Shattered","Shining",
		"Silent","Snowy","Solid","Solitary","Spiked","Spineless","Stale","Stinking","Stony",
		"Strange","Sudden","Sunken","Tainted","Titanic","Total","True","Uncovered","Unhealthy",
		"Unknown","Unrobed","Unveiled","Useless","Warrior's","Weak","Weeping","White",
		"Wicked","Wide","Wild","Worthy","Xeno","Yellow"
	],
	"last":[
		"Abyss","Agony","Anvil","Arm","Armpit","Avalanche","Axe","Badland","Barrens",
		"Base","Basin","Bed","Bedrock","Belly","Benefit","Betrayal","Blackness","Blackout",
		"Blade","Blank","Bluff","Bones","Boneyard","Border","Bottom","Breach","Break",
		"Breeze","Burrow","Cap","Carcass","Carve","Catacomb","Catch","Caves","Cavity",
		"Ceiling","Cell","Cellar","Cemetery","Chamber","Chance","Chasm","Citadel","Claw",
		"Clearance","Clearing","Comeback","Contact","Core","Cover","Covert","Crater","Crib",
		"Crosscut","Crown","Crypt","Darkness","Dawn","Death","Decay","Delight","Den",
		"Depths","Derail","Descent","Desert","Digs","Ditch","Dome","Doom","Downfall",
		"Dream","Drift","Drop","Dump","Dusk","Earth","Echo","Eclipse","Edge",
		"Elevation","Enclosure","End","Expanse","Face","Fangs","Fear","Feast","Fence",
		"Field","Find","Fissure","Foot","Force","Fort","Fury","Gap","Gate",
		"Ghost","Gods","Goods","Gorge","Grave","Grin","Grotto","Ground","Guts",
		"Habitat","Hammer","Hand","Hate","Haunt","Head","Heart","Helix","Hell",
		"Hideout","Hold","Hole","Hollow","Honor","Hook","Hope","Hulrum","Hunt",
		"Ideal","Impact","Inferno","Inland","Interest","Jewel","Joy","Keep","Key",
		"Killing","Lair","Land","Ledge","Legacy","Let-down","Level","Leverage","Lodge",
		"Look","Luck","Madness","Memorial","Mork","Mouth","Needle","Nest","Night",
		"Nightfall","Nightmare","Oddness","Outback","Outpost","Overhang","Overlook","Palace","Pass",
		"Passage","Path3D","Patrol","Pearl","Perfection","Pit","Pitfall","Plateau","Pocket",
		"Point","Position","Prize","Pursuit","Rage","Raid","Ravine","Relief","Reserve",
		"Retreat","Return","Rising","Risk","Rock","Roof","Run","Sadness","Salute",
		"Sanctuary","Scream","Senit","Shaft","Shelf","Shelter","Shock","Shroud","Skull",
		"Sleep","Slope","Soil","Sorrow","Split","Strike","Summit","Territory","Thickening",
		"Thunder","Tomb","Tongue","Track","Trail","Trench","Trick","Unfortune","Valley",
		"Vault","View","Void","Walk","Wasteland","Wealth","Well","Wilderness","Womb",
		"Wrath","Wreck"
	],
}
const OBJECTIVES = {
	"types": [
		
	],
	"targets": [
		
	],
}


func generate_mission():
	var new_mission = Mission.new()
	new_mission.codename = "%s %s" % [
		NAMES.first[randi() % NAMES.first.size()],
		NAMES.last[randi() % NAMES.last.size()]
	]
#	new_mission.rating = 0
#	new_mission.revive_cost = 1000
#	new_mission.revive_count = 3
#	new_mission.map_type = 0
#	new_mission.factions = []
#	new_mission.objectives = {}
	return new_mission
