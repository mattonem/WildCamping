Class {
	#name : 'PjZnHostedBrowserBridgeClient',
	#superclass : 'PjFileBasedBridgeClient',
	#traits : 'PjTWebBridgeClient',
	#classTraits : 'PjTWebBridgeClient classTrait',
	#instVars : [
		'uuid'
	],
	#category : 'ZnHostedPharoJS',
	#package : 'ZnHostedPharoJS'
}

{ #category : 'initialization' }
PjZnHostedBrowserBridgeClient >> codeGeneratorClass [

	self codeGenerator ifNil: [ ^ ZnHostedCodeGenerator ].
	^ self codeGenerator species
	"Allows keeping the behavior upon reseting the client in the bridge. See PjBridge>>#resetClient"
]

{ #category : 'accessing - defaults' }
PjZnHostedBrowserBridgeClient >> defaultAppClass [

	^ PjMinimalFileBasedWebApp
]

{ #category : 'accessing - defaults' }
PjZnHostedBrowserBridgeClient >> exporterClass [

	^ PjFileExporterWithIndexHtml 
]

{ #category : 'as yet unclassified' }
PjZnHostedBrowserBridgeClient >> initZnServer [

	| stream html delegate workers |
	html := codeGenerator html.
	stream := String new writeStream.

	exporter writeJsCodeOn: stream.
	self server delegate map: 'web' to: (ZnPrefixMappingDelegate new
			 map: 'web'
			 to: (delegate := ZnPrefixMappingDelegate new
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
								                          (ZnEntity javascript:
										                           stream contents).
						              response headers
							              at: 'Cache-Control'
							              put: 'no-cache, no-store, must-revalidate'.
						              response headers at: 'Pragma' put: 'no-cache'.
						              response headers at: 'Expires' put: '0'.
						              response ])).
	workers := codeGenerator workers.
	workers do: [ :aWorker |
		| aString |
		aString := codeGenerator jsForWorker: aWorker.
		delegate map: aWorker appJsFileName to: [ :request |
			| response |
			response := ZnResponse ok: (ZnEntity javascript: aString).
			response headers
				at: 'Cache-Control'
				put: 'no-cache, no-store, must-revalidate'.
			response headers at: 'Pragma' put: 'no-cache'.
			response headers at: 'Expires' put: '0'.
			response ] ].

	exporter staticFoldersToExpose keysAndValuesDo: [ :name :aFileReference |
		((self server delegate prefixMap at: 'web') prefixDictionary at:
			 'web') map: name to: (ZnStaticFileServerDelegate new
				 prefixFromString: '/';
				 directory: aFileReference;
				 yourself) ]
]

{ #category : 'actions' }
PjZnHostedBrowserBridgeClient >> openWebBrowserOn: appHtmlFileUrlString [

	WebBrowser
		openOn: appHtmlFileUrlString
		
]

{ #category : 'actions' }
PjZnHostedBrowserBridgeClient >> start [
	self initZnServer. 
	super start
]

{ #category : 'accessing' }
PjZnHostedBrowserBridgeClient >> urlString [

	^ (self server url / 'web' / 'index.html') asString .
]
