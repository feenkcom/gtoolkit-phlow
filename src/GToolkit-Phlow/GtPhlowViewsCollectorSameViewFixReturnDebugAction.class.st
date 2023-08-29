Class {
	#name : #GtPhlowViewsCollectorSameViewFixReturnDebugAction,
	#superclass : #DebugAction,
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #initialization }
GtPhlowViewsCollectorSameViewFixReturnDebugAction class >> fixReturnDebugActionFor: aDebugger [
	<gtPhlowSaveViewReturnFixDebugAction>
	
	^ self forDebugger: aDebugger
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewFixReturnDebugAction >> asBrickButton [
	| withDropdownLook |
	
	withDropdownLook := BrGlamorousWithDropdownAptitude
		handle: [
			BrButton new
				aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonIconAptitude;
				icon: self icon ]
		content: [ 
			self refactoringContent ].

	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude + withDropdownLook;
		icon: self icon;
		yourself
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewFixReturnDebugAction >> defaultIcon [
	^  BrGlamorousVectorIcons repair
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewFixReturnDebugAction >> defaultLabel [
	^ 'Fix return'
]

{ #category : #initialization }
GtPhlowViewsCollectorSameViewFixReturnDebugAction >> initialize [
	super initialize.
	
	"No need to update the debgger as it will anyway be closed."
	self needsUpdate: false
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewFixReturnDebugAction >> refactoringContent [
	| container|
	
	container := BrFrame new
		hExact: 650;
		vExact: 300.
	container addChild: ((self debugger session exception refactoringModel
		gtApplyingChangesFor:  GtPhlowView empty) 
			asElementDo: [:e | e]).
	
	^ container
]
