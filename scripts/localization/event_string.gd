class_name EventString
extends Object

var NAME: String
var DESCRIPTIONS: Array
var OPTIONS: Array 


static func parse(keywords: Dictionary) -> EventString:
	var event_string = EventString.new()

	var keys: Array = keywords.keys()
	for key in keys:
		if key in event_string:
			# set the property of keywordString with the value from keywords
			event_string.set(key, keywords[key])
		else:
			push_warning("Key '%s' not found in KeywordString." % key)

	return event_string
