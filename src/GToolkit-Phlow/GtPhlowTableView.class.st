"
GtPhlowTableView displays a 2D table of values.

The intention is that multiple object styles will be supported, but currently only a Collection of Collections is supported.

The data object doesn't need to be regular, i.e. each row may contain a different number of objects.

Cell formatting should be added. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points


"
Class {
	#name : #GtPhlowTableView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'itemsBuilder',
		'dataObject',
		'rowCountBlock',
		'columnCountBlock',
		'rowAccessorBlock',
		'cellAccessorBlock'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #converting }
GtPhlowTableView >> asElementDo: aBlock [ 

	^ self columnedListView asElementDo: aBlock
]

{ #category : #accessing }
GtPhlowTableView >> at: rowNumber [

	^ self rowAccessorBlock value: rowNumber
]

{ #category : #accessing }
GtPhlowTableView >> cellAccessorBlock [
	^ cellAccessorBlock
]

{ #category : #accessing }
GtPhlowTableView >> cellAccessorBlock: anObject [
	cellAccessorBlock := anObject
]

{ #category : #accessing }
GtPhlowTableView >> columnCountBlock [
	^ columnCountBlock
]

{ #category : #accessing }
GtPhlowTableView >> columnCountBlock: anObject [
	columnCountBlock := anObject
]

{ #category : #private }
GtPhlowTableView >> columnedListView [
	"Answer a GtPhlowColumnedList configured to display the receiver's dataObject"
	| columnCount view |

	view := GtPhlowColumnedListView new.
	view
		title: self title;
		priority: self priority;
		items: [ self ].

	"The column count may be expensive to calculate, cache it here"
	columnCount := self numberOfColumns.

	1 to: columnCount do: [ :c |
		view
			column: c asString item: [ :each |
						(self cellAccessorBlock value: each value: c)
							ifNil: [ '' ]
							ifNotNil: [ :v | v asString ] ] ].

	^ view
]

{ #category : #accessing }
GtPhlowTableView >> dataObject [
	^ itemsBuilder value
]

{ #category : #configuration }
GtPhlowTableView >> forArray2D [

	rowCountBlock := [ self dataObject numberOfRows ].
	columnCountBlock := [ self dataObject numberOfColumns ].
	rowAccessorBlock := [ :rowNum | self dataObject atRow: rowNum ].
	cellAccessorBlock := [ :row :index | row at: index ].
]

{ #category : #configuration }
GtPhlowTableView >> forCollectionOfCollection [

	rowCountBlock := [ self dataObject size ].
	columnCountBlock := [ (self dataObject collect: #size) max ].
	rowAccessorBlock := [ :rowNum | self dataObject at: rowNum ].
	cellAccessorBlock := [ :row :index | 
		index > row size
			ifTrue: [ '' ]
			ifFalse: [ row at: index ] ].
]

{ #category : #testing }
GtPhlowTableView >> ifNotEmpty: aBlock [

	self numberOfRows > 0
		ifTrue: [ aBlock cull: self ]
		ifFalse: [ self ]
]

{ #category : #accessing }
GtPhlowTableView >> items: aValuable [

	itemsBuilder := aValuable 
]

{ #category : #accessing }
GtPhlowTableView >> numberOfColumns [ 

	^ self columnCountBlock value.
]

{ #category : #accessing }
GtPhlowTableView >> numberOfRows [ 

	^ self rowCountBlock value.
]

{ #category : #accessing }
GtPhlowTableView >> rowAccessorBlock [
	^ rowAccessorBlock
]

{ #category : #accessing }
GtPhlowTableView >> rowAccessorBlock: anObject [
	rowAccessorBlock := anObject
]

{ #category : #accessing }
GtPhlowTableView >> rowCountBlock [
	^ rowCountBlock
]

{ #category : #accessing }
GtPhlowTableView >> rowCountBlock: anObject [
	rowCountBlock := anObject
]

{ #category : #accessing }
GtPhlowTableView >> size [

	^ self numberOfRows
]
