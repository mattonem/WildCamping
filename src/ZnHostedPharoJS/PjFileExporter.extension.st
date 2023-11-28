Extension { #name : #PjFileExporter }

{ #category : #'*ZnHostedPharoJS' }
PjFileExporter >> staticFoldersToExpose [
	^ self appClass rawAppClass staticFoldersToExpose
]
