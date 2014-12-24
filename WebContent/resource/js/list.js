var list = {
	/**
	 * �б����������
	 */
	"listNames" : [],
	"adsorb" : "false",
	/**
	 * ��ֻ��һ��ѡ����Ŀʱ����ס��һ��ѡ�������
	 */
	"oldSel" : {},
	/*
	 * ѡ��ʼ֮ǰ�Ĳ�������ҪΪ��ʵ��ѡ��һ�����ٴ�ѡ����ȡ���Ĺ���
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
	 * ���ص���checkbox�Ĳ���
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
	 * ��������checkbox�Ĳ���
	 */
	selClick : function(obj) {
		var o = $(obj);
		if (!o.prop("checked")) {
			o.parents("tr").addClass("ui-selected");
			list.selectableStart = true;
		} else {
			o.parents("tr").removeClass("ui-selected");
		}
		list.checkSelect(o.parents(".dataTable"));
	},
	/**
	 * �б�ѡ��Ĳ���
	 */
	selectList : function(obj) {
		var selObjs = $(obj).children(".ui-selectee");
		//Ѱ��
		var len = selObjs.length;
		$.each(selObjs, function(i, val) {
			var checkbox = $(val).find(".ace");
			// ����ѡ�е�ȡ��ѡ��
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
	 * ����Ƿ�ȫ��ѡ�У��������б�ȫѡ/ȡ����checkbox
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
	 * ȫѡ/ȡ�� ��checkbox����
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
	 *  �����б�������ض���б�
	 * @param listIds �����б��ID����
	 * @param adsorb ������both��ȫ����header����ͷ��footer��ҳ��
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
		this.listNames = listNames;
		for ( var i in listNames) {
			var compositor = $(listNames[i]).parents("form").find("input[name=compositor]");
			var ordertype = $(listNames[i]).parents("form").find("input[name=ordertype]");
			if($(compositor).length>0 && $(ordertype).length>0){
				$(listNames[i] + " thead tr th div[id="+$(compositor).val()+"]").parent().attr("class","sorting_"+$(ordertype).val().toLowerCase());
				$(listNames[i] + " tr:odd").addClass("odd");
				var compositor = $(listNames[i]).parents("form").find("input[name=compositor]");
				var ordertype = $(listNames[i]).parents("form").find("input[name=ordertype]");
				var compostr = $(compositor).val();
				var orderstr = $(ordertype).val();
				if($.trim(compostr)!="" && $.trim(orderstr)!="") {
					var div_obj2 = $("#"+compostr);
					$(div_obj2).addClass("sorting_"+orderstr.toLowerCase());
				}
				$(listNames[i] + " thead tr th").click(function(){
					var div_obj = $(this).find("div");
					if(!div_obj.hasClass("sorting_disabled")) {
						$(this).removeClass("sorting_"+orderstr.toLowerCase());
						if($(div_obj).attr("id")==compostr) {
							if(orderstr == "") {
								orderstr = "asc";
							}else if(orderstr.toLowerCase() == "asc") {
								orderstr = "desc";
							}else if(orderstr.toLowerCase() == "desc") {
								orderstr = "asc";
							}
						}else {
							orderstr = "asc";
						}
						$(ordertype).val(orderstr);
						$(compositor).val($(div_obj).attr("id"));
						$(this).addClass("sorting_"+orderstr.toLowerCase());
						$(listNames[i]).parents("form").submit();
					}
				});
			}
			// ����һ���б����غ����ѡ��Ĺ��ܣ�����û�е��ѡ��
			/*
			$(listNames[i]+" tbody").selectable({
				filter : "tr",
				cancel: "a, th, input[type=text], select",
				start : function() {
					list.startList(this);
					list.selectableStart = true;
				},
				stop : function() {
					list.selectList(this);
					list.selectableStart = false;
				}
			});
			*/
			//���غ������קѡ����checkboxѡ����ϵĹ���
			
			$(listNames[i]+" tbody tr").click(function (e){
				var target = $(e.target);
				if(target.closest("a").length==0){
					var checkbox = $(this).find(".ace");
					list.selClick(checkbox);
				}
			});
			list.loadListCHeckbox(listNames[i]);
		}
	},
	"lastHeader" : null,
	"lastFooter" : null,
	/**
	 * �Զ�����ҳ������
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
 * �����б��ѡ�����������
 */
$(document).ready(function() {
	list._autoLoadList();
	isEmptyData();
});

/**
*�б��Ƿ������ݣ����û���б���ʾEmpty Data!����
*add by mayun 2014-8-22
*/
function isEmptyData(){
	if($(".emptyData").length==0){
		$("<div style=\" text-align:center;height:50px;line-height:50px;font-size:15px \"> Empty Data!</div>").appendTo($(".table-responsive"));
	};
}

function _goto(form,page,pageNum,iscount){
	if (iscount=="true"){
		if (parseInt(page)>parseInt(pageNum)){
			alert("ҳ�볬�����ҳ����");
			return;
		}
	}

	if (parseInt(page)<1){
		alert("ҳ�治��С��1��");
		return;
	}

	if (!/^\+?\d+$/g.test(page)){
		alert("ҳ����������������");
		return;
	}
	form.page.value = page;
	form.submit();
}


/** 
* �����ļ� 
* @param form �� 
* @param type ���� 
*/ 
function _exportFile(form,type){ 
document.getElementById("exportType").value=type; 
var oldTarget=form.target; 
var oldAction = form.action; 
form.target="_self"; 
form.action=path+"export/export"; 
var total = document.getElementById("page_dataTotal").value; 
if (total==0 || total>60000){ 
alert("��Ҫ�������������ܴ������ĵȴ�..."); 
} 
form.submit(); 
form.target=oldTarget; 
form.action=oldAction; 
}