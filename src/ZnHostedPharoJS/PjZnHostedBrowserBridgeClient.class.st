Class {
	#name : #PjZnHostedBrowserBridgeClient,
	#superclass : #PjFileBasedBridgeClient,
	#traits : 'PjTWebBridgeClient',
	#classTraits : 'PjTWebBridgeClient classTrait',
	#instVars : [
		'uuid'
	],
	#category : #ZnHostedPharoJS
}

{ #category : #initialization }
PjZnHostedBrowserBridgeClient >> codeGeneratorClass [

	self codeGenerator ifNil: [ ^ ZnHostedCodeGenerator ].
	^ self codeGenerator species
	"Allows keeping the behavior upon reseting the client in the bridge. See PjBridge>>#resetClient"
]

{ #category : #'accessing - defaults' }
PjZnHostedBrowserBridgeClient >> defaultAppClass [

	^ PjMinimalFileBasedWebApp
]

{ #category : #'accessing - defaults' }
PjZnHostedBrowserBridgeClient >> exporterClass [

	^ PjFileExporter
]

{ #category : #'as yet unclassified' }
PjZnHostedBrowserBridgeClient >> initZnServer [

	| stream html |
	html := codeGenerator html.
	stream := String new writeStream.
	exporter writeJsCodeOn: stream.
	self server delegate map: 'web' to: (ZnPrefixMappingDelegate new
			 map: 'web'
			 to: (ZnPrefixMappingDelegate new
					  map: 'index.html' to: [ :request | 
						  | response |
						  response := ZnResponse ok: (ZnEntity html: html).
						  response headers
							  at: 'Cache-Control'
							  put: 'no-cache, no-store, must-revalidate'.
						  response headers at: 'Pragma' put: 'no-cache'.
						  response headers at: 'Expires' put: '0'.
						  response ];
					  map: 'index.js' to: [ :request | 
						  | response |
						  response := ZnResponse ok:
								              (ZnEntity javascript: stream contents).
						  response headers
							  at: 'Cache-Control'
							  put: 'no-cache, no-store, must-revalidate'.
						  response headers at: 'Pragma' put: 'no-cache'.
						  response headers at: 'Expires' put: '0'.
						  response ]))
]

{ #category : #actions }
PjZnHostedBrowserBridgeClient >> openWebBrowserOn: appHtmlFileUrlString [

	WebBrowser
		openOn: appHtmlFileUrlString
		inBackground: self openBrowserInBackground
]

{ #category : #actions }
PjZnHostedBrowserBridgeClient >> start [
	self initZnServer. 
	super start
]

{ #category : #accessing }
PjZnHostedBrowserBridgeClient >> urlString [

	^ (self server url / 'web' / 'index.html') asString
]
