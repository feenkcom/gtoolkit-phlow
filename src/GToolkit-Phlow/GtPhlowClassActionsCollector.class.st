Class {
	#name : #GtPhlowClassActionsCollector,
	#superclass : #GtPhlowActionsCollector,
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #accessing }
GtPhlowClassActionsCollector >> collect [
	<return: #Array of: #GtPhlowAction>
	<gtCollector>
	| anActions |
	anActions := self sortedPragmas
			collect: [ :eachPragma | 
				| anAction |
				anAction := GtPhlowAction noAction.
				[ GtProcessStackOverflowChecker currentCheckerClass
					checkDuring: [ thisContext
							object: from soleInstance
							perform: eachPragma methodSelector
							withArguments: {anAction}
							inClass: from ] ]
					on: Error
					do: [ :error | 
						GtPhlowActionWithError new
							definingMethod: eachPragma method asRingDefinition;
							freeze: error ] ]
			thenSelect: self selectUsing.
	self sortByPriority: anActions.
	^ anActions
]
