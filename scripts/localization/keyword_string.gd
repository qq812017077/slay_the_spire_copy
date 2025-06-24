class_name KeywordString
extends Object

var ARTIFACT: Keyword
var BLOCK: Keyword
var BURN: Keyword
var CALM: Keyword
var CHANNEL: Keyword
var CONFUSED: Keyword
var CURSE: Keyword
var DARK: Keyword
var DAZED: Keyword
var DEXTERITY: Keyword
var DIVINITY: Keyword
var ETHEREAL: Keyword
var EVOKE: Keyword
var EXHAUST: Keyword
var FOCUS: Keyword
var FRAIL: Keyword
var FROST: Keyword
var INNATE: Keyword
var INTANGIBLE: Keyword
var LIGHTNING: Keyword
var LOCK_ON: Keyword
var LOCKED: Keyword
var OPENER: Keyword
var PLASMA: Keyword
var POISON: Keyword
var PRAYER: Keyword
var REGEN: Keyword
var RETAIN: Keyword
var SCRY: Keyword
var SHIV: Keyword
var STANCE: Keyword
var STATUS: Keyword
var STRENGTH: Keyword
var STRIKE: Keyword
var THORNS: Keyword
var TODO: Keyword
var TRANSFORM: Keyword
var UNKNOWN: Keyword
var UNPLAYABLE: Keyword
var UPGRADE: Keyword
var VIGOR: Keyword
var VOID: Keyword
var VULNERABLE: Keyword
var WEAK: Keyword
var WOUND: Keyword
var WRATH: Keyword
var RITUAL: Keyword
var FATAL: Keyword
var TEXT: Array


static func parse(keywords: Dictionary) -> KeywordString:
	var keywordString = KeywordString.new()
	
	var keys: Array = keywords.keys()
	for key in keys:
		if key == "TEXT":
			keywordString.TEXT = keywords[key]
		elif key in keywordString:
			# set the property of keywordString with the value from keywords
			keywordString.set(key, Keyword.parse(keywords[key]))
		else:
			push_warning("Key '%s' not found in KeywordString." % key)
		
	return keywordString
	
