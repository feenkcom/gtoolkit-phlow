accessing
asElementDo: aBlock
	| tab group |
	self originalView asElementDo: [ :originalElement | 
		tab := BrTab new
			look: BrMaterialTabLabelledLook - BrMaterialTabBackgroundLook;
			label: self label;
			stencil: [ originalElement asScrollableElement ] ].
	group := BrTabGroup new
		look: (BrMaterialTabGroupLook new headerBackground: (Color fromHexString: #'e0e0e0'));
		addTab: tab;
		constraintsDo: [ :c | 
			c vertical matchParent. 
			c horizontal matchParent ].
	^ aBlock value: group