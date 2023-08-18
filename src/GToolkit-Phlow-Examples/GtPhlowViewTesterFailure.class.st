Class {
	#name : #GtPhlowViewTesterFailure,
	#superclass : #AssertionFailure,
	#category : #'GToolkit-Phlow-Examples-Tester'
}

{ #category : #accessing }
GtPhlowViewTesterFailure >> gtDebuggingExtensionConfiguration [
	"Enable the debugging extension for this assertion failure"
	^ super gtDebuggingExtensionConfiguration
		enableDebuggingViewExtension: [ true ] 
]
