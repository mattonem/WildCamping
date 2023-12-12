Class {
	#name : #WCHelloWorldApp,
	#superclass : #WCComponentApp,
	#category : #'WildCampComponent-Examples'
}

{ #category : #accessing }
WCHelloWorldApp class >> rootComponentClass [
^ WCHelloWorldComponent 
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
