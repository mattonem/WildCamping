Class {
	#name : #ZnHostedHelloWorldApp,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'user',
		'comp'
	],
	#classVars : [
		'AngryGreetingParagraph',
		'GreetingParagraph'
	],
	#pools : [
		'LeafletjsGlobals'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #description }
ZnHostedHelloWorldApp class >> appClasses [
	<pharoJsSkip>
	^super appClasses, { WCCParagraph }
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
ZnHostedHelloWorldApp >> angryGreetingParagraph [
	^ self class angryGreetingParagraph
]

{ #category : #'initialize-release' }
ZnHostedHelloWorldApp >> greetingParagraph [
	^ self class greetingParagraph
]

{ #category : #'initialize-release' }
ZnHostedHelloWorldApp >> start [

	| nameInput sayHelloButton greetingMessageContainer maps |
	super start.
	user := PjUser new.
	nameInput := document getElementById: #nameTextInput.
	sayHelloButton := document getElementById: #sayHelloButton.
	nameInput
		addEventListener: #change
		block: [ user name: nameInput value ].
	greetingMessageContainer := document getElementById:
		                            #greetingMessageContainer.
	sayHelloButton
		addEventListener: #click
		block: [ self greetingParagraph content: 'Hello there ', user name.
			self angryGreetingParagraph content: 'Seriously, ', user name. ].

	maps := self startMap
]

{ #category : #'initialize-release' }
ZnHostedHelloWorldApp >> startMap [

	| map |
	map := (L map: 'map') setView: { 51.505. -0.09 } with: 13.
	(L
		 tileLayer: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'
		 with: { 
				 (#maxZoom -> 19).
				 (#attribution
				  ->
				  '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') }
				 asJsObject) addTo: map.
	^ map
]
