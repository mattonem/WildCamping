Class {
	#name : #CampingSiteWebApp,
	#superclass : #PjFileBasedWebApp,
	#traits : 'StaticComponentHolder',
	#classTraits : 'StaticComponentHolder classTrait',
	#category : #CampingWebApp
}

{ #category : #accessing }
CampingSiteWebApp class >> appClasses [

	<pharoJsSkip>
	^ super appClasses , { CampsiteRootContainer }
]

{ #category : #accessing }
CampingSiteWebApp class >> bridgeClientClass [
	<pharoJsSkip>
	
	^ PjZnHostedBrowserBridgeClient
]

{ #category : #accessing }
CampingSiteWebApp class >> exporterClass [
	<pharoJsSkip>
	
	^ PjFileExporterWithIndexHtml
]

{ #category : #testing }
CampingSiteWebApp class >> generateHtmlUsing: html [

	<pharoJsSkip>
	CampsiteRootContainer for: self on: html named: #container
]

{ #category : #accessing }
CampingSiteWebApp class >> updateHtmlRoot: root [

	<pharoJsSkip>
	root stylesheet url:
		'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'.
	root stylesheet url:
		'https://unpkg.com/leaflet@1.9.4/dist/leaflet.css'.
	root javascript url:
		'https://unpkg.com/leaflet@1.9.4/dist/leaflet.js'
]

{ #category : #'initialize-release' }
CampingSiteWebApp >> _getLocationHash [
	<javascript:'return window.location.hash'>
]

{ #category : #'as yet unclassified' }
CampingSiteWebApp >> campingSiteNotFound [

	self openCampsite: 123
]

{ #category : #'initialize-release' }
CampingSiteWebApp >> getLocationHash [
	^ (self _getLocationHash splitOn: '/') allButFirst
]

{ #category : #'as yet unclassified' }
CampingSiteWebApp >> openCampsite: aString [

	| client |
	client := PjHttpClient new.
	client onLoad: [ 
		console log: 'yolo: ' , (self getLocationHash at: 1 ifAbsent: '').
		CampingSite
			defaultSite: (self getLocationHash at: 1 ifAbsent: '')
			ifPresent: [ :campsite | 
				(self componentNamed: #container) content: (WCHtmlCanvas builder
						 fullDocument: false;
						 render: [ :html | 
							 CampsiteWidget new
								 campsite: campsite;
								 on: html ]) ]
			ifAbsent: [ 
				(self componentNamed: #container) content: (WCHtmlCanvas builder
						 fullDocument: false;
						 render: [ :html | CampsiteNotFoundWidget on: html ]) ] ].


	(client method: 'GET' url: 'https://ipinfo.io/') send: ''
]

{ #category : #'as yet unclassified' }
CampingSiteWebApp >> start [

	super start.
	self openCampsite:
		(self getLocationHash at: 1 ifAbsent: [ ^ self campingSiteNotFound ]).

]
