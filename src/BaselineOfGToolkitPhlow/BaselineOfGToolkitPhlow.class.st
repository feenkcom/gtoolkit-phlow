"
1. Phlow

Phlow is a generic browsing engine for specifying views and transmissions. It is primarily used for defining inspector extensions (see {{gtClass:BaselineOfGToolkitInspector}}).

1. # Views


Views define the logic through which the concrete widgets get built. They are essentially stencils.

See {{gtClass:GtPhlowViewExamples}}.

1. # Actions


Views have actions.

See {{gtClass:GtPhlowActionExamples}}


"
Class {
	#name : #BaselineOfGToolkitPhlow,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitPhlow
}

{ #category : #baseline }
BaselineOfGToolkitPhlow >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:main/src' ];
			baseline: 'GToolkitUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
			baseline: 'GToolkitBasicUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ].
		spec package: 'GToolkit-Phlow' with: [
				spec requires: #('Brick' 'GToolkitUtility' 'GToolkitBasicUtility' ). ]. ].

]
