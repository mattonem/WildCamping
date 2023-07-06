Class {
	#name : #CampsiteNotFoundWidget,
	#superclass : #WCComponent,
	#category : #CampingWebApp
}

{ #category : #rendering }
CampsiteNotFoundWidget >> renderHtmlOn: html [

	html div
		class: 'card';
		with: [ 
			html div
				class: 'card-body';
				with: [ 
					html heading
						level: 1;
						class: 'card-title';
						with: 'Campsite not found' ] ]
]
