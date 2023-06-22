Extension { #name : #PjNumber }

{ #category : #'*ZnHostedPharoJS' }
PjNumber >> encodeOn: aDocument [
	self printOn: aDocument
]

{ #category : #'*ZnHostedPharoJS' }
PjNumber >> greaseInteger [
	^ self truncated
]
