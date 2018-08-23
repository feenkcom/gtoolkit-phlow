accessing
actionsToolbarForElement: anElement
	| aToolbar |

	aToolbar := BrToolbar new.
	aToolbar look: BrToolbarLook horizontal.

	phlowActions do: [ :phlowAction |
		phlowAction targetElement: anElement.
		phlowAction asElementDo: [ :actionElement |
			aToolbar addItem: actionElement ] ].

	 ^ aToolbar
