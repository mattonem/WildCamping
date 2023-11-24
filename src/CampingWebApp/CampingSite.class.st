Class {
	#name : #CampingSite,
	#superclass : #Object,
	#instVars : [
		'name',
		'coordinates',
		'attributes',
		'description'
	],
	#category : #CampingWebApp
}

{ #category : #'as yet unclassified' }
CampingSite class >> defaultSite [

	^ self new
		  coordinates: 50 @ 20;
		  name: 'Lovely campsite';
		  attributes: {CampsiteDrinkingWater instance. CampsiteRunningWater instance};
		  yourself
]

{ #category : #'as yet unclassified' }
CampingSite class >> defaultSite: aUID ifPresent: aBlock ifAbsent: anotherBlock [
	^ { ('123' -> self defaultSite) } asDictionary
		  at: aUID
		  ifPresent: aBlock
		  ifAbsent: anotherBlock
]

{ #category : #accessing }
CampingSite >> attributes [

	^ attributes
]

{ #category : #accessing }
CampingSite >> attributes: anObject [

	attributes := anObject
]

{ #category : #accessing }
CampingSite >> coordinates [

	^ coordinates
]

{ #category : #accessing }
CampingSite >> coordinates: anObject [

	coordinates := anObject
]

{ #category : #accessing }
CampingSite >> description [

	^ description
]

{ #category : #accessing }
CampingSite >> description: anObject [

	description := anObject
]

{ #category : #accessing }
CampingSite >> initialize [ 
	attributes := Set new.
]

{ #category : #accessing }
CampingSite >> name [

	^ name
]

{ #category : #accessing }
CampingSite >> name: anObject [

	name := anObject
]
