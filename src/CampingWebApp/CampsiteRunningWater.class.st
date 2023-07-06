Class {
	#name : #CampsiteRunningWater,
	#superclass : #CampsiteWaterAccess,
	#classInstVars : [
		'instance'
	],
	#category : #CampingWebApp
}

{ #category : #accessing }
CampsiteRunningWater class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #visiting }
CampsiteRunningWater >> accept: aClass with:  aWCHtmlCanvas [
	aClass visitRunningWater: self on: aWCHtmlCanvas
]

{ #category : #accessing }
CampsiteRunningWater >> name [ 
	^ 'Running Water'
]
