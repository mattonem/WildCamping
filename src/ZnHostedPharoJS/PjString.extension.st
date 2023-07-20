Extension { #name : #PjString }

{ #category : #'*ZnHostedPharoJS' }
PjString >> encodeOn: aDocument [
	aDocument xmlEncoder nextPutAll: self
]

{ #category : #'*ZnHostedPharoJS' }
PjString >> greaseInteger [

	"Convert the receiver to an integer, answer nil if this is not a number."

	| number negated |
	number := nil.
	negated := false.
	1 to: self size do: [ :i | 
		| char |
		char := self at: i.
		(i = 1 and: [ char = $- ])
			ifTrue: [ negated := true ]
			ifFalse: [ 
				(char >= $0 and: [ char <= $9 ])
					ifTrue: [ 
						number := (number isNil
							           ifTrue: [ 0 ]
							           ifFalse: [ 10 * number ])
						          + (char greaseInteger - $0 greaseInteger) ]
					ifFalse: [ 
						^ number isNil ifFalse: [ 
							  negated not
								  ifFalse: [ number negated ]
								  ifTrue: [ number ] ] ] ] ].
	^ number isNil ifFalse: [ 
		  negated not
			  ifFalse: [ number negated ]
			  ifTrue: [ number ] ]
]

{ #category : #'*ZnHostedPharoJS' }
PjString >> renderOn: aRenderer [
	"This method is called on all objects passed as an argument to the #render: method of a WARenderer subclass. Override this method to customize how objects render themselves. The default is the return value of #displayString.
	Subclasses of WAPainter (including Components) should override #renderContentOn: and #rendererClass instead."

	aRenderer text: self
]
