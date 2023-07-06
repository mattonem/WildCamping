Class {
	#name : #CampingSite,
	#superclass : #Object,
	#instVars : [
		'name',
		'coordinates',
		'qualities'
	],
	#category : #CampingWebApp
}

{ #category : #'as yet unclassified' }
CampingSite class >> defaultSite [

	^ self new
		  coordinates: 50 @ 20;
		  name: 'Lovely campsite';
		  qualities: {CampsiteDrinkinWater instance};
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
CampingSite >> coordinates [

	^ coordinates
]

{ #category : #accessing }
CampingSite >> coordinates: anObject [

	coordinates := anObject
]

{ #category : #accessing }
CampingSite >> initialize [ 
	qualities := Set new.
]

{ #category : #accessing }
CampingSite >> name [

	^ name
]

{ #category : #accessing }
CampingSite >> name: anObject [

	name := anObject
]

{ #category : #accessing }
CampingSite >> qualities [

	^ qualities
]

{ #category : #accessing }
CampingSite >> qualities: anObject [

	qualities := anObject
]
