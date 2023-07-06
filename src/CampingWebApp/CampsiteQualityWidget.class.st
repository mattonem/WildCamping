Class {
	#name : #CampsiteQualityWidget,
	#superclass : #WCComponent,
	#instVars : [
		'quality'
	],
	#category : #CampingWebApp
}

{ #category : #rendering }
CampsiteQualityWidget >> dropletFillOn: html [


	^ html svg
		  width: '100%';
		  height: '100%';
		  fill: '#7fcbfa';
		  class: 'bi bi-droplet-fill mx-auto';
		  viewBox: '0 0 16 16';
		  with: [ 
			  html path d:
					  'M8 16a6 6 0 0 0 6-6c0-1.655-1.122-2.904-2.432-4.362C10.254 4.176 8.75 2.503 8 0c0 0-6 5.686-6 10a6 6 0 0 0 6 6ZM6.646 4.646l.708.708c-.29.29-1.128 1.311-1.907 2.87l-.894-.448c.82-1.641 1.717-2.753 2.093-3.13Z' ]
]

{ #category : #accessing }
CampsiteQualityWidget >> quality [

	^ quality
]

{ #category : #accessing }
CampsiteQualityWidget >> quality: anObject [

	quality := anObject
]

{ #category : #rendering }
CampsiteQualityWidget >> renderHtmlOn: html [

	html div
		class: 'card';
		style: 'width: 10em';
		with: [ 
			html div
				class: 'card-header';
				with: [ 
					html heading
						class: 'card-title';
						level: 2;
						with: quality name ].
			html div
				class: 'card-body';
				with: [ self dropletFillOn: html ] ]
]
