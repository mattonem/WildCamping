Trait {
	#name : #InstanceComponentHolder,
	#instVars : [
		'components'
	],
	#traits : 'ComponentHolder',
	#classTraits : 'ComponentHolder classTrait',
	#category : #ZnHostedPharoJS
}

{ #category : #'initialize-release' }
InstanceComponentHolder >> _components [
	<pharoJsSkip>
	^ components ifNil: [ components := Dictionary new ]
]

{ #category : #'initialize-release' }
InstanceComponentHolder >> addComponent: aWCCParagraph named: aString [ 
	<pharoJsSkip>
	^ self _components at: aString put: aWCCParagraph
]

{ #category : #'initialize-release' }
InstanceComponentHolder >> components [
	^ components ifNil: [ components := PhxJsonReader readFromString:
			                      self componentsSerialized ]
]

{ #category : #'initialize-release' }
InstanceComponentHolder >> componentsSerialized [

	<jsLiteralGenerator>
	^ self _components asPhxJsonString
]
