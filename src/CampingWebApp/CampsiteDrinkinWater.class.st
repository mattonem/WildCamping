Class {
	#name : #CampsiteDrinkinWater,
	#superclass : #CampsiteWaterAccess,
	#classInstVars : [
		'instance'
	],
	#category : #CampingWebApp
}

{ #category : #accessing }
CampsiteDrinkinWater class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #accessing }
CampsiteDrinkinWater >> name [ 
	^ 'Drinking Water'
]
