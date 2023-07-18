Extension { #name : #ZnPrefixMappingDelegate }

{ #category : #'*ZnHostedPharoJS' }
ZnPrefixMappingDelegate >> value: aRequest [
	^ self handleRequest: aRequest
]
