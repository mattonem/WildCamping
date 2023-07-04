Class {
	#name : #WCCOSMapWidget,
	#superclass : #WCComponent,
	#instVars : [
		'map'
	],
	#pools : [
		'LeafletjsGlobals'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #rendering }
WCCOSMapWidget >> addMarker: aPoint [

	(L marker: { 
			 aPoint x.
			 aPoint y }) addTo: map
]

{ #category : #rendering }
WCCOSMapWidget >> renderHtmlOn: html [

	html div
		style: 'height: 180px;';
		id: 'map'
]

{ #category : #rendering }
WCCOSMapWidget >> setView: aPoint [
	map setView: { aPoint x. aPoint y}
]

{ #category : #rendering }
WCCOSMapWidget >> start [

	map := (L map: (self getElementById: 'map'))
		       setView: { 51.505. -0.09 }
		       with: 13.
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
