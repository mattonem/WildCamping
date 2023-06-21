Class {
	#name : #ZnHostedHelloWorldApp,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'user'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #description }
ZnHostedHelloWorldApp class >> appClasses [
	<pharoJsSkip>
	^super appClasses, { PjUser }
]

{ #category : #description }
ZnHostedHelloWorldApp class >> bridgeClass [
	<pharoJsSkip>
	^ PjBridge
]

{ #category : #description }
ZnHostedHelloWorldApp class >> bridgeClientClass [
	<pharoJsSkip>
	
	^ PjZnHostedBrowserBridgeClient
]

{ #category : #'initialize-release' }
ZnHostedHelloWorldApp >> start [
	| nameInput sayHelloButton greetingMessageContainer |
	super start.
	user := PjUser new.
	nameInput := document getElementById: #nameTextInput.
	sayHelloButton := document getElementById: #sayHelloButton.
	nameInput addEventListener: #change block: [ user name: nameInput value ].
	greetingMessageContainer := document getElementById: #greetingMessageContainer.
	sayHelloButton addEventListener: #click block: [ greetingMessageContainer innerHTML: 'Hello ' , user name ]
]
