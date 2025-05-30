Extension { #name : 'PjObject' }

{ #category : '*ZnHostedPharoJS' }
PjObject >> encodeOn: aDocument [ 
	aDocument print: self greaseString
]

{ #category : '*ZnHostedPharoJS' }
PjObject >> greaseString [
	^ self asString
]

{ #category : '*ZnHostedPharoJS' }
PjObject >> isConcatenatedHtmlAttributeValue [
	^ false
]

{ #category : '*ZnHostedPharoJS' }
PjObject >> renderOn: aRenderer [
	"This method is called on all objects passed as an argument to the #render: method of a WARenderer subclass. Override this method to customize how objects render themselves. The default is the return value of #displayString.
	Subclasses of WAPainter (including Components) should override #renderContentOn: and #rendererClass instead."

	aRenderer text: self
]
