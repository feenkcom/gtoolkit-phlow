Class {
	#name : #GtPhlowChangeTabGroupModifyTabAction,
	#superclass : #GtPhlowChangeAction,
	#instVars : [
		'tabGroup',
		'addTabAction',
		'removeTabAction'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #accessing }
GtPhlowChangeTabGroupModifyTabAction >> buildContext [
	<return: #GtPhlowBuildContext>
	^ addTabAction buildContext
]

{ #category : #accessing }
GtPhlowChangeTabGroupModifyTabAction >> buildContext: aBuildContext [
	addTabAction buildContext: aBuildContext
]

{ #category : #accessing }
GtPhlowChangeTabGroupModifyTabAction >> compositeView [
	^ self tabGroup phlow entity
]

{ #category : #accessing }
GtPhlowChangeTabGroupModifyTabAction >> contentsBuilder [
	^ addTabAction contentsBuilder
]

{ #category : #accessing }
GtPhlowChangeTabGroupModifyTabAction >> contentsBuilder: anObject [
	addTabAction contentsBuilder: anObject
]

{ #category : #initialization }
GtPhlowChangeTabGroupModifyTabAction >> initialize [
	super initialize.

	addTabAction := GtPhlowChangeTabGroupAddTabAction new.
	removeTabAction := GtPhlowChangeTabGroupRemoveTabAction new
]

{ #category : #'api - actions' }
GtPhlowChangeTabGroupModifyTabAction >> prepareOn: aChangeContext [
	"Can be called in any process.
	It returns an action that must be executed in a UI process."
	
	<return: #TGtPhlowChangeUpdateAction>
	| removeAction addAction |
	removeAction := removeTabAction prepareOn: aChangeContext.
	addAction := addTabAction prepareOn: aChangeContext.
	^ GtPhlowChangeCompositeUpdateAction new
		updateActions: (Array with: removeAction with: addAction)
]

{ #category : #accessing }
GtPhlowChangeTabGroupModifyTabAction >> tabGroup [
	^ tabGroup
]

{ #category : #accessing }
GtPhlowChangeTabGroupModifyTabAction >> tabGroup: anObject [
	tabGroup := anObject.
	addTabAction tabGroup: anObject.
	removeTabAction tabGroup: anObject.
]

{ #category : #'api - actions' }
GtPhlowChangeTabGroupModifyTabAction >> update: aResult on: aChangeContext [
	"Must be called in a UI process.
	This method is not called since the #prepareOn: returns 
	an action that calls dirrectly remove and add actions."

	
]
