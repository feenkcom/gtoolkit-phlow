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
TGtPhlowWithContextMenu >> contextItemLabel: aString action: aBlock if: aFilterBlock [
	self contextMenuActions
		add: (GtPhlowContextMenuAction named: aString action: aBlock if: aFilterBlock)
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
				select: [ :anAction | anAction respondsTo: item ]
				thenCollect: [ :anAction | anAction toActionOn: item ]) ]
]

{ #category : #accessing }
TGtPhlowWithContextMenu >> gtViewContextMenuActionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Context menu actions';
		items: [ self contextMenuActions ];
		column: 'Name' text: #name;
		column: 'Action' text: #action;
		column: 'Filter' text: [ :anAction | anAction filter ifNil: [ '' ] ]
]
