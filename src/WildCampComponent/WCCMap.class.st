Class {
	#name : #WCCMap,
	#superclass : #WCComponent,
	#instVars : [
		'map',
		'view'
	],
	#pools : [
		'LeafletjsGlobals'
	],
	#category : #WildCampComponent
}

{ #category : #rendering }
WCCMap >> addMarker: aPoint [

	^ (L marker: {
			 aPoint x.
			 aPoint y }) addTo: map
]

{ #category : #rendering }
WCCMap >> fitBounds: aRectangle [

	^ map fitBounds: (self jsRectangle: aRectangle)
]

{ #category : #rendering }
WCCMap >> getBounds [

	| bounds |
	bounds := map getBounds.
	^ Rectangle
		  origin: bounds getNorthWest lat @ bounds getNorthWest lng
		  corner: bounds getSouthEast lat @ bounds getSouthEast lng
]

{ #category : #rendering }
WCCMap >> getCenter [

	^  map getCenter.

]

{ #category : #rendering }
WCCMap >> jsPoint: aPoint [

	^ { 
		  aPoint x.
		  aPoint y }
]

{ #category : #rendering }
WCCMap >> jsRectangle: aRectangle [

	^ {
		  self jsPoint: aRectangle topLeft.
		  self jsPoint: aRectangle bottomRight.}
]

{ #category : #rendering }
WCCMap >> on: event do: aBlock [

	^ map
		  on: event
		  do: aBlock
]

{ #category : #rendering }
WCCMap >> polygon: collectionOfPoint [

	^ (L polygon:
		 (collectionOfPoint collect: [ :aPoint | self jsPoint: aPoint ])
			 asArray) addTo: map
]

{ #category : #rendering }
WCCMap >> polygon: collectionOfPoint with: options [

	^ (L polygon:
		   (collectionOfPoint collect: [ :aPoint | self jsPoint: aPoint ])
			   asArray with: options) addTo: map
]

{ #category : #rendering }
WCCMap >> renderHtmlOn: html [

	html div
		style: 'height: 300px;';
		id: 'map'
]

{ #category : #rendering }
WCCMap >> setView: aPoint [

	map setView: (self jsPoint: aPoint)
]

{ #category : #rendering }
WCCMap >> setView: aPoint zoomLevel: aNumber [

	map setView: (self jsPoint: aPoint) zoomLevel: aNumber
]

{ #category : #rendering }
WCCMap >> start [

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
