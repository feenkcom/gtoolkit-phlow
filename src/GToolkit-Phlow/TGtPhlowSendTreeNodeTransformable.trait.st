"
I extend ${class:TGtPhlowSendTransformable}$.
I am used by ${class:GtPhlowView}$ tree view subclasses, see ${class:TGtPhlowSendTreeNodeTransformable|label=my users|show=#gtUsersFor:|height=100|expanded}$:
Since the tree views provide ${class:BrTreeNode}$ instances instead of displayed objects, I modify ${method:TGtPhlowSendTreeNodeTransformable>>#transformation:|label=#selector}$ to ensure that ${class:GtPhlowSendTreeNodeTransformation}$ decorate other ${class:GtPhlowSendTransformation}$ instances. By doing so, the other transformation instances always obtain displayed objects instead of tree nodes.
!! Send Example
In the following example, when the list items are selected (double click), ${example:GtPhlowTreeViewExamples>>#sendNumberAddition|label}$ is added to selected items that are displayed in the next pane: ${example:GtPhlowTreeViewExamples>>#sendObject_Block|codeExpanded=false|previewExpanded=true}$
!! Send Tool Example
In the following example, when the list items are selected (double click), a ${class:GtPhlowTool|label=Phlow tool}$ is used to display selected items in the next pane: ${example:GtPhlowTreeViewExamples>>#sendTool|codeExpanded=false|previewExpanded=true}$
In this case, it is a  ${class:BlElement}$ widget that displays selected numbers in the middle. More elaborate and dedicated Phlow tools can be used, see ${class:GtPhlowTool|expanded|show=#gtSubclassesFor:}$ subclasses:
"
Trait {
	#name : 'TGtPhlowSendTreeNodeTransformable',
	#traits : 'TGtPhlowSendTransformable',
	#classTraits : 'TGtPhlowSendTransformable classTrait',
	#category : 'GToolkit-Phlow-Support - Transformation'
}

{ #category : 'accessing' }
TGtPhlowSendTreeNodeTransformable >> transformation: aGtPhlowSendTransformation [
	self assertTransformation: aGtPhlowSendTransformation.
	transformation := aGtPhlowSendTransformation asPhlowSendTransformation asTreeNodeTransformation.
]
