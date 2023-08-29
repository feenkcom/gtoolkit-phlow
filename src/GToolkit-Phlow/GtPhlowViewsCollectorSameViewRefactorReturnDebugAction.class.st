Class {
	#name : #GtPhlowViewsCollectorSameViewRefactorReturnDebugAction,
	#superclass : #DebugAction,
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #initialization }
GtPhlowViewsCollectorSameViewRefactorReturnDebugAction class >> refactorReturnDebugActionFor: aDebugger [
	"<gtPhlowSaveViewReturnFixDebugAction>"
	
	^ self forDebugger: aDebugger
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewRefactorReturnDebugAction >> asBrickButton [
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
		label: self label;
		yourself
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewRefactorReturnDebugAction >> defaultIcon [
	^  BrGlamorousVectorIcons driller
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewRefactorReturnDebugAction >> defaultLabel [
	^ 'Refactor view return'
]

{ #category : #initialization }
GtPhlowViewsCollectorSameViewRefactorReturnDebugAction >> initialize [
	super initialize.
	
	"No need to update the debgger as it will anyway be closed."
	self needsUpdate: false
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewRefactorReturnDebugAction >> refactoringContent [
	| container|
	
	container := BrFrame new
		hExact: 650;
		vExact: 300.
	container addChild: ((self debugger session exception refactoringModel
		gtApplyingChangesFor:  GtPhlowView empty) 
			asElementDo: [:e | e]).
	
	^ container
]
