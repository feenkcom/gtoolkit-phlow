Class {
	#name : #GtPhlowTreeNodeConditionalExpander,
	#superclass : #GtPhlowTreeNodeExpander,
	#instVars : [
		'condition'
	],
	#category : #'GToolkit-Phlow-Support - Tree Expansion'
}

{ #category : #'api - accessing' }
GtPhlowTreeNodeConditionalExpander >> condition [
	^ condition
]

{ #category : #'api - accessing' }
GtPhlowTreeNodeConditionalExpander >> condition: aBlock [
	"The block receives [ :aTreeNode :aNodeValue | ... ]"
	condition := aBlock
]

{ #category : #'api - actions' }
GtPhlowTreeNodeConditionalExpander >> expandTree: aBrTree [
	aBrTree expandSuchThat: [ :aTreeNode | self condition cull: aTreeNode cull: aTreeNode value ]
]

{ #category : #views }
GtPhlowTreeNodeConditionalExpander >> gtViewConditionSourceFor: aView [
	<gtView>
	^ aView forward
		title: 'Condition';
		priority: 10;
		object: [ condition ];
		view: #gtSourceCodeFor:
]
