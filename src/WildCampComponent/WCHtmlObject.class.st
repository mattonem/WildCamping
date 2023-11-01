Class {
	#name : #WCHtmlObject,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #WildCampComponent
}

{ #category : #'instance creation' }
WCHtmlObject class >> root: aRoot [
	^ self basicNew initializeWithRoot: aRoot; yourself
]

{ #category : #initialization }
WCHtmlObject >> initializeWithRoot: aRoot [
	self initialize.
	root := aRoot
]
