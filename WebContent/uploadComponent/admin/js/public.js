
//全选
function selAll() {
	for (i = 0; i < document.form2.id.length; i++) {
		if (!document.form2.id[i].checked) {
			document.form2.id[i].checked = true;
		}
	}
}

// 取消全选
function noSelAll() {
	for (i = 0; i < document.form2.id.length; i++) {
		if (document.form2.id[i].checked) {
			document.form2.id[i].checked = false;
		}
	}
}

function deleteBatch(root, requestPrefix){
	if(confirm("确定全部删除吗?")){
		var code = "";
		var codeChecked = new Array();
		var j = 0;
		for (i = 0; i < document.form2.id.length; i++) {
			if (document.form2.id[i].checked) {
				codeChecked[j] = document.form2.id[i].value;
				j++;
			}
		}
		alert(document.form2.id.length);
		if(codeChecked != null && codeChecked.length > 0){
			for (i = 0; i < codeChecked.length; i++) {
				code = code + codeChecked[i] + "!";
			}
			self.location = root+"/att_type/AttType."+requestPrefix+"?param=delBatchAttType&code="+encodeURI(encodeURI(code));
		}else{
			alert("请选择要删除的附件类型!");
		}
	}
	window.location.reload();
}


// 保存附件类型对话框
function add_att_type_dialog(root,requestPrefix) {
	window.showModalDialog(root+"/uploadComponent/admin/att_type/add_att_type.jsp?time="+new Date().valueOf(), this, "dialogWidth=800px;dialogHeight=350px;scroll=no");
	//window.showModalDialog(root+"/att_type/AttType.action?param=addAttType&time="+new Date().valueOf(), this, "dialogWidth=800px;dialogHeight=350px;scroll=no");
	window.location.reload();
}

// 数据源管理对话框
function opra_datasource_dialog(root,requestPrefix) {
	window.showModalDialog(root+"/att_type/AttType."+requestPrefix+"?param=operaDatasource&time="+new Date().valueOf(), this, "dialogWidth=800px;dialogHeight=250px;scroll=no");
	window.location.reload();
}

// 磁盘管理对话框
function opra_disk_path_dialog(root,requestPrefix) {
	window.showModalDialog(root+"/att_type/AttType."+requestPrefix+"?param=operaDiskPath&time="+new Date().valueOf(), this, "dialogWidth=800px;dialogHeight=120px;scroll=no");
	window.location.reload();
}

// 修改附件类型对话框
function mod_att_type_dialog(root, code, requestPrefix) {
	window.showModalDialog(root+"/att_type/AttType."+requestPrefix+"?param=modAttType&time="+new Date().valueOf()+"&code="+encodeURI(encodeURI(code)), this, "dialogWidth=800px;dialogHeight=350px;scroll=no");
	window.location.reload();
}

// 删除指定的附件类型
function del_att_type(root,code,requestPrefix) {
	if (confirm("确定删除吗?")) {
		self.location = root+"/att_type/AttType."+requestPrefix+"?param=delAttType&code="+encodeURI(encodeURI(code));
		return true;
	}
	return false;
	window.location.reload();
}

// 关闭窗口
function closeWindow(){
	window.close();
}

//显示添加附件分类的分类周期输入域
function showSortWeek(){
	document.getElementById("hiddenWeek").style.display = "block";
}

//隐藏添加附件分类的分类周期输入域
function hiddenSortWeek(){
	document.getElementById("hiddenWeek").style.display = "none";
}

//提交数据源管理表单
function opera_datasource_submit(root,requestPrefix){
	document.getElementById("opera_datasource_form").action = root+"/att_type/AttType."+requestPrefix+"?param=doOperaDatasource&time="+new Date().valueOf();
	document.getElementById("opera_datasource_form").submit();
}

//提交磁盘路径管理表单
function diskPathFormSubmit(root,requestPrefix){
	document.getElementById("diskPathForm").action = root+"/att_type/AttType."+requestPrefix+"?param=doOperaDiskPath&time="+new Date().valueOf();
	document.getElementById("diskPathForm").submit();
}

//提交附件类型保存表单
function addAttTypeFormSubmit(root,requestPrefix){
	document.getElementById("addAttTypeForm").action = root+"/att_type/AttType."+requestPrefix+"?param=addAttType&time="+new Date().valueOf();
	document.getElementById("addAttTypeForm").submit();
}

//修改附件类型提交表单
function modAttTypeFormSubmit(root,requestPrefix){
	document.getElementById("modAttTypeForm").action = root+"/att_type/AttType."+requestPrefix+"?param=doModAttType&time="+new Date().valueOf();
	document.getElementById("modAttTypeForm").submit();
}

//重建表
function rebuildTable(root,requestPrefix){
	if (confirm("确定重建吗?")) {
		window.location.href = root+"/att_type/AttType."+requestPrefix+"?param=rebuildTables&time="+new Date().valueOf();
	}
	window.location.reload();
}

//Flash下载
function flashDownload(root,requestPrefix){
	window.location.href = root+"/uploadComponent/admin/flashPlugin/flash_player_active_x.exe?"+new Date().valueOf();
}