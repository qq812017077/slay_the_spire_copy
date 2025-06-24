class_name DescriptionLine
extends Object

static var offsetter: float = 10.0 * Settings.scale
var text: String
var size: Vector2
var cached_tokenized_text: Array[String] = []
var cached_tokenized_text_cn: Array[String] = []

var width: float:
	get = get_width
var height: float:
	get = get_height

func _init(_text: String, _size: Vector2) -> void:
	text = _text
	size = _size

func get_width() -> float:
	return size.x

func get_height() -> float:
	return size.y

func get_cached_tokenized_text() -> Array[String]:
	if cached_tokenized_text.size() == 0:
		cached_tokenized_text = tokenize(text)
	return cached_tokenized_text
	
func get_cached_tokenized_text_cn() -> Array[String]:
	if cached_tokenized_text_cn.size() == 0:
		cached_tokenized_text_cn = tokenize_cn(text)
	return cached_tokenized_text_cn
	
func tokenize(_text: String) -> Array[String]:
	var regex: RegEx = RegEx.new()
	regex.compile("\\s+")  # Split by whitespace, commas, or semicolons
	
	var results: Array[RegExMatch] = regex.search_all(_text)
	
	var tokens: Array[String] = []
	for result in results:
		tokens.append(result.get_string())
	return tokens

func tokenize_cn(_text: String) -> Array[String]:
	var r = RegEx.new()
	r.compile("\\S+") # negated whitespace character class
	var results: Array[RegExMatch] = r.search_all(_text)  # Split by '!' character
	var tokens: Array[String] = []
	for result in results:
		tokens.append(result.get_string().replace("!", ""))
	return tokens
	
func get_text() -> String:
	return text
