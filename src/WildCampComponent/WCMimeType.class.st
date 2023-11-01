Class {
	#name : #WCMimeType,
	#superclass : #Object,
	#instVars : [
		'main',
		'sub',
		'parameters'
	],
	#category : #WildCampComponent
}

{ #category : #'instance creation' }
WCMimeType class >> main: aMainString sub: aSubString [
	^ self new
		main: aMainString;
		sub: aSubString;
		yourself
]

{ #category : #convenience }
WCMimeType class >> textCss [
	^ self main: 'text' sub: 'css'
]

{ #category : #convenience }
WCMimeType class >> textJavascript [
	^ self main: 'text' sub: 'javascript'
]

{ #category : #accessing }
WCMimeType >> encodeOn: aDocument [ 
	aDocument print: self greaseString
]

{ #category : #accessing }
WCMimeType >> greaseString [
	| stringSize string stream |
	stringSize := main size + 1 + sub size.
	parameters isNil ifFalse: [
		parameters keysAndValuesDo: [ :key :value |
			stringSize := stringSize + 1 + key size + 1 + value size ] ].
	"allocate with correct size, avoid copy"
	string := String new: stringSize.
	stream := string writeStream.
	stream
		nextPutAll: main;
		nextPut: $/;
		nextPutAll: sub.
	parameters isNil ifFalse: [
		parameters keysAndValuesDo: [ :key :value | 
			stream
				nextPut: $;;
				nextPutAll: key;
				nextPut: $=;
				nextPutAll: value ] ].
	"no need for #contents because we allocated with the correct size"
	^ stream contents
]

{ #category : #accessing }
WCMimeType >> main: aString [
	main := aString
]

{ #category : #accessing }
WCMimeType >> sub: aString [
	sub := aString
]
