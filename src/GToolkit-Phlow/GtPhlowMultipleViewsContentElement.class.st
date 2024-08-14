Class {
	#name : #GtPhlowMultipleViewsContentElement,
	#superclass : #GtPhlowBasicViewsToolContentElement,
	#instVars : [
		'viewsContainer'
	],
	#category : #'GToolkit-Phlow-Tool - Element'
}

{ #category : #callbacks }
GtPhlowMultipleViewsContentElement >> actOnToolModelChanged [
	super actOnToolModelChanged.
	
	"Views are created when the model is set."
	self buildContentViews
]

{ #category : #'building widgets' }
GtPhlowMultipleViewsContentElement >> buildContentViews [
	| tabGroup compositeView |
			
	compositeView := self collectContentViews.
	compositeView views do: [ :aView |
		"The element handles the update"
	 	aView autoUpdates definitions removeAll ].
	
	tabGroup := compositeView asElementDo: [ :e | e ].
	
	viewsContainer 
		removeChildren;
		addChild: tabGroup 
		as: #viewsContainer.
]

{ #category : #initialization }
GtPhlowMultipleViewsContentElement >> collectContentViews [ 
	^ self toolModel collectContentViews
]

{ #category : #accessing }
GtPhlowMultipleViewsContentElement >> updateContentElement [

	(viewsContainer  childNamed: #viewsContainer) 	
		content phlow firstChildWithView phlow syncUpdate.
]
