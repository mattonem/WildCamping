Class {
	#name : #WCCOSMapWidget,
	#superclass : #WCComponent,
	#instVars : [
		'map',
		'view'
	],
	#pools : [
		'LeafletjsGlobals'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #rendering }
WCCOSMapWidget >> addMarker: aPoint [

	^ (L marker: {
			 aPoint x.
			 aPoint y }) addTo: map
]

{ #category : #rendering }
WCCOSMapWidget >> fitBounds: aRectangle [

	^ map fitBounds: (self jsRectangle: aRectangle)
]

{ #category : #rendering }
WCCOSMapWidget >> jsPoint: aPoint [

	^ { 
		  aPoint x.
		  aPoint y }
]

{ #category : #rendering }
WCCOSMapWidget >> jsRectangle: aRectangle [

	^ {
		  self jsPoint: aRectangle topLeft.
		  self jsPoint: aRectangle bottomRight.}
]

{ #category : #rendering }
WCCOSMapWidget >> polygon: collectionOfPoint [

	^ (L polygon:
		 (collectionOfPoint collect: [ :aPoint | self jsPoint: aPoint ])
			 asArray) addTo: map
]

{ #category : #rendering }
WCCOSMapWidget >> polygon: collectionOfPoint with: options [

	^ (L polygon:
		   (collectionOfPoint collect: [ :aPoint | self jsPoint: aPoint ])
			   asArray with: options) addTo: map
]

{ #category : #rendering }
WCCOSMapWidget >> renderHtmlOn: html [

	html div
		style: 'height: 300px;';
		id: 'map'
]

{ #category : #rendering }
WCCOSMapWidget >> setView: aPoint [

	map setView: (self jsPoint: aPoint)
]

{ #category : #rendering }
WCCOSMapWidget >> setView: aPoint zoomLevel: aNumber [

	map setView: (self jsPoint: aPoint) zoomLevel: aNumber
]

{ #category : #rendering }
WCCOSMapWidget >> start [

	map ifNil: [
		map := (L map: (self getElementById: 'map'))
			       setView: (self jsPoint: 0 @ 0)
			       with: 13.
		(L
			 tileLayer: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'
			 with: {
					 (#maxZoom -> 19).
					 (#attribution
					  ->
					  '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') }
					 asJsObject) addTo: map ].
	super start.
	^ map
]
