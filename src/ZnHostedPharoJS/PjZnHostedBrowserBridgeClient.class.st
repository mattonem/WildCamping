Class {
	#name : #PjZnHostedBrowserBridgeClient,
	#superclass : #PjFileBasedBridgeClient,
	#traits : 'PjTWebBridgeClient',
	#classTraits : 'PjTWebBridgeClient classTrait',
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

{ #category : #'as yet unclassified' }
PjZnHostedBrowserBridgeClient >> initZnServer [
		|stream|
		stream := String new writeStream.

		exporter writeJsCodeOn: stream.
		
		self server delegate map: 'web' to: [ :request | 
			ZnResponse ok: (ZnEntity html: codeGenerator html) ].
		self server delegate map: 'index.js' to: [ :request | 
			ZnResponse ok: (ZnEntity javascript: stream contents) ].
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

	^ (self server url / 'web') asString
]
