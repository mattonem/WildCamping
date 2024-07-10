Class {
	#name : 'WCHtmlAttributes',
	#superclass : 'Dictionary',
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'pharojs support' }
WCHtmlAttributes class >> jsTranspilationImportMethodsNonstandard [

	<pharoJsSkip>
	^ {" (Object -> #( isConcatenatedHtmlAttributeValue ))" }
]

{ #category : 'adding' }
WCHtmlAttributes >> addClass: aString [
	"Add an additional CSS class aString to the receiver."

	self at: 'class' append: aString separator: Character space
]

{ #category : 'adding' }
WCHtmlAttributes >> addStyle: aString [
	"Add an additional CSS style definition aString to the receiver."

	self at: 'style' append: aString separator: $;
]

{ #category : 'accessing' }
WCHtmlAttributes >> at: aKey append: aValue [
	"Append aValue to the attribute aKey. If already present, concatenate it with a space. Ignore the request if aValue is nil."

	self at: aKey append: aValue separator: Character space
]

{ #category : 'accessing' }
WCHtmlAttributes >> at: aKey append: aValue separator: aSeparator [ 
	"Append aValue to the attribute aKey. If already present, concatenate it with aString. Ignore the request if aValue is nil.
	https://code.google.com/p/seaside/issues/detail?id=816
	we have to be frugal with allocation"
	
	aValue isNil ifFalse: [
		| current |
		current := self at: aKey ifAbsentPut: [ aValue ].
		current ~~ aValue ifTrue: [
			"we couldn't store a value because there was already one"
			current isConcatenatedHtmlAttributeValue
				ifTrue: [ current addValue: aValue ]
				ifFalse: [ self at: aKey put: (WCConcatenatedHtmlAttributeValue separator: aSeparator value: current value: aValue) ] ] ]
]

{ #category : 'accessing' }
WCHtmlAttributes >> at: aKey put: anObject [

	anObject ifNil: [ ^ nil ].
	^ super at: aKey put: anObject
]

{ #category : 'accessing' }
WCHtmlAttributes >> encodeOn: aDocument [
	"Encode the receivers attribute onto aDocument. Note that this implementation reqires those two checks for true and false exactly the way they are here, to reliable encode boolean attributes in an XHTML compliant way."

	self keysAndValuesDo: [ :key :value |
		value == false ifFalse: [
			aDocument
				nextPut: Character space;
				nextPutAll: key.
			value == true ifFalse: [
				aDocument nextPutAll: '="';
				print: value;
				nextPut: $" ] ] ]
]

{ #category : 'accessing' }
WCHtmlAttributes >> errorKeyNotFound [
	^ nil
]

{ #category : 'accessing' }
WCHtmlAttributes >> removeKey: aKey [
	"Remove aKey from the receiver, raise an exception if the element is missing."

	^ self removeKey: aKey ifAbsent: [ self errorKeyNotFound ]
]
