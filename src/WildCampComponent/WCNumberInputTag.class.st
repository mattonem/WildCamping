Class {
	#name : 'WCNumberInputTag',
	#superclass : 'WCTextInputTag',
	#category : 'WildCampComponent'
}

{ #category : 'attributes' }
WCNumberInputTag >> value: aValue [
	self attributeAt: 'value' put: aValue asString
]

WCNumberInputTag >> min: aValue [
	self attributeAt: 'min' put: aValue asString
]

WCNumberInputTag >> max: aValue [
	self attributeAt: 'max' put: aValue asString
]

WCNumberInputTag >> step: aValue [
	self attributeAt: 'step' put: aValue asString
]

WCNumberInputTag >> type [
	^ 'number'
]
