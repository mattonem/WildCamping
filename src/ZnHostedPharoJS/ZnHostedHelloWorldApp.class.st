Class {
	#name : #ZnHostedHelloWorldApp,
	#superclass : #PjFileBasedWebApp,
	#traits : 'ComponentHolder',
	#classTraits : 'ComponentHolder classTrait',
	#instVars : [
		'user',
		'comp'
	],
	#classVars : [
		'AngryGreetingParagraph',
		'GreetingParagraph'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #description }
ZnHostedHelloWorldApp class >> appClasses [

	<pharoJsSkip>
	^ super appClasses , { 
		  WCCParagraph.
		  WCCOSMapWidget }
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
ZnHostedHelloWorldApp >> greetingParagraph [
	^ self staticComponentNamed: #greetingParagraph
]

{ #category : #'initialize-release' }
ZnHostedHelloWorldApp >> initialize [

	super initialize.
	self initializeComponentHolder
]

{ #category : #'initialize-release' }
ZnHostedHelloWorldApp >> start [

	| nameInput sayHelloButton |
	super start.
	user := PjUser new.
	nameInput := document getElementById: #nameTextInput.
	sayHelloButton := document getElementById: #sayHelloButton.
	nameInput
		addEventListener: #change
		block: [ user name: nameInput value ].

	sayHelloButton
		addEventListener: #click
		block: [ self greetingParagraph content: 'Hello there ' , user name ]
]
