Class {
	#name : #CampsiteQualitiesWidget,
	#superclass : #WCComponent,
	#instVars : [
		'qualities'
	],
	#category : #CampingWebApp
}

{ #category : #rendering }
CampsiteQualitiesWidget >> list: aList [

	qualities := aList
]

{ #category : #rendering }
CampsiteQualitiesWidget >> renderHtmlOn: html [

	html div
		class: 'row row-cols-10 g-4';
		with: [ 
			10 timesRepeat: [ 
					qualities do: [ :qual | 
							html div
								class: 'col';
								with: [ 
									CampsiteQualityWidget new
										quality: qual;
										on: html ] ] ] ]
]
