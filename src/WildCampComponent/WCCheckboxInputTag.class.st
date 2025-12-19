Class {
	#name : 'WCCheckboxInputTag',
	#superclass : 'WCFormInputTag',
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'accessing' }
WCCheckboxInputTag >> checked [
		self attributes at: 'checked' put: true
]

{ #category : 'accessing' }
WCCheckboxInputTag >> checked: aBoolean [
	self attributes 
		at: 'checked'
		put: aBoolean
]

{ #category : 'accessing' }
WCCheckboxInputTag >> type [
	^ 'checkbox'
]
