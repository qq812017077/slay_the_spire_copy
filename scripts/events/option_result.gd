class_name OptionResult
extends Object

static var ReturnMap: OptionResult = OptionResult.new()

static func _static_init() -> void:
	ReturnMap.return_map = true
	ReturnMap.body = "Return to Map"

var return_map: bool = false
var img: Texture2D = null
var body: String
var options: Array[String] = []