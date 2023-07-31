Class {
	#name : #WCGeoHashWebApp,
	#superclass : #PjFileBasedWebApp,
	#traits : 'StaticComponentHolder',
	#classTraits : 'StaticComponentHolder classTrait',
	#category : #WCGeoHashWebApp
}

{ #category : #accessing }
WCGeoHashWebApp class >> appClasses [

	<pharoJsSkip>
	^ super appClasses , { WCCOSMapWidget  }
]

{ #category : #accessing }
WCGeoHashWebApp class >> bridgeClientClass [

	<pharoJsSkip>
	^ PjZnHostedBrowserBridgeClient
]

{ #category : #accessing }
WCGeoHashWebApp class >> exporterClass [

	<pharoJsSkip>
	^ PjFileExporterWithIndexHtml
]

{ #category : #accessing }
WCGeoHashWebApp class >> generateHtmlUsing: html [

	<pharoJsSkip>
	html div
		class: 'container';
		with: [
			WCCOSMapWidget for: self on: html named: #map.
			html textInput id: 'lon'.
			html textInput id: 'lat'.
			html button id: 'calculate'; with: 'calculate'.
			html span id: 'result' ]
]

{ #category : #accessing }
WCGeoHashWebApp class >> updateHtmlRoot: root [

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
WCGeoHashWebApp >> initialize [

	super initialize.
	self initializeComponentHolder
]

{ #category : #'initialize-release' }
WCGeoHashWebApp >> start [

	(document getElementById: 'calculate')
		addEventListener: #click
		block: [
			| lon lat gh |
			lon := (document getElementById: 'lon') value asNumber.
			lat := (document getElementById: 'lat') value asNumber.
			gh := WCGeoHash hashFor: lon @ lat precision: 5.
			(document getElementById: 'result') innerHTML: gh stringAddress.

			(self componentNamed: #map)
				setView: gh center;
				polygon: {
						gh bounds topLeft.
						gh bounds topRight.
						gh bounds bottomRight.
						gh bounds bottomLeft } ]
]
