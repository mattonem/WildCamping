Class {
	#name : #CSCreateWebApp,
	#superclass : #WCComponentApp,
	#category : #CampingWebApp
}

{ #category : #accessing }
CSCreateWebApp class >> rootComponentClass [

	^CSCreationForm 
]

{ #category : #accessing }
CSCreateWebApp class >> staticComponentsSerialized [

	<jsLiteralGenerator>
	^ self _staticComponents asPhxJsonString
]

{ #category : #accessing }
CSCreateWebApp class >> updateHtmlRoot: root [

	<pharoJsSkip>
	root stylesheet url:
		'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'.
	root stylesheet url:
		'https://unpkg.com/leaflet@1.9.4/dist/leaflet.css'.
	root javascript url:
		'https://unpkg.com/leaflet@1.9.4/dist/leaflet.js'
]
