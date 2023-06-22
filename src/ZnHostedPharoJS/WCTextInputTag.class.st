Class {
	#name : #WCTextInputTag,
	#superclass : #WCFormInputTag,
	#category : #ZnHostedPharoJS
}

{ #category : #accessing }
WCTextInputTag >> type [
	^ 'text'
]

{ #category : #accessing }
WCTextInputTag >> with: anObject [ 
	anObject isNil ifFalse: [ self value: anObject greaseString ].
	super with: nil
]
