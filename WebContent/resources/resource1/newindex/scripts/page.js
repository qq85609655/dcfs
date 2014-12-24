var list = {
	/**
	 * 自动加载页面表格功能
	 */
	_autoLoadList : function() {
		var listIds = [];
		$.each($(".tableGrid"), function(i, val) {
			var oneData = $(val);
			var id = oneData.attr("id");
			if (id != null) {
				listIds[listIds.length] = oneData.attr("id");
			}
		});
		this.onload(listIds);
	},
	onload : function(listIds) {
		if(listIds.length==0) {
			return;
		}
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
		this.listNames = listNames;
		for ( var i in listNames) {
			var compositor = $(listNames[i]).parents("form").find("input[name=compositor]");
			var ordertype = $(listNames[i]).parents("form").find("input[name=ordertype]");
			$(listNames[i] + " thead tr th div[id="+$(compositor).val()+"]").parent().attr("class","sorting_"+$(ordertype).val());
			$(listNames[i] + " tr:odd").addClass("odd");
			$(listNames[i] + " thead tr th:first-child div span").before(
					"<input type='checkbox' style='float: left;display: inline-block;' name='quanxuan' />");
			$(listNames[i] + " tbody tr td:first-child").each(function() {
				var val = $(this).attr("tdvalue");
				$(this).append("<input type='checkbox' style='display: none;' name='xuanze' value='" + val + "' />");
			});
			$(listNames[i] + " tbody tr").hover(function() {
				$(this).addClass("hover");
				var box = $(this).find("td:first-child input[type='checkbox']");
				var span = $(this).find("td:first-child span");
				if ($(box).prop("checked")) {
					$(box).show();
					$(span).hide();
				}else {
					$(box).show();
					$(span).hide();
				}
			}, function() {
				$(this).removeClass("hover");
				var box = $(this).find("td:first-child input[type='checkbox']");
				var span = $(this).find("td:first-child span");
				if ($(box).prop("checked")) {
					$(box).show();
					$(span).hide();
				}else {
					$(box).hide();
					$(span).show();
				}
			});
			$(listNames[i] + " thead tr th").click(function(){
				var div_obj = $(this).find("div");
				if(div_obj.attr("sorttype")!="none") {
					var compositor = $(listNames[i]).parents("form").find("input[name=compositor]");
					var ordertype = $(listNames[i]).parents("form").find("input[name=ordertype]");
					var compostr = $(compositor).val();
					var orderstr = $(ordertype).val();
					$(this).removeClass("sorting_"+orderstr);
					if($(div_obj).attr("id")==compostr) {
						if(orderstr == "") {
							orderstr = "asc";
						}else if(orderstr == "asc") {
							orderstr = "desc";
						}else if(orderstr == "desc") {
							orderstr = "";
						}
					}else {
						orderstr = "asc";
					}
					$(ordertype).val(orderstr);
					$(compositor).val($(div_obj).attr("id"));
					$(this).addClass("sorting_"+orderstr);
					$(listNames[i]).parents("form").submit();
				}
			});

			list.loadListCHeckbox(listNames[i]);
		}
	},
	/**
	 * 加载单击checkbox的操作
	 */
	loadListCHeckbox : function(selectable) {
		var selObjs = $(selectable).find("tbody tr");
		$.each(selObjs, function(i, val) {
			var checkbox = $(val).find("td:first-child input[type='checkbox']");
			$(val).click(function() {
				list.selClick(checkbox);
			});
			checkbox.click(function() {
				list.selClick(this);
			});
		});
		var sel = $(selectable).find("thead tr th:first-child input[type='checkbox']");
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
			o.prop("checked", false);
		} else {
			o.prop("checked", true);
		}
		list.checkSelect(o.parents(".tableGrid"));
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
		var selObjs = $(obj).parents(".tableGrid").find("tbody tr");
		$.each(selObjs, function(i, val) {
			var selobj = $(val);
			var checkbox = selobj.find("td:first-child input[type='checkbox']");
			var span = selobj.find("td:first-child span");
			checkbox.prop("checked", checked);
			if (checked) {
				$(checkbox).show();
				$(span).hide();
			} else {
				$(checkbox).hide();
				$(span).show();
			}
		});
	},
	/**
	 * 检查是否全部选中，并更新列表全选/取消的checkbox
	 */
	checkSelect : function(obj) {
		var selObjs = obj.find("tbody tr");
		var checked = true;
		$.each(selObjs, function(i, val) {
			var checkbox = $(val).find("td:first-child input[type='checkbox']");
			if (!checkbox.prop("checked")) {
				checked = false;
			}
		});
		var sel = obj.find("thead tr th:first-child input[type='checkbox']");
		if (checked) {
			sel.prop("checked", true);
		} else {
			sel.prop("checked", false);
		}
	}
};
$(document).ready(function() {
	list._autoLoadList();
});