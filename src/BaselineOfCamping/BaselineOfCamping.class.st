Class {
	#name : 'BaselineOfCamping',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfCamping',
	#package : 'BaselineOfCamping'
}

{ #category : 'baselines' }
BaselineOfCamping >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'PharoJS'
			with: [ spec repository: 'github://PharoJS/PharoJS:pharo13' ].

		spec baseline: 'Seaside3' with: [
			spec
				loads: #( 'Seaside-Canvas' );
				repository: 'github://SeasideSt/Seaside:master/repository' ].
		spec package: #Leafletjs with: [ spec requires: #( PharoJS ) ].
		spec
			package: #ZnHostedPharoJS
			with: [ spec requires: #( Leafletjs PharoJS Seaside3 ) ].
		spec
			package: #'ZnHostedPharoJS-Tests'
			with: [ spec requires: #( ZnHostedPharoJS ) ].
		spec
			package: #WildCampComponent
			with: [ spec requires: #( ZnHostedPharoJS ) ] ]
]
