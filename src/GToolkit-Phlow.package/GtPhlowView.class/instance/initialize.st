initialization
initialize
	super initialize.
	actionStencils := OrderedCollection new.
	priority := 10.
	self actionStencil: [ 
		| button |
		button := BrButton new.
		button 
				look: BrMaterialToggleIconifiedLook;
				icon: GLMUIThemeExtraIcons glamorousBrowse asElement ;
				action: [ button fireEvent: (GtPhlowObjectToSpawn new 
					object: self definingMethod;
					sourceElement: button) ] ]