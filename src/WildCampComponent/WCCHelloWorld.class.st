Class {
	#name : #WCCHelloWorld,
	#superclass : #WCComponent,
	#traits : 'InstanceComponentHolder',
	#classTraits : 'InstanceComponentHolder classTrait',
	#category : #'WildCampComponent-Examples'
}

{ #category : #rendering }
WCCHelloWorld >> renderHtmlOn: html [

	html textInput
		id: 'nameInput';
		value: 'World'.
	self
		addComponent: (WCCButton new
				 label: 'Say hello!';
				 on: html)
		named: #greetButton.
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
	super start.
	nameInput := self getElementById: #nameInput.
	sayHelloButton := self componentNamed: #greetButton.
	greetingMessage := self componentNamed: #greetingMessage.

	sayHelloButton
		onClick: [ :event |
		greetingMessage content: 'Hello ' , nameInput value ]
]
