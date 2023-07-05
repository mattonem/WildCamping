Class {
	#name : #WCHeadingTag,
	#superclass : #WCTagBrush,
	#instVars : [
		'level'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #accessing }
WCHeadingTag >> level [
	^ level
]

{ #category : #accessing }
WCHeadingTag >> level: anInteger [
	level := (anInteger max: 1) min: 6
]

{ #category : #accessing }
WCHeadingTag >> tag [
	^ 'h' , self level greaseString
]
