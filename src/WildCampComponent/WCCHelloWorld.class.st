Class {
	#name : #WCCHelloWorld,
	#superclass : #WCComponent,
	#traits : 'InstanceComponentHolder',
	#classTraits : 'InstanceComponentHolder classTrait',
	#category : #WildCampComponent
}

{ #category : #rendering }
WCCHelloWorld >> renderHtmlOn: html [

	html textInput id: 'nameInput'; value: 'World'.
	html button
		id: 'submitButton';
		with: 'Say hello!'.
	WCCParagraph for: self on: html named: #greetingMessage.
]

{ #category : #rendering }
WCCHelloWorld >> start [

	| nameInput sayHelloButton greetingParagraph |
	nameInput := self getElementById: #nameInput.
	sayHelloButton := self getElementById: #submitButton.
	greetingParagraph := self getElementById: #greetingMessage.
	sayHelloButton addEventListener: #click block: [ :event | 
		(self componentNamed: #greetingMessage) content:
			'Hello ' , nameInput value ]
]
