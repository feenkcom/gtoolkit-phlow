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
TGtPhlowWithContextMenu >> contextMenuItemsStencilFromActions [
	"I return a block (stencil builder) that knows how to compute `BrMenu` sub-instances. 
	I can also return `nil` if there is no menu to display."

	<return: #GtPhlowListContextMenuItemsStencilBuilder>
	<return: #BlockClosure of: #BrMenuItems>
	^ [ :element :item | 
	| allItems |
	allItems := (self contextMenuActions
			select: [ :anAction | anAction respondsToItem: item ]
			thenCollect: [ :anAction | 
				| aResult | 
				aResult := anAction toMenuItemOn: item element: element.
				(aResult isKindOf: BrMenuItems) 
					ifTrue: [ aResult items ] 
					ifFalse: [ aResult ] ])
			flattened.
	allItems ifNotEmpty: [ BrMenuItems new addItems: allItems ] ifEmpty: [ nil ] ]
]

{ #category : #building }
TGtPhlowWithContextMenu >> contextMenuStencilFromActions [
	^ [ :element :item | 
	BrGlamorousSimpleContextMenuContent new
		items: (self contextMenuActions
				select: [ :anAction | anAction respondsToItem: item ]
				thenCollect: [ :anAction | anAction toActionOn: item element: element ])
				flattened ]
]

{ #category : #accessing }
TGtPhlowWithContextMenu >> dynamicContextItems: aBlock [
	self contextMenuActions
		add: (GtPhlowContextMenuActions named: 'Dynamic menu items' action: aBlock)
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
