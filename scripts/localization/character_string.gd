class_name CharacterString
extends Object

var NAMES : Array
var TEXT : Array
var OPTIONS : Array
var UNIQUE_REWARDS : Array

static func parse(keywords: Dictionary) -> CharacterString:
	var char_string = CharacterString.new()

	var keys: Array = keywords.keys()
	for key in keys:
		if key in char_string:
			# set the property of keywordString with the value from keywords
			char_string.set(key, keywords[key])
		else:
			push_warning("Key '%s' not found in CharacterString." % key)

	return char_string