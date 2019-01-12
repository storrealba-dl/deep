import * as back from "./views/back";
import * as bodyLayout from "./views/bodylayout";
import * as collapse from "./views/collapseall";
import * as columns from "./views/columns";
import * as expand from "./views/expandall";
import * as files from "./views/files";
import * as forward from "./views/forward";
import * as mainLayout from "./views/mainlayout";
import * as menu from "./views/menu";
import * as modes from "./views/modes";
import * as modeViews from "./views/modeviews";
import * as path from "./views/path";
import * as search from "./views/search";
import * as sidePanel from "./views/panel";
import * as table from "./views/table";
import * as treeLayout from "./views/treelayout";
import * as treeToolbar from "./views/treetoolbar";
import * as toggle from "./views/toggle";
import * as toolbar from "./views/toolbar";
import * as tree from "./views/tree";
import * as up from "./views/up";

export function init(view, config){
	view.structure = {
		"mainLayout": mainLayout.init(view),
		"toolbar": toolbar.init(view),
		"menu": menu.init(view),
		"back": back.init(view),
		"forward": forward.init(view),
		"up": up.init(view),
		"path": path.init(view),
		"search": search.init(view),
		"bodyLayout": bodyLayout.init(view),
		"treeLayout": treeLayout.init(view),
		"sidePanel": sidePanel.init(view),
		"treeToolbar": treeToolbar.init(view),
		"showTree": toggle.init(view),
		"hideTree": toggle.init(view),
		"expandAll": expand.init(view),
		"collapseAll": collapse.init(view),
		"tree": tree.init(view),
		"modeViews":{
			config: function(settings){
				return modeViews.init(view,settings);
			}
		},
		"modes":{
			config:function(settings){
				return modes.init(view,settings);
			}
		},
		"files": {
			config: files.init(view)
		},

		"table": {
			config: table.init(view)
		},
		"columns": {
			config: columns.init(view)
		}
	};

	changeStructure(view, config);
}


export function getViews(view, struct, config){
	var cells, found, i, id,
		arrName = "",
		arrs = ["rows","cols","elements","cells","columns","options","data"];

	for(i =0; i< arrs.length;i++){
		if(struct[arrs[i]]){
			arrName = arrs[i];
			cells = struct[arrName];
		}
	}
	if(cells){
		if(typeof(cells) == "string"){
			if(view.structure[cells]){
				struct[arrName] = getCellConfig(view, view.structure[cells],config);
				cells = struct[arrName];
			}
		}

		for(i=0; i< cells.length;i++){
			found = null;
			if(typeof(cells[i]) == "string"){
				found = id = cells[i];
				if(view.structure[id]){
					cells[i] = getCellConfig(view, webix.extend({},view.structure[id]),config);
					cells[i].id = id;
				}
				else
					cells[i] = { };
			}
			getViews(view, cells[i], config);
			if (found){
				if(config.on && config.on.onViewInit){
					config.on.onViewInit.apply(this,[found,cells[i]]);
				}
				webix.callEvent("onViewInit",[found,cells[i],this]);
			}
		}
	}
}

export function getCellConfig(view, defConfig, config){
	var cellConfig = defConfig.config||defConfig;
	return (typeof(cellConfig)=="function"?cellConfig.call(view,config):webix.copy(cellConfig));
}

function isSVG(){
	return (typeof SVGRect != "undefined");
}

export function getUI(view, config){
	var layoutConf = view.structure.mainLayout;
	var structure = webix.extend({},layoutConf.config || layoutConf);
	getViews(view, structure, config);

	if(config.on && config.on.onViewInit){
		config.on.onViewInit.apply(view,[config.id||"mainLayout",structure]);
	}
	webix.callEvent("onViewInit",[config.id||"mainLayout",structure,view]);
	if(!isSVG())
		config.css = config.css?config.css+" webix_nosvg":"webix_nosvg";
	return structure;
}

function changeStructure(view, config){
	var newView, vName,
		newViews = config.structure;

	if(newViews){
		for(vName in newViews){
			if(newViews.hasOwnProperty(vName)){
				newView = webix.copy(newViews[vName]);
				if(view.structure[vName] && view.structure[vName].config){
					view.structure[vName].config = newView.config||newView;
				}
				else{
					view.structure[vName] = newView.config||newView;
				}
			}
		}
	}
}