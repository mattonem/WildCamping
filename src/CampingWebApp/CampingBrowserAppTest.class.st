Class {
	#name : #CampingBrowserAppTest,
	#superclass : #PjWebAppTestCase,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #CampingWebApp
}

{ #category : #'suite parameters' }
CampingBrowserAppTest class >> appClass [
	^ CampingSiteWebApp 
]

{ #category : #accessing }
CampingBrowserAppTest >> setUp [
super setUp
]

{ #category : #accessing }
CampingBrowserAppTest >> test1 [
	self bridge .

	1 second wait.
	self assert: (document querySelector:'.card-title') innerHTML equals: 'Campsite not found'.
]

{ #category : #accessing }
CampingBrowserAppTest >> test123 [
	| clientUrl |
	self bridge .
	clientUrl := (self bridge server url / 'web' / 'index.html') fragment: '/123'.
	self bridge client stop.
	self bridge resetProxiesImmediately.
	self waitWhile: [ self bridge isConnected ] timeOut: 2 seconds.
	self bridge client openWebBrowserOn: clientUrl asString.
	self waitUntil: [ self bridge isConnected ] timeOut: 2 seconds.
	self waitWhile: [ (app := self currentApp) isNil ] timeOut: 2 seconds.
	1 second wait.
	self assert: (document querySelector:'.card-title') innerHTML equals: 'Lovely campsite'.
]
