Class {
	#name : 'WCEditableTextInput',
	#superclass : 'WCComponent',
	#category : 'WildCampComponent-Examples',
	#package : 'WildCampComponent',
	#tag : 'Examples'
}

{ #category : 'rendering' }
WCEditableTextInput >> editFinished [

	(self getElementById: 'input') dispatchEvent:
		(Event new: 'EditFinished').
	^ (self getElementById: 'input') disabled: true
]

{ #category : 'rendering' }
WCEditableTextInput >> editStarted [

	^ (self getElementById: 'input') disabled: false
]

{ #category : 'rendering' }
WCEditableTextInput >> renderHtmlOn: html [

	html div
		class: 'input-group mb-3';
		with: [ :content |
			content textInput
			 id:'input';
				class: 'form-control';
				value: 'Some Value';
				disabled.
			content span
				id: 'editButton';
				class: 'btn btn-secondary';
				with: [ :span | span idiomatic class: 'bi bi-pencil' ] ]
]

{ #category : 'rendering' }
WCEditableTextInput >> start [

	super start.
	self getElementById: 'editButton' whenReadyDo: [ :button |
		button addEventListener: #click block: [
			(self getElementById: 'input') disabled
				ifTrue: [ self editStarted ]
				ifFalse: [ self editFinished ] ] ].
	self getElementById: 'input' whenReadyDo: [ :field |
		field
			addEventListener: #keypress
			block: [ :event |
			event key = 'Enter' ifTrue: [ self editFinished ] ] ]
]
