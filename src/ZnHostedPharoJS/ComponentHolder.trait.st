Trait {
	#name : #ComponentHolder,
	#category : #ZnHostedPharoJS
}

{ #category : #'initialize-release' }
ComponentHolder >> componentNamed: aString [
	^ self components at: aString 
]

{ #category : #'initialize-release' }
ComponentHolder >> components [
	^ self subclassResponsibility
]

{ #category : #'initialize-release' }
ComponentHolder >> initializeComponentHolder [
	self components do: [ :component | component start ]
]
