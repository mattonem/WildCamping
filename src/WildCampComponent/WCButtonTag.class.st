Class {
	#name : 'WCButtonTag',
	#superclass : 'WCTagBrush',
	#category : 'WildCampComponent',
	#package : 'WildCampComponent'
}

{ #category : 'attributes' }
WCButtonTag >> disabled [
	"When set for a form control, this boolean attribute disables the control for user input.
When set, the disabled attribute has the following effects on an element:
	-	Disabled controls do not receive focus.
	-	Disabled controls are skipped in tabbing navigation.
	-	Disabled controls cannot be successful (= will not be submitted).
		
	The following elements support the disabled attribute: BUTTON, INPUT, OPTGROUP, OPTION, SELECT, and TEXTAREA. This one other example of functionality implemented way too high in the class hierarchy because we don't have traits."

	self disabled: true
]

{ #category : 'attributes' }
WCButtonTag >> disabled: aBoolean [
	"The disabled attribute is a boolean attribute that, if present, indicates that the command is not available in the current state."

	self attributeAt: 'disabled' put: aBoolean
]

{ #category : 'accessing' }
WCButtonTag >> tag [
	^ 'button'
]
