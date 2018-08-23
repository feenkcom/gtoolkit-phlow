accessing
actionsToolbarForElement: anElement
	| aToolbar |

	aToolbar := BrToolbar new.
	aToolbar look: BrToolbarLook horizontal.

	phlowActions do: [ :phlowAction |
		phlowAction asElementDo: [ :actionElement |
			aToolbar addItem: actionElement ] withElement: anElement ].

	 ^ aToolbar
