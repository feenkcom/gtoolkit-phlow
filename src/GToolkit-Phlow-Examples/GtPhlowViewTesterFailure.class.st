Class {
	#name : #GtPhlowViewTesterFailure,
	#superclass : #AssertionFailure,
	#category : #'GToolkit-Phlow-Examples-Tester'
}

{ #category : #accessing }
GtPhlowViewTesterFailure >> gtExceptionDebuggerSpecification [
	"Enable the debugging extension for this assertion failure"
	^ super gtExceptionDebuggerSpecification
		enableWhen: [ true ] 
]
