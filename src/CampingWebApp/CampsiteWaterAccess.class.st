Class {
	#name : #CampsiteWaterAccess,
	#superclass : #CampingSiteQuality,
	#category : #CampingWebApp
}

{ #category : #accessing }
CampsiteWaterAccess >> categories [
	^ super categories, { 'waterAccess' }
]
