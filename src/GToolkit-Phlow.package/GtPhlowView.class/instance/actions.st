accessing
actions
	| aToolbar |

	aToolbar := BrToolbar new.
	aToolbar look: BrToolbarLook horizontal.

	self actionStencils do: [ :eachAction |
		aToolbar addItem: eachAction asStencil asElement ].

	phlowActions do: [ :phlowAction |
		phlowAction asElementDo: [ :actionElement |
			aToolbar addItem: actionElement ] ].

	 ^ aToolbar
