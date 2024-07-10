Class {
	#name : 'WCTextInputTag',
	#superclass : 'WCFormInputTag',
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'accessing' }
WCTextInputTag >> maxLength: aNumber [ 
	"This attribute specifies the maximum number of characters the user may enter. This number may exceed the specified #size:, in which case the user agent should offer a scrolling mechanism. The default value for this attribute is an unlimited number."
	self attributes 
		at: 'maxlength'
		put: aNumber
]

{ #category : 'api' }
WCTextInputTag >> placeholder: aString [
	"The placeholder  attribute represents a short hint (a word or short phrase) intended to aid the user with data entry. A hint could be a sample value or a brief description of the expected format. The attribute, if specified, must have a value that contains no U+000A LINE FEED (LF) or U+000D CARRIAGE RETURN (CR) characters."
	self attributeAt: 'placeholder' put: aString
]

{ #category : 'accessing' }
WCTextInputTag >> type [
	^ 'text'
]

{ #category : 'accessing' }
WCTextInputTag >> with: anObject [ 
	anObject isNil ifFalse: [ self value: anObject greaseString ].
	super with: nil
]
