Class {
	#name : #WCCheckboxInputTag,
	#superclass : #WCFormInputTag,
	#category : #WildCampComponent
}

{ #category : #accessing }
WCCheckboxInputTag >> checked [
		self attributes at: 'checked' put: true
]

{ #category : #accessing }
WCCheckboxInputTag >> type [
	^ 'checkbox'
]
