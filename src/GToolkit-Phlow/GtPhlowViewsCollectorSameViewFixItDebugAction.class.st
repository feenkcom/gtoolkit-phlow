Class {
	#name : #GtPhlowViewsCollectorSameViewFixItDebugAction,
	#superclass : #DebugAction,
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #initialization }
GtPhlowViewsCollectorSameViewFixItDebugAction class >> fixItReturnDebugActionFor: aDebugger [
	<gtPhlowSaveViewReturnFixDebugAction>
	
	^ self forDebugger: aDebugger
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewFixItDebugAction >> defaultIcon [
	^  BrGlamorousVectorIcons repair
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewFixItDebugAction >> defaultLabel [
	^ 'Fix it and re-run'
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewFixItDebugAction >> executeAction [
	self refactorContent.
	
	self session 
		restart: self session interruptedContext.
	self debugger resumeAndCloseDebugger.
]

{ #category : #initialization }
GtPhlowViewsCollectorSameViewFixItDebugAction >> initialize [
	super initialize.
	
	"No need to update the debgger as it will anyway be closed."
	self needsUpdate: false
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewFixItDebugAction >> refactorContent [
	self debugger session exception refactoringModel changes 
		executeNotifying: []
]
