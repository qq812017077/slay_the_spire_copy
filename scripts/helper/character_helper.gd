class_name CharacterHelper
extends Object

static var letter_regex: RegEx = RegEx.new()
static var letter_or_digit_regex: RegEx = RegEx.new()

static func _static_init() -> void:
	letter_regex.compile("^\\p{L}$")
	letter_or_digit_regex.compile("^[\\p{L}\\p{N}]$")

static func is_letter(character: String) -> bool:
	return letter_regex.search(character) != null
	# Check if the character is a letter (a-z, A-Z)
#	return (character >= "a".unicode_at(0) and character <= "z".unicode_at(0)) or \
#			(character >= "A".unicode_at(0) and character <= "Z".unicode_at(0))
static func is_letter_or_digit(character: String) -> bool:
	
	return letter_or_digit_regex.search(character) != null
	
