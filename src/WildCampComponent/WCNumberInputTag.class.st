Class {
	#name : 'WCNumberInputTag',
	#superclass : 'WCTextInputTag',
	#category : 'WildCampComponent'
}

{ #category : 'initialization' }
WCNumberInputTag >> initialize [
	super initialize.
	self type: 'number'.
]
