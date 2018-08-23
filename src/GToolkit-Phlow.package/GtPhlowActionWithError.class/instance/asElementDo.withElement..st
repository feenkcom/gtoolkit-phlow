accessing
asElementDo: aBlock withElement: aTargetElement
	| debugButton |
	debugButton := BrButton new.
	debugButton look: BrMaterialToggleIconifiedLook + BrMaterialToggleLabelledLook.
	debugButton label: 'Debug'.
	debugButton action: [ [error defaultAction] fork ].
	^ aBlock value: debugButton