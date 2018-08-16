accessing
asElementDo: aBlock
	| tabs group |
	tabs := OrderedCollection new.
	self views do: [ :view |
		"we explicitly traverse the collection because it is possible for
		asElementDo: to not return anything when we deal with an EmptylView"
		[view asElementDo: [ :element |
			tabs add: (BrTab new
				look: BrMaterialTabLabelledLook;
				padding: (BlInsets all: 10);
				label: view title;
				stencil: [ element asScrollableElement margin: (BlInsets all: 10) ];
				actionsStencil: view actions) ]]
			on: Error 
			do: [ :e | 
				e freeze.
				e messageText: 'You likely did not return the proper view (', e messageText, ')'. 
				tabs add: (BrTab new
					look: BrMaterialTabLabelledLook;
					padding: (BlInsets all: 10);
					label: 'Error';
					stencil: [ e asDebuggableElement ])
				 ] ].
	group := BrTabGroup new
		look: BrMaterialTabGroupLook;
		addTabs: tabs;
		constraintsDo: [ :c | 
			c vertical matchParent. 
			c horizontal matchParent ].
	^ aBlock value: group