class_name MonsterString
extends Object

var NAME : String
var DIALOG : Array
var MOVES : Array

static func parse(keywords: Dictionary) -> MonsterString:
	var monster_string = MonsterString.new()

	var keys: Array = keywords.keys()
	for key in keys:
		if key in monster_string:
			# set the property of keywordString with the value from keywords
			monster_string.set(key, keywords[key])
		else:
			push_warning("Key '%s' not found in MonsterString." % key)

	return monster_string