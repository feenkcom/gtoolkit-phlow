Class {
	#name : 'GtPhlowListIconElementStencilBuilder',
	#superclass : 'BrListItemElementStencilBuilder',
	#category : 'GToolkit-Phlow-Support - List'
}

{ #category : 'api - instantiation' }
GtPhlowListIconElementStencilBuilder >> buildDefault [
	| container |

	container := BrHorizontalPane new.
	container hMatchParent; vFitContent.

	^ container
]
