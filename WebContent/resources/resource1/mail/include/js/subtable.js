    //注意，字段中不能有|这个字符
	//不选中是的样式
	var trClass = "list_text";
	//选中后的样式
	var trClassSel = "list_text_sel";
	//是否是单选
	var oneSel = true;
	var delValues = new Array();
function _addTR(tableId,trId){
	if (tableId==null){
		tableId = "add_table";
	}
	if (trId==null){
		trId = "appendTR";
	}
	var appTr = document.getElementById(trId);
	var addTb = document.getElementById(tableId);
	var o = document.createElement("TR");
	var tds = appTr.getElementsByTagName("TD");
	var _tds = appTr.cells;
	var _tr = addTb.insertRow();
	_tr.className = trClass;
	_tr.onclick = function(){
		if(this.className == trClass){
			_selTR(this,oneSel,trClassSel,trClass);
		}else{
			this.className = trClass;
		}
	}
	for (var i=0;i<tds.length;i++){
		var _td = _tr.insertCell();
		if (tds[i].className!=null && tds[i].className != ""){
			_td.className = tds[i].className;
		}
		if (tds[i].align!=null && tds[i].align != ""){
			_td.align = tds[i].align;
		}
		if(tds[i].colSpan!=null && tds[i].colSpan!=""){
		    _td.colSpan = tds[i].colSpan;
		}
		
		 //alert(_td.bgColor);
		if(tds[i].bgColor!=null && tds[i].bgColor!=""){
		    _td.bgColor = tds[i].bgColor;
		   
		}
		
		if(tds[i].borderColor!=null && tds[i].borderColor!=""){
		    _td.borderColor = tds[i].borderColor;
		}
		if(tds[i].style.cssText!=null && tds[i].style.cssText!=""){
		    _td.style.cssText = tds[i].style.cssText;
		}
		_td.innerHTML=tds[i].innerHTML;
	}
	try{
		_verifyLoad();
	}catch(e){
	
	}
}
function _removeTR(tableId,tdObj){
	if (tableId==null){
		tableId = "add_table";
	}
	var rowIndex = tdObj.parentNode.parentNode.rowIndex;
	var addTb = document.getElementById(tableId);
	
	try{
		addTb.deleteRow(rowIndex);
	}catch(e){
		
	}
}
function _removeTR11(tableId){
	if (tableId==null){
		tableId = "add_table";
	}
	if(_noneSelect(tableId)){
		if(confirm('真的要删除这行吗？')){
			var addTb = document.getElementById(tableId);
			var trs = document.getElementsByTagName("tr");
			var sel = new Array();
			var l = trs.length;
			if (trs!=null && trs.length>0){
				for(var i=(l-1);i>=0;i--){
					if (trs[i].className==trClassSel){
						sel[sel.length] = trs[i].rowIndex;
						delValues[delValues.length] = trs[i].getAttribute("removeId");
					}
				}
			}
			for (var i=0;i<sel.length;i++){
				try{
					addTb.deleteRow(sel[i]);
				}catch(e){
		
				}
			}
		}
	}else {
		try{
			Ext.Msg.alert("提示",'请选择需要删除的记录！');
		}catch(e){
			alert('请选择需要删除的记录！');
		}
		
	}
}
function _loadSub(){
	//var trs = document.getElementsByTagName("tr");
	//if (trs!=null && trs.length>0){
	//	for(var i=0;i<trs.length;i++){
			//var className = trs[i].calssName;
			//trs[i].onclick = function(){
			//	if(this.className == trClass){
			//		_selTR(this,oneSel,trClassSel,trClass);
			//	}else if(this.className == trClassSel){
			//		this.className = trClass;
			//	}
		//	}
		//}
	//}
}
/**
 *取消所有选中，并选中指定的tr
 *@param o 要选中的对象
 *@param oneSel 是否为单选，单选为true
 *@param trClassSel 选中的CSS样式
 *@param trClass 未选中的CSS样式
 */
function _selTR(o,oneSel,trClassSel,trClass){
	if (oneSel){
		var trs = document.getElementsByTagName("tr");
		for(var i=0;i<trs.length;i++){
			var className = trs[i].calssName;
			if(trs[i].className == trClassSel){
				trs[i].className = trClass;
			}
		}
	}
	o.className = trClassSel;
}


function _subForm(tableIds){
	if (tableIds==null){
		tableIds = new Array();
		tableIds[0]="add_table";
	}
	var canSave = "";
	for(var k=0;k<tableIds.length;k++){
		var addTb = document.getElementById(tableIds[k]);
		var trs = addTb.getElementsByTagName("tr");
		for(var i=0,m=0;i<trs.length;i++){
			var hiddenTR = trs[i].getAttribute("nosubmit");
			if (hiddenTR==null){
				hiddenTR="false";
			}
			if(trs[i].id != "appendTR" || hiddenTR=="false"){
				var tds = trs[i].cells;
				for (var j=0;j<tds.length;j++){
					var els = tds[j].getElementsByTagName("input");
					canSave = canSave + _setName(els,m)+",";
					els = tds[j].getElementsByTagName("select");
					canSave = canSave + _setName(els,m)+",";
					els = tds[j].getElementsByTagName("textarea");
					canSave = canSave +_setName(els,m)+",";
				}
				m++;
			}
		}
	}
	if(canSave.indexOf("T")!=-1){
		return true;		
	}else{
		//alert("请您填写登记表数据！");
		return false;
	}
	
	
}
function _setName(els,m){
	if (els!=null){
		for(var i=0;i<els.length;i++){
			var name = els[i].name;
			if (name!=null && name.length>2){
				var l = name.lastIndexOf("|");
				if (l>0){
					name = name.substring(0,l);
				}
			}
			name = name + "|" + m; 
			var type = els[i].type;
			var value = els[i].value;
			var className = els[i].className;
			className = "123";
			var tagName = els[i].tagName;
			var str = "";
			if (tagName=="INPUT"){
				if (type=="radio"){
					var s = "";
					if (els[i].checked){
						s = " checked";
					}
					str="<input type=\"radio\" name=\"" + name + "\" value=\"" + value + "\" class=\"" + className +"\"" + s + ">";
				}else if (type=="check"){
					var s = "";
					if (els[i].checked){
						s = " checked";
					}
					str="<input type=\"check\" name=\"" + name + "\" value=\"" + value + "\" class=\"" + className +"\"" + s + ">";
				}else{
					str="<input type=\"" + type + "\" name=\"" + name + "\" value=\"" + value + "\" class=\"" + className +"\">";
				}
			}else if (tagName=="SELECT"){
			//暂时不支持多选的select列表
				str="<input type=\"text\" name=\"" + name + "\" value=\"" + value + "\" class=\"" + className +"\">";
			}else if (tagName=="TEXTAREA"){
				str="<textarea type=\"text\" name=\"" + name + "\" class=\"" + className +"\">" + value + "</textarea>";
			}
			els[i].outerHTML = str;
		}
		if(els.length>0){
			return "T";
		}else{
			return "F";
		}
		
	}
}


function _noneSelect(tableId){

	var addTb = document.getElementById(tableId);
	var trs = addTb.getElementsByTagName("tr");
	for(var i=0;i<trs.length;i++){
			var className = trs[i].calssName;
			if(trs[i].className == trClassSel){
				return true;
			}
	}
	return false;
}