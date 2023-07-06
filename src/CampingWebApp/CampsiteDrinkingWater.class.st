Class {
	#name : #CampsiteDrinkingWater,
	#superclass : #CampsiteWaterAccess,
	#classInstVars : [
		'instance'
	],
	#category : #CampingWebApp
}

{ #category : #accessing }
CampsiteDrinkingWater class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #visiting }
CampsiteDrinkingWater >> accept: aClass with:  aWCHtmlCanvas [
	aClass visitDrinkingWater: self on: aWCHtmlCanvas
]

{ #category : #accessing }
CampsiteDrinkingWater >> name [ 
	^ 'Drinking Water'
]
