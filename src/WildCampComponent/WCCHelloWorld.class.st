Class {
	#name : 'WCCHelloWorld',
	#superclass : 'WCComponent',
	#traits : 'InstanceComponentHolder',
	#classTraits : 'InstanceComponentHolder classTrait',
	#category : 'WildCampComponent-Examples',
	#package : 'WildCampComponent',
	#tag : 'Examples'
}

{ #category : 'rendering' }
WCCHelloWorld >> renderHtmlOn: html [

	html textInput
		id: 'nameInput';
		value: 'World'.
	self
		addComponent: (WCCButton new
				 label: 'Say hello!';
				 yourself)
		named: #greetButton
		on:html .
	self
		addComponent: (WCCParagraph new
				 content: 'Hi guys';
				yourself)
		named: #greetingMessage
		on: html
]

{ #category : 'rendering' }
WCCHelloWorld >> start [

	| nameInput sayHelloButton greetingMessage |
	self initializeComponentHolder.
	super start.
	nameInput := self getElementById: #nameInput.
	sayHelloButton := self componentNamed: #greetButton.
	greetingMessage := self componentNamed: #greetingMessage.
	sayHelloButton onClick: [ :event |
		greetingMessage content: 'Hello ' , nameInput value ]
]
