var list = {
	/**
	 * 列表的名字数组
	 */
	"listNames" : [],
	"adsorb" : "false",
	/**
	 * 当只有一个选择项目时，记住上一个选择的内容
	 */
	"oldSel" : {},
	/*
	 * 选择开始之前的操作，主要为了实现选择一个后，再次选择是取消的功能
	 */
	startList : function(obj) {
		var selObjs = $(obj).find(".ui-selected");
		if (selObjs.length == 1) {
			this.oldSel[$(obj).parents(".dataTable").attr("id")] = selObjs[0];
		} else {
			this.oldSel[$(obj).parents(".dataTable").attr("id")] = null;
		}
	},
	/**
	 * 加载单击checkbox的操作
	 */
	loadListCHeckbox : function(selectable) {
		var selObjs = $(selectable).find("tbody tr");
		$.each(selObjs, function(i, val) {
			var checkbox = $(val).find(".ace");
			checkbox.click(function() {
				list.selClick(this);
			});
		});
		var sel = $(selectable).find("thead .ace");
		sel.click(function() {
			list.changeSelect(this);
		});
	},
	/**
	 * 单击数据checkbox的操作
	 */
	selClick : function(obj) {
		var o = $(obj);
		if (o.prop("checked")) {
			o.parents("tr").addClass("ui-selected");
			list.selectableStart = true;
		} else {
			o.parents("tr").removeClass("ui-selected");
		}
		list.checkSelect(o.parents(".dataTable"));
	},
	/**
	 * 列表选择的操作
	 */
	selectList : function(obj) {
		var selObjs = $(obj).children(".ui-selectee");
		//寻找
		var len = selObjs.length;
		$.each(selObjs, function(i, val) {
			var checkbox = $(val).find(".ace");
			// 单击选中的取消选中
			// alert(len);
			if ($(val).hasClass("ui-selected")) {
				checkbox.prop("checked", true);
			} else {
				checkbox.prop("checked", false);
			}
		});
		var selObjs = $(obj).children(".ui-selected");
		if (selObjs.length == 1) {
			if (this.oldSel[$(obj).parents(".dataTable").attr("id")] == selObjs[0]) {
				var selObj = $(selObjs[0]);
				var checkbox = selObj.find(".ace");
				checkbox.prop("checked", false);
				selObj.removeClass("ui-selected");
			}
		}
		list.checkSelect($(obj).parents(".dataTable"));
	},
	/**
	 * 检查是否全部选中，并更新列表全选/取消的checkbox
	 */
	checkSelect : function(obj) {
		var selObjs = obj.find("tbody tr");
		var checked = true;
		$.each(selObjs, function(i, val) {
			var checkbox = $(val).find(".ace");
			if (!checkbox.prop("checked")) {
				checked = false;
			}
		});
		var sel = obj.find("thead .ace");
		if (checked) {
			sel.prop("checked", true);
		} else {
			sel.prop("checked", false);
		}
	},
	/**
	 * 全选/取消 的checkbox操作
	 */
	changeSelect : function(obj) {
		var checked;
		if ($(obj).prop("checked")) {
			checked = true;
		} else {
			checked = false;
		}
		var selObjs = $(obj).parents(".dataTable").find("tbody tr");
		$.each(selObjs, function(i, val) {
			var selobj = $(val);
			var checkbox = selobj.find(".ace");
			if (checked) {
				selobj.addClass("ui-selected");
			} else {
				selobj.removeClass("ui-selected");
			}
			checkbox.prop("checked", checked);
		});
	},
	"th_top" : null,
	"th_bottom" : null,
	"th_adsorb" : false,
	"foot_adsorb" : false,
	"selectableStart" : false,
	/**
	 *  加载列表，允许加载多个列表
	 * @param listIds 所有列表的ID集合
	 * @param adsorb 吸附：both：全部，header：表头；footer：页脚
	 */
	onload : function(listIds, adsorb) {
		var paramType = jQuery.type(listIds);
		var listNames = [];
		if (paramType === "string") {
			if (listIds.indexOf("#") == 0) {
				listNames[0] = listIds;
			} else {
				listNames[0] = "#" + listIds;
			}
		}
		if (paramType === "array") {
			for ( var i in listIds) {
				if (listIds[i].indexOf("#") == 0) {
					listNames[listNames.length] = listIds[i];
				} else {
					listNames[listNames.length] = "#" + listIds[i];
				}
			}
		}
		if (adsorb == null) {
			adsorb = "both";
		}
		this.listNames = listNames;
		this.adsorb = adsorb;
		var loadFooter = "false";
		if (adsorb == "both" || adsorb == "footer") {
			loadFooter = "true";
		}
		for ( var i in listNames) {
			//加载一个列表，加载后才有选择的功能，否则没有点击选择
			$(listNames[i]+" tbody").selectable({
				filter : "tr",
				cancel: "a, th, .ace, input, select",
				start : function() {
					list.startList(this);
					list.selectableStart = true;
				},
				stop : function() {
					list.selectList(this);
					list.selectableStart = false;
				}
			});
			//加载后才有拖拽选择与checkbox选择配合的功能
			list.loadListCHeckbox(listNames[i]);
		}
	},
	"lastHeader" : null,
	"lastFooter" : null,
	/**
	 * 自动加载页面表格功能
	 */
	_autoLoadList : function() {
		var listIds = [];
		var adsorb = "false";
		$.each($(".dataTable"), function(i, val) {
			var oneData = $(val);
			var init = oneData.attr("init");
			if (init == "true") {
				var id = oneData.attr("id");
				if (id != null) {
					listIds[listIds.length] = oneData.attr("id");
					adsorb = oneData.attr("adsorb");
					oneData.data("adsorb", oneData.attr("adsorb"));
				}
			}
		});
		this.onload(listIds, adsorb);
	}
};
/**
 * 加载列表的选择和吸附操作
 */
$(document).ready(function() {
	list._autoLoadList();
	
	//tip提示
	$( "[title]" ).tooltip({
		show: null,
		position: {
			my: "left bottom",
			at: "left top"
		},
		open: function( event, ui ) {
			ui.tooltip.animate({ top: ui.tooltip.position().top - 10 }, "fast" );
		}
	});
});