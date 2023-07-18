Trait {
	#name : #StaticComponentHolder,
	#traits : 'ComponentHolder',
	#classTraits : 'ComponentHolder classTrait',
	#category : #ZnHostedPharoJS
}

{ #category : #accessing }
StaticComponentHolder classSide >> _resetComponents [
	<script>
	<pharoJsSkip>
	^ staticComponents := Dictionary new.
]

{ #category : #accessing }
StaticComponentHolder classSide >> _staticComponents [

	<pharoJsSkip>
	^ staticComponents ifNil: [ staticComponents := Dictionary new ]
]

{ #category : #accessing }
StaticComponentHolder classSide >> addComponent: aWCCParagraph named: aString [ 
	<pharoJsSkip>
	^ self addStaticComponent: aWCCParagraph named: aString 
]

{ #category : #accessing }
StaticComponentHolder classSide >> addStaticComponent: aWCCParagraph named: aString [ 
	<pharoJsSkip>
	^ self _staticComponents at: aString put: aWCCParagraph
]

{ #category : #accessing }
StaticComponentHolder classSide >> staticComponents [

	^ staticComponents ifNil: [ 
		  staticComponents := PhxJsonReader readFromString:
			                      self staticComponentsSerialized ]
]

{ #category : #accessing }
StaticComponentHolder classSide >> staticComponentsSerialized [

	<jsLiteralGenerator>
	^ self _staticComponents asPhxJsonString
]

{ #category : #'initialize-release' }
StaticComponentHolder >> components [
	^ self staticComponents
]

{ #category : #'as yet unclassified' }
StaticComponentHolder >> staticComponents [
	^ self class staticComponents
]
