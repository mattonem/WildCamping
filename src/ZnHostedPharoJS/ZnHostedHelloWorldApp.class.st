Class {
	#name : #ZnHostedHelloWorldApp,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'user'
	],
	#pools : [
		'LeafletjsGlobals'
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
	sayHelloButton addEventListener: #click block: [ 
 	greetingMessageContainer innerHTML: 
		(WCHtmlCanvas builder
				 fullDocument: false;
				 rootBlock: [ :root | 
					 root beHtml5.
					 root title: 'yolo'.
					 root javascript url: 'index.js' ];
				 render: [ :html | html div with: 'Hello ' , user name ]) ].

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
