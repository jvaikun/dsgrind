extends Resource

const INTEL_LIST = [
	{"type":"bonus_time", "title":"Time Bonus"},
	{"type":"bonus_destroy", "title":"Destruction Bonus"},
	{"type":"bonus_nodeath", "title":"No Death Bonus"},
	{"type":"add_destroy_general", "title":"Objective: Destroy"},
	{"type":"add_destroy_unit", "title":"Objective: Destroy Units"},
	{"type":"add_destroy_structure", "title":"Objective: Destroy Structures"},
	{"type":"add_collect", "title":"Objective: Collect"},
	{"type":"add_scan", "title":"Objective: Scan"},
]


func generate_intel():
	var new_intel = Intel.new()
	var intel_data = INTEL_LIST.pick_random()
	new_intel.title = intel_data.title
	new_intel.type = intel_data.type
	return new_intel
