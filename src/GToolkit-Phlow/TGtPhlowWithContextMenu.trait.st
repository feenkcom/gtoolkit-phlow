Trait {
	#name : #TGtPhlowWithContextMenu,
	#instVars : [
		'contextMenuActions'
	],
	#category : #'GToolkit-Phlow-Support - Context Menu'
}

{ #category : #accessing }
TGtPhlowWithContextMenu >> contextItemLabel: aString action: aBlock [
	self contextMenuActions
		add: (GtPhlowContextMenuAction named: aString action: aBlock)
]

{ #category : #accessing }
TGtPhlowWithContextMenu >> contextMenuActions [
	^ contextMenuActions ifNil: [ contextMenuActions := OrderedCollection new ]
]

{ #category : #building }
TGtPhlowWithContextMenu >> contextMenuStencilFromActions [
	^ [ :element :item | 
	BrGlamorousSimpleContextMenuContent new
		items: (self contextMenuActions
				collect: [ :aContextMenuAction | 
					aContextMenuAction name
						-> [ :anElement | aContextMenuAction action cull: anElement cull: item ] ]) ]
]
