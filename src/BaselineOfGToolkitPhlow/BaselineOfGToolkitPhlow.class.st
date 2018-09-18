"
Phlow is a generic browsing engine for specifying views and transmissions. It is primarily used for defining Inspector extensions.
"
Class {
	#name : #BaselineOfGToolkitPhlow,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitPhlow
}

{ #category : #baseline }
BaselineOfGToolkitPhlow >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Brick' with: [ spec repository: 'github://pharo-graphics/Brick/src' ];
			package: 'GToolkit-Phlow' with: [ spec requires: #(Brick) ] ]
]
