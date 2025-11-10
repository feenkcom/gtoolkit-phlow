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
					ensureCheckDuring: [ thisContext
							object: from soleInstance
							perform: eachPragma methodSelector
							withArguments: {anAction}
							inClass: from ] ]
					on: Error
					do: [ :error | 
						error freeze.
						GtPhlowActionWithError new
							definingMethod: eachPragma method asRingDefinition;
							error: error ] ]
			thenSelect: self selectUsing.
	self sortByPriority: anActions.
	^ anActions
]
