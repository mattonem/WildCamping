Class {
	#name : #CampsiteWidget,
	#superclass : #WCComponent,
	#instVars : [
		'campsite',
		'map'
	],
	#category : #CampingWebApp
}

{ #category : #accessing }
CampsiteWidget >> campsite: anObject [

	campsite := anObject
]

{ #category : #accessing }
CampsiteWidget >> map: anObject [

	map := anObject
]

{ #category : #rendering }
CampsiteWidget >> renderHtmlOn: html [

	html div
		class: 'card';
		with: [ 
			html div
				class: 'card-body';
				with: [ 
					html heading
						level: 1;
						class: 'card-title';
						with: campsite name ].
			map := WCCOSMapWidget on: html.
			html div
				class: 'card-body';
				with: [ 
					CampsiteQualitiesWidget new
						list: (campsite qualities select: [ :aQual | 
									 aQual categories includes: #waterAccess ]);
						on: html ] ]
]

{ #category : #rendering }
CampsiteWidget >> start [

	map onStartDo: [ 
		map setView: campsite coordinates.
		map addMarker: campsite coordinates ].
	^ super start
]
