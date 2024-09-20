Class {
	#name : 'WCFormInputTag',
	#superclass : 'WCTagBrush',
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'attributes' }
WCFormInputTag >> disabled [
	self disabled: true
]

{ #category : 'attributes' }
WCFormInputTag >> disabled: aBoolean [
	"The disabled attribute is a boolean attribute that, if present, indicates that the command is not available in the current state."

	self attributeAt: 'disabled' put: aBoolean
]

{ #category : 'testing' }
WCFormInputTag >> isClosed [
	^ true
]

{ #category : 'testing' }
WCFormInputTag >> tag [
	^ 'input'
]

{ #category : 'accessing' }
WCFormInputTag >> type [
	^ nil
]

{ #category : 'accessing' }
WCFormInputTag >> value: anObject [
	anObject isNil
		ifFalse: [ self attributes at: 'value' put: anObject ]
]

{ #category : 'testing' }
WCFormInputTag >> with: aBlock [
	self type isNil ifFalse: [
		self attributes at: 'type' ifAbsentPut: [ self type ] ].
	super with: aBlock
]
