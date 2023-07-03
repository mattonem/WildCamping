Trait {
	#name : #ComponentHolder,
	#classInstVars : [
		'staticComponents'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #accessing }
ComponentHolder classSide >> _resetComponents [

	<pharoJsSkip>
	^ staticComponents := Dictionary new.
]

{ #category : #accessing }
ComponentHolder classSide >> _staticComponents [

	<pharoJsSkip>
	^ staticComponents ifNil: [ staticComponents := Dictionary new ]
]

{ #category : #accessing }
ComponentHolder classSide >> addStaticComponent: aWCCParagraph named: aString [ 
	<pharoJsSkip>
	^ self _staticComponents at: aString put: aWCCParagraph
]

{ #category : #accessing }
ComponentHolder classSide >> staticComponents [

	^ staticComponents ifNil: [ 
		  staticComponents := PhxJsonReader readFromString:
			                      self staticComponentsSerialized ]
]

{ #category : #accessing }
ComponentHolder classSide >> staticComponentsSerialized [

	<jsLiteralGenerator>
	^ self _staticComponents asPhxJsonString
]

{ #category : #'initialize-release' }
ComponentHolder >> initComponents [
	self class staticComponents do: [ :component | component start ]
]

{ #category : #'initialize-release' }
ComponentHolder >> initializeComponentHolder [
	self class staticComponents do: [ :component | component start ]
]

{ #category : #'initialize-release' }
ComponentHolder >> staticComponentNamed: aString [
	^ self class staticComponents at: aString 
]
