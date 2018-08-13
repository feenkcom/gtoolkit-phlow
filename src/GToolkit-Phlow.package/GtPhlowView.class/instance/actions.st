transforming
actions
	| aToolbar aToolbarItem |
	aToolbar := BrToolbar new.
	aToolbar look: BrToolbarLook horizontal.
	self actionStencils collect: [ :eachAction | 
		aToolbarItem := BrToolbarItem new.
		aToolbarItem stencil: eachAction .
		aToolbarItem look: BrToolbarItemLook + BrMouseHoverLook + BrMouseClickLook.
		aToolbar addItem: aToolbarItem.
	 ].
	 ^ aToolbar