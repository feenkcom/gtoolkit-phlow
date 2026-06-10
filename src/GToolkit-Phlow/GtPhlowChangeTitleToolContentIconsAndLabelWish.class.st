Class {
	#name : #GtPhlowChangeTitleToolContentIconsAndLabelWish,
	#superclass : #GtPhlowChangeTitleWish,
	#instVars : [
		'contentIcon',
		'label',
		'toolIcon'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #utils }
GtPhlowChangeTitleToolContentIconsAndLabelWish >> buildElementWithToolIcon: aToolIcon [
	| container |
	
	contentIcon ifNil: [ ^ aToolIcon ].
	
	container := BrHorizontalPane new.
	container fitContent.
	container addChild: (aToolIcon asElement
		id: #toolIcon;
		yourself).
	container addChild: (self contentIcon asElement
		id: #contentIcon;
		yourself).
	
	^ container
]

{ #category : #accessing }
GtPhlowChangeTitleToolContentIconsAndLabelWish >> contentIcon [
	^ contentIcon
]

{ #category : #accessing }
GtPhlowChangeTitleToolContentIconsAndLabelWish >> contentIcon: anIcon [
	contentIcon := anIcon
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleToolContentIconsAndLabelWish >> icon [
	^ self toolIcon
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleToolContentIconsAndLabelWish >> label [
	^ label
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleToolContentIconsAndLabelWish >> label: anObject [
	label := anObject
]

{ #category : #sending }
GtPhlowChangeTitleToolContentIconsAndLabelWish >> sendTo: anEventHandler [
	anEventHandler updateTitleLabelFromWish: self.
	
	anEventHandler tabDo: [ :aBrTab |
		self iconDo: [ :anIcon |
			aBrTab enqueueTask: (BlTaskAction new action: [ 
				aBrTab icon: (self buildElementWithToolIcon: anIcon) ]) ] ].
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleToolContentIconsAndLabelWish >> toolIcon [
	 ^ toolIcon
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleToolContentIconsAndLabelWish >> toolIcon: anObject [
	toolIcon := anObject
]
