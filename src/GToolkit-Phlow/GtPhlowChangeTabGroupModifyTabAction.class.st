Class {
	#name : #GtPhlowChangeTabGroupModifyTabAction,
	#superclass : #GtPhlowChangeAction,
	#instVars : [
		'tabGroup',
		'buildContext',
		'addTabAction',
		'removeTabAction'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #'api - actions' }
GtPhlowChangeTabGroupModifyTabAction >> actOn: aChangeContext [
	self tabGroup ifNil: [ ^ self ].
	self compositeView ifNil: [ ^ self ].
	self buildContext isBuildContext ifFalse: [ ^ self ].
	self contentsBuilder ifNil: [ ^ self ].
	
	BlTaskAction
		enqueueElement: self tabGroup
		action: [ self modifyOn: aChangeContext ]
]

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
GtPhlowChangeTabGroupModifyTabAction >> modifyOn: aChangeContext [
	"Must be called from a UI process"

	removeTabAction removeOn: aChangeContext.
	addTabAction addOn: aChangeContext
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
