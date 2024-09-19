Class {
	#name : #GtPhlowLabelWithIcon,
	#superclass : #BrFrame,
	#instVars : [
		'iconContainer',
		'nameLabel'
	],
	#category : #'GToolkit-Phlow-Utilities'
}

{ #category : #initialization }
GtPhlowLabelWithIcon >> initialize [
	| pane |
	super initialize.
	self
		hMatchParent;
		vFitContent.
	pane := (BrHorizontalPane new)
				hMatchParent;
				vExact: 26;
				alignCenter.
	iconContainer := (BrFrame new)
				hFitContent;
				vFitContent;
				id: #iconContainer;
				margin: (BlInsets left: 1 right: 3).
	nameLabel := (BrLabel new)
				aptitude: BrGlamorousListLabelAptitude;
				id: #nameLabel;
				text: '';
				hMatchParent.
	pane
		addChild: iconContainer;
		addChild: nameLabel.
	self addChild: pane
]

{ #category : #initialization }
GtPhlowLabelWithIcon >> initializeWithIcon: anIcon label: aString [
	nameLabel text: aString.
	iconContainer removeChildren.
	anIcon isNil ifFalse: [
		iconContainer addChild: anIcon asElement]
]

{ #category : #updating }
GtPhlowLabelWithIcon >> updateForClass: aClass [
	^ self 
		initializeWithIcon: (self 
			gtSafeIconNamed: aClass gtSystemIconName)
		label: aClass name
]

{ #category : #updating }
GtPhlowLabelWithIcon >> updateForPackage: aPackage [
	^ self 
		initializeWithIcon: (self 
			gtSafeIconNamed: #package)
		label: aPackage name
]

{ #category : #configuration }
GtPhlowLabelWithIcon >> withSmallSize [
	self children first vExact: 16
]
