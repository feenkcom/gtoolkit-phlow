accessing
asElementDo: aBlock
	| tab group |
	group := BrTabGroup new.
	self originalView asElementDo: [ :originalElement | 
		tab := BrTab new.
		group phlow beView; entity: self.
		tab
			look: BrMaterialTabLabelledLook - BrMaterialTabBackgroundLook;
			label: self label;
			stencil: [ originalElement asScrollableElement ];
			actionsStencil: (self actionsToolbarForElement: group) ].
	group 
		look: (BrMaterialTabGroupLook new headerBackground: (Color fromHexString: #'e0e0e0'));
		addTab: tab;
		constraintsDo: [ :c | 
			c vertical matchParent. 
			c horizontal matchParent ].
	^ aBlock value: group