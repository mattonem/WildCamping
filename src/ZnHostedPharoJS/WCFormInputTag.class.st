Class {
	#name : #WCFormInputTag,
	#superclass : #WCTagBrush,
	#category : #ZnHostedPharoJS
}

{ #category : #testing }
WCFormInputTag >> isClosed [
	^ true
]

{ #category : #testing }
WCFormInputTag >> tag [
	^ 'input'
]

{ #category : #testing }
WCFormInputTag >> with: aBlock [
	self type isNil ifFalse: [
		self attributes at: 'type' ifAbsentPut: [ self type ] ].
	super with: aBlock
]
