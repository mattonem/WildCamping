Class {
	#name : #CSCreationForm,
	#superclass : #WCComponent,
	#traits : 'InstanceComponentHolder',
	#classTraits : 'InstanceComponentHolder classTrait',
	#category : #CampingWebApp
}

{ #category : #rendering }
CSCreationForm >> renderHtmlOn: html [

	self addComponent: WCCMap new named: #map on: html.
	html div
		class: 'form-group';
		with: [
			html label
				for: 'name';
				with: 'Campsite name'.
			html textInput
				class: 'form-control';
				placeholder: 'An awesome campsite';
				id: 'name' ].
	html div
		class: 'form-group';
		with: [
			html label
				for: 'lat';
				with: 'Latitude'.
			html textInput
				class: 'form-control';
				placeholder: '0';
				id: 'lat'.
			html label
				for: 'lng';
				with: 'Longitude'.
			html textInput
				class: 'form-control';
				placeholder: '0';
				id: 'lng' ].
	html div
		class: 'form-group';
		with: [
			html label
				for: 'description';
				with: 'Description'.
			html textArea
				class: 'form-control';
				id: #description;
				rows: 10;
				with: '' ].

	self
		addComponent: (WCCButton new
				 label: 'submit';
				 yourself)
		named: #submit
		on: html
]

{ #category : #rendering }
CSCreationForm >> sendSubmission [

	| cs |
	cs := CampingSite new
		      name: (self getElementById: #name) value;
		      description: (self getElementById: #description) value;
		      coordinates:
			      (self getElementById: #lat) value asNumber
			      @ (self getElementById: #lng) value asNumber;
		      yourself.
	PjHttpClient new
		getUrl:
			'https://maker.ifttt.com/trigger/WCContrib/with/key/dMR5jJEOKOx6URx7sDYmVN?value1='
			, cs asPhxJsonString
		do: [  ]
]

{ #category : #rendering }
CSCreationForm >> start [

	super start.
	self initializeComponentHolder.

	navigator geolocation getCurrentPosition: [ :position |
		| lat lng marker |
		lat := position coords latitude.
		lng := position coords longitude.
		(self componentNamed: #map) setView: lat @ lng.
		marker := (self componentNamed: #map)
			          addMarker: (self componentNamed: #map) center
			          with: { (#draggable -> true) } asJsObject.
		self updateCoordinate: marker.
		(self componentNamed: #map)
			on: 'contextmenu'
			do: [ :e |
				marker setLatLng: e latlng.
				self updateCoordinate: marker ].
		marker
			on: 'drag'
			do: [ :e | self updateCoordinate: marker ] ].
	(self componentNamed: #submit) onClick: [ :e | self sendSubmission ]
]

{ #category : #rendering }
CSCreationForm >> updateCoordinate: marker [

	| markerPos |
	markerPos := marker getLatLng.
	(self getElementById: #lng) value: markerPos lng asString.
	^ (self getElementById: #lat) value: markerPos lat asString
]
