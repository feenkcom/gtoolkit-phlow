accessing
asElementDo: aBlock
	| tab group |
	self originalView asElementDo: [ :originalElement | 
		tab := BrTab new
			look: BrMaterialTabLabelledLook - BrMaterialTabBackgroundLook;
			label: self label;
			stencil: [ originalElement asScrollableElement ] ].
	group := BrTabGroup new
		look: BrMaterialTabGroupLook;
		addTabs: {tab};
		constraintsDo: [ :c | 
			c vertical matchParent. 
			c horizontal matchParent ].
	^ aBlock value: group