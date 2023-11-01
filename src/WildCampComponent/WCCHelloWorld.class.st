Class {
	#name : #WCCHelloWorld,
	#superclass : #WCComponent,
	#traits : 'InstanceComponentHolder',
	#classTraits : 'InstanceComponentHolder classTrait',
	#category : #WildCampComponent
}

{ #category : #rendering }
WCCHelloWorld >> renderHtmlOn: html [

	html textInput
		id: 'nameInput';
		value: 'World'.
	html button
		id: 'submitButton';
		with: 'Say hello!'.
	self
		addComponent: (WCCParagraph new
				 content: 'Hi guys';
				 on: html)
		named: #greetingMessage
]

{ #category : #rendering }
WCCHelloWorld >> start [

	| nameInput sayHelloButton greetingMessage |
	self initializeComponentHolder.
	nameInput := self getElementById: #nameInput.
	sayHelloButton := self getElementById: #submitButton.
	greetingMessage := self componentNamed: #greetingMessage.

	sayHelloButton
		addEventListener: #click
		block: [ :event |
		greetingMessage content: 'Hello ' , nameInput value ].
]
