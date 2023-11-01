Class {
	#name : #WCHelloWorldApp,
	#superclass : #PjFileBasedWebApp,
	#traits : 'StaticComponentHolder',
	#classTraits : 'StaticComponentHolder classTrait',
	#instVars : [
		'user',
		'comp'
	],
	#classVars : [
		'AngryGreetingParagraph',
		'GreetingParagraph'
	],
	#category : #'WildCampComponent-Examples'
}

{ #category : #description }
WCHelloWorldApp class >> appClasses [

	<pharoJsSkip>
	^ super appClasses , { 
		  WCCOSMapWidget.
		  WCCHelloWorld }
]

{ #category : #description }
WCHelloWorldApp class >> bridgeClass [
	<pharoJsSkip>
	^ PjBridge
]

{ #category : #description }
WCHelloWorldApp class >> bridgeClientClass [
	<pharoJsSkip>
	
	^ PjZnHostedBrowserBridgeClient
]

{ #category : #description }
WCHelloWorldApp class >> generateHtmlUsing: html [

	<pharoJsSkip>
	html div
		class: 'container';
		with: [ :cont |
			cont div
				class: 'card';
				with: [ :card |
					card div
						class: 'card-header';
						with: 'Hello World !'.

					WCCHelloWorld for: self on: html named: #hello ] ]
]

{ #category : #description }
WCHelloWorldApp class >> updateHtmlRoot: root [

	<pharoJsSkip>
	root language: 'en'.
	root stylesheet url:
		'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'.
	root stylesheet url:
		'https://unpkg.com/leaflet@1.9.4/dist/leaflet.css'.
	root javascript url:
		'https://unpkg.com/leaflet@1.9.4/dist/leaflet.js'
]

{ #category : #'initialize-release' }
WCHelloWorldApp >> initialize [

	super initialize
]

{ #category : #'initialize-release' }
WCHelloWorldApp >> start [

	super start.
	self initializeComponentHolder
]
