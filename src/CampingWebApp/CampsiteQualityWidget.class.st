Class {
	#name : #CampsiteQualityWidget,
	#superclass : #WCComponent,
	#instVars : [
		'quality'
	],
	#category : #CampingWebApp
}

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
				with: [ CampsiteIcons iconForQuality: quality on: html ].
			html div
				class: 'card-footer';
				with: [ 
					html anchor
						url: 'https://lnt.org/';
						with: 'more about it...' ] ]
]
