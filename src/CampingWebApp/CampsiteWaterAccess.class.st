Class {
	#name : #CampsiteWaterAccess,
	#superclass : #CampingSiteAttributes,
	#category : #CampingWebApp
}

{ #category : #accessing }
CampsiteWaterAccess >> categories [
	^ super categories, { 'waterAccess' }
]
