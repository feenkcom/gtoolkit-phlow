accessing
asElementDo: aBlock
	| debugButton |
	debugButton := BrButton new.
	debugButton look: BrMaterialToggleIconifiedLook + BrMaterialToggleLabelledLook.
	debugButton label: 'Debug'.
	debugButton action: [ [error defaultAction] fork ].
	^ aBlock value: debugButton