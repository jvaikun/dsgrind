extends PanelContainer

const name_text = "%s %s"
const prog_text = "%d / %d"


func set_objective(obj):
	$Body/Name.text = name_text % [obj.type.capitalize(), obj.target]
	$Body/ProgressBar.max_value = obj.amount
	$Body/ProgressBar.value = 0
	$Body/Progress.text = prog_text % [$Body/ProgressBar.value, obj.amount]


func update_objective():
	$Body/ProgressBar.value += 1
	$Body/Progress.text = prog_text % [$Body/ProgressBar.value, $Body/ProgressBar.max_value]

