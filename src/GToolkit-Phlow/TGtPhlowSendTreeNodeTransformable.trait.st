"
I extend {{gtClass:TGtPhlowSendTransformable}}.
I am used by {{gtClass:GtPhlowView}} tree view subclasses, see {{gtClass:TGtPhlowSendTreeNodeTransformable|label=my users|show=#gtUsersFor:|height=100|expanded}}:
Since the tree views provide {{gtClass:BrTreeNode}} instances instead of displayed objects, I modify {{gtMethod:TGtPhlowSendTreeNodeTransformable>>#transformation:|label=#selector}} to ensure that {{gtClass:GtPhlowSendTreeNodeTransformation}} decorate other {{gtClass:GtPhlowSendTransformation}} instances. By doing so, the other transformation instances always obtain displayed objects instead of tree nodes.
## Send Example
In the following example, when the list items are selected (double click), {{gtExample:GtPhlowTreeViewExamples>>#sendNumberAddition|label}} is added to selected items that are displayed in the next pane: {{gtExample:GtPhlowTreeViewExamples>>#sendObject_Block|codeExpanded=false|previewExpanded=true}}
## Send Tool Example
In the following example, when the list items are selected (double click), a {{gtClass:GtPhlowTool|label=Phlow tool}} is used to display selected items in the next pane: {{gtExample:GtPhlowTreeViewExamples>>#sendTool|codeExpanded=false|previewExpanded=true}}
In this case, it is a  {{gtClass:BlElement}} widget that displays selected numbers in the middle. More elaborate and dedicated Phlow tools can be used, see {{gtClass:GtPhlowTool|expanded|show=#gtSubclassesFor:}} subclasses:

"
Trait {
	#name : #TGtPhlowSendTreeNodeTransformable,
	#traits : 'TGtPhlowSendTransformable',
	#classTraits : 'TGtPhlowSendTransformable classTrait',
	#category : #'GToolkit-Phlow-Support - Transformation'
}

{ #category : #accessing }
TGtPhlowSendTreeNodeTransformable >> transformation: aGtPhlowSendTransformation [
	transformation := aGtPhlowSendTransformation asPhlowSendTransformation asTreeNodeTransformation.
]
