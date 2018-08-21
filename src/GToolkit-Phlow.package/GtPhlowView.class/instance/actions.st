accessing
actions
	| aToolbar aToolbarItem |
	aToolbar := BrToolbar new.
	aToolbar look: BrToolbarLook horizontal.
	
	self actionStencils collect: [ :eachAction |
		aToolbarItem := BrToolbarItem new.
		aToolbarItem stencil: eachAction .
		aToolbarItem look: BrToolbarItemLook.
		aToolbar addItem: aToolbarItem.
	 ].
	phlowActions do: [ :phlowAction |
		phlowAction asElementDo: [ :actionElement |
			aToolbarItem := BrToolbarItem new.
			aToolbarItem stencil: actionElement .
			aToolbarItem look: BrToolbarItemLook.
			aToolbar addItem: aToolbarItem.
		]
	].
	 ^ aToolbar
