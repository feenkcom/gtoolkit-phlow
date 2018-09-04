Class {
	#name : #GtPhlowCompositeView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'views'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #accessing }
GtPhlowCompositeView >> asElementDo: aBlock [
	| tabs group |
	tabs := OrderedCollection new.
	self views do: [ :view |
		| tab |
		"we explicitly traverse the collection because it is possible for
		asElementDo: to not return anything when we deal with an EmptylView"
		[
			view ifItHasContent: [
				tab := BrTab new.
				tab when: BlDoubleClickEvent do: [ :event | tab fireEvent: (GtPhlowObjectToSpawn new object: view definingMethod; sourceElement: tab) ].
				tab phlow beView; entity: view.
				tab
					look: BrGlamorousTabLook;
					label: view title;
					stencil: [ 
						view asTaskItView asElementDo: [ :element | 
							element phlow beViewContent.
							element asScrollableElement margin: (BlInsets all: 10) ] ];
					actionsStencil: (view actionsToolbarForElement: tab).
				tabs add: tab ] ]
		on: Error 
		do: [ :e | 
			e freeze.
			e messageText: 'You likely did not return the proper view (', e messageText, ')'. 
			tabs add: (BrTab new
				look: BrGlamorousTabLook;
				label: 'Error';
				stencil: [ e asDebuggableElement ]) ] ].
	group := BrTabGroup new.
	group phlow beView; entity: self.
	group
		look: BrGlamorousTabGroupLook;
		addTabs: tabs.
	^ aBlock value: group
]

{ #category : #accessing }
GtPhlowCompositeView >> views [
	^ views
]

{ #category : #accessing }
GtPhlowCompositeView >> views: anObject [
	views := anObject
]
