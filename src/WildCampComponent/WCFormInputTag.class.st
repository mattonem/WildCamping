Class {
	#name : 'WCFormInputTag',
	#superclass : 'WCTagBrush',
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'testing' }
WCFormInputTag >> isClosed [
	^ true
]

{ #category : 'testing' }
WCFormInputTag >> tag [
	^ 'input'
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
