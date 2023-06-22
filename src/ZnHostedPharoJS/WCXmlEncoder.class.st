Class {
	#name : #WCXmlEncoder,
	#superclass : #WCEncoder,
	#category : #ZnHostedPharoJS
}

{ #category : #accessing }
WCXmlEncoder >> nextPut: aCharacter [
	| codePoint |
	codePoint := aCharacter greaseInteger.
	codePoint = 34 "$""" ifTrue: [ ^ stream nextPutAll: '&quot;' ].
	codePoint = 60 "$<" ifTrue: [ ^ stream nextPutAll: '&lt;' ].
	codePoint = 38 "$&" ifTrue: [ ^ stream nextPutAll: '&amp;' ].
	codePoint = 62 "$>" ifTrue: [ ^ stream nextPutAll: '&gt;' ].
	stream nextPut: aCharacter
]

{ #category : #accessing }
WCXmlEncoder >> nextPutAll: aString [
	"uses #to:do: for speed reasons (on Pharo)
	this is not premature optimization, this is a hotspot method method
	and #to:do: shows measurable speed improvements for rendering seaside pages"
	1 to: aString size do: [ :index |
		self nextPut: (aString at: index) ]
]
