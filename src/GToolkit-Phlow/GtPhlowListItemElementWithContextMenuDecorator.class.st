"
#Context menu decorator for a list item element

Decorates {{gtClass:BrListItemElementStencilBuilder}} and adds support for a context menu. Intended to be used by {{gtClass:GtPhlowListView}}.

"
Class {
	#name : #GtPhlowListItemElementWithContextMenuDecorator,
	#superclass : #BrListItemElementStencilBuilder,
	#instVars : [
		'stencilBuilder',
		'contextMenuStencil',
		'contextMenuItemsStencil',
		'multipleSelectionEnabled'
	],
	#category : #'GToolkit-Phlow-Support - List utilities'
}

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator class >> stencilProperties [
	^ #(contextMenuStencil stencilBuilder contextMenuItemsStencil)
]

{ #category : #private }
GtPhlowListItemElementWithContextMenuDecorator >> buildContextMenuAptitudeFor: anElement [
	"It is an old way to build context menu.
	Use #buildContextMenuItemsAptitudeFor: instead."

	| aContextMenuAptitude |
	aContextMenuAptitude := BrGlamorousWithExplicitContextMenuAptitude
			content: [ 
				GtPhlowListAndListItemParentFinder new
					element: anElement;
					listKindOfClass: self listOfKindClass;
					foundBlock: [ :aListElement :aListItemElement | 
						| anItemHolder anItemPosition anItemObject anItemType |
						anItemHolder := aListItemElement constraints infinite holder.
						anItemPosition := anItemHolder dataSourcePosition.
						anItemObject := aListElement viewModel itemAt: anItemPosition.

						anItemType := aListElement viewModel itemTypeStencil
								itemPosition: anItemPosition;
								itemObject: anItemObject;
								build.

						contextMenuStencil
							itemType: anItemType;
							itemObject: anItemObject;
							itemPosition: anItemPosition;
							itemElement: anElement;
							build ];
					noneBlock: [ BlElement new ];
					find ].

	anElement addAptitude: aContextMenuAptitude.
]

{ #category : #private }
GtPhlowListItemElementWithContextMenuDecorator >> buildContextMenuItemsAptitudeFor: anElement [
	| aMenuAptitude |
	aMenuAptitude := BrGlamorousWithExplicitContextMenuAptitude
			menu: [ GtPhlowListAndListItemParentFinder new
					element: anElement;
					listKindOfClass: self listOfKindClass;
					foundBlock: [ :aListElement :aListItemElement | 
						| anItemHolder anItemPosition anItemObject anItemType |
						anItemHolder := aListItemElement constraints infinite holder.
						anItemPosition := anItemHolder dataSourcePosition.
						anItemObject := self isMultipleSelectionEnabled
								ifTrue: [ aListElement selectedItems
										ifEmpty: [ {aListElement viewModel itemAt: anItemPosition} ] ]
								ifFalse: [ aListElement selectedItems
										ifNotEmpty: [ :items | items anyOne ]
										ifEmpty: [ aListElement viewModel itemAt: anItemPosition ] ].

						anItemType := aListElement viewModel itemTypeStencil
								itemPosition: anItemPosition;
								itemObject: anItemObject;
								build.

						contextMenuItemsStencil
							itemType: anItemType;
							itemObject: anItemObject;
							itemPosition: anItemPosition;
							itemElement: anElement;
							build ];
					noneBlock: [ nil ];
					find ].

	anElement addAptitude: aMenuAptitude
]

{ #category : #'api - instantiation' }
GtPhlowListItemElementWithContextMenuDecorator >> buildDefault [
	| anElement |
	<return: #BrStencil or: #BlElement>

	anElement := stencilBuilder
		itemType: self itemType;
		build.

	"Prefer building context menu using `BrMenuModel` objects."
	contextMenuItemsStencil
		ifNotNil: [ self buildContextMenuItemsAptitudeFor: anElement ]
		ifNil: [ self buildContextMenuAptitudeFor: anElement ].

	^ anElement
]

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator >> contextMenuItemsStencil [
	<return: #GtPhlowListContextMenuItemsStencilBuilder or: nil>

	^ contextMenuItemsStencil
]

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator >> contextMenuItemsStencil: aGtPhlowListContextMenuItemsStencilBuilder [
	"Set a stencil builder that creates a `BrMenu` subclass instance,
	representing a context menu, e.g., `BrMenuItems` object"
	
	contextMenuItemsStencil := aGtPhlowListContextMenuItemsStencilBuilder asStencilBuilder: GtPhlowListContextMenuItemsStencilBuilder
]

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator >> contextMenuStencil [
	<return: #GtPhlowListContextMenuStencilBuilder>

	^ contextMenuStencil
]

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator >> contextMenuStencil: aGtPhlowListContextMenuStencilBuilder [
	"Set a stencil builder that creates a `BlElement` instance,
	representing a context menu, e.g., simple list element.
	
	This solution is deprecated.
	Use #contextMenuItemsStencil: instead."

	contextMenuStencil := aGtPhlowListContextMenuStencilBuilder
			asStencilBuilder: GtPhlowListContextMenuStencilBuilder
]

{ #category : #'as yet unclassified' }
GtPhlowListItemElementWithContextMenuDecorator >> initialize [
	super initialize.
	multipleSelectionEnabled := false
]

{ #category : #private }
GtPhlowListItemElementWithContextMenuDecorator >> isMultipleSelectionEnabled [
	^ multipleSelectionEnabled == true
]

{ #category : #private }
GtPhlowListItemElementWithContextMenuDecorator >> listOfKindClass [
	^ BrList
]

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator >> multipleSelectionEnabled [
	^ multipleSelectionEnabled
]

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator >> multipleSelectionEnabled: anObject [
	multipleSelectionEnabled := anObject
]

{ #category : #'api - instantiation' }
GtPhlowListItemElementWithContextMenuDecorator >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.
	aStencilExecutor
		push: stencilBuilder;
		push: contextMenuStencil;
		push: contextMenuItemsStencil
]

{ #category : #'as yet unclassified' }
GtPhlowListItemElementWithContextMenuDecorator >> reset [
	super reset.
	"we are doing this only to make the {{gtClass:GtBlocStencilBuilderShouldImplementReset}} happy"
	multipleSelectionEnabled := multipleSelectionEnabled
]

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator >> stencilBuilder [
	<return: #BrListItemElementStencilBuilder>

	^ stencilBuilder
]

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator >> stencilBuilder: aBrListItemElementStencilBuilder [
	stencilBuilder := aBrListItemElementStencilBuilder asStencilBuilder: BrListItemElementStencilBuilder
]
