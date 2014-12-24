
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@page import="com.hx.framework.common.Constants"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="com.hx.framework.sdk.OrganHelper"%>
<%
UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);
String mail = user.getPersonAccount().getAccountId();
mail +="@sp.sasac.gov.cn";

Data data=(Data)request.getAttribute("DATA");
String mobiles=data.getString("MOBILE");
String[] mArr=null;
if(mobiles!=null && !mobiles.equals("")){
	mArr=mobiles.split(",");
}
String title = "修改个人信息";
String basic = "基本信息";
String bt_save = "保存";
String bt_close = "关闭";
String alert1 = "个人资料更新成功";
boolean isEn = false;
if(user.getCurOrgan()!=null){							
	if(user.getCurOrgan().getOrgType()==9) {
		title = "Personal Information";	
		basic = "Personal Informations";
		bt_save="Save";
		bt_close="Close";
		alert1="Save successfully";
		isEn = true;
	}else{
		
	}
}
%>
<BZ:html>
<BZ:head>
<base target="_self"></base>
<title><%=title %></title>
<BZ:script isEdit="true" isDate="true" />
<style>
input{
	width:90%;
	border: 1px solid #6699FF;
}
</style>
<script>
function _addRow(){

	var mynewrow=mtable.insertRow();
		col1=mynewrow.insertCell(0);
		col1.style.paddingLeft="0px";
		col2=mynewrow.insertCell(1);

		col1.innerHTML="<input align=lift type=text class=inputText  name=mInput name=mInputformTitle='移动电话'  restriction='mobile' onkeyup='_check_one(this);'></input>";
		col2.innerHTML="<img align=lift onclick='_delRow(this)' src=<BZ:resourcePath />/images/delete.png></img>";
}
function _delRow(obj){
	var tr=obj.parentNode.parentNode;
	var tbl=tr.parentNode;
	tbl.removeChild(tr);
}
function tijiao()
{
	document.srcForm.action="<BZ:url/>/person/Person!selfModify.action";
	if(_check(document.srcForm)){
		document.srcForm.submit();
		alert('<%=alert1%>');
		window.close();
	}

}
// 删除数组中重复数据
	function removeDuplElem(arr){
	var array=new Array();
	for(var k=0;k<arr.length;k++){
		array.push(arr[k].value.trim());
	}
	 for(var i=0; i<array.length; i++){
		 for(var j=i+1; j<array.length;j++){
			if(array[i]==array[j]){
						array = removeElement(j,array);//删除指定下标的元素
						i=-1;
						break;
				 }
			 }
	}
	return array;
}
	//删除数组 用到的函数
	function removeElement(index,array){
	 if(index>=0 && index<array.length){
			for(var i=index; i<array.length; i++){
				array[i] = array[i+1];
			}
			array.length = array.length-1;
		}
		return array;
	}
</script>
</BZ:head>
<BZ:body codeNames="10001;10002;10008;10009;SEX;SECRET_LEVEL" property="DATA">
<BZ:form name="srcForm" method="post" target="smz">
<iframe name="smz"  width="0"   height="0"  frameborder="0"   style="display:none">
		</iframe>
<div class="kuangjia">
<!-- 人员所属组织机构 -->
<!-- 人员编号,由前置Action传递 -->
<BZ:input field="PERSON_ID" prefix="Person_" type="hidden" />
<div class="" desc="编辑区域">
	<div class="">
		<div class="ui-state-default bz-edit-title" desc="title">
			<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
			<div><%=basic %></div>
		</div>
		<div class="bz-edit-data-content clearfix" desc="内容体">
		<table class="bz-edit-data-table" border="0" style="width: 100%">
			<tr>
			
			<td width="10%" style="text-align: center">部&nbsp;&nbsp;&nbsp;&nbsp;门<br>Unit</td>
			<td colspan="3">
			<%if(isEn) {%>
			<%=user.getCurOrgan().getEnName()%>
			<%}else{ %>
			<%=user.getCurOrgan().getCName()%>
			<%} %>
			</td>
			</tr>
			
			<tr>
			<td width="10%" style="text-align: center">姓&nbsp;&nbsp;&nbsp;&nbsp;名<br>Name</td>
			<td width="20%">
			<%if(isEn) {%>
			<BZ:input field="ENNAME" prefix="Person_" notnull="Name cannot be empty" formTitle="Name" type="String" className="txt_new" defaultValue="" />
			<%}else{ %>
			<BZ:input field="CNAME" prefix="Person_" notnull="必须输入" formTitle="中文姓名" type="String" className="txt_new" defaultValue="" />
			<%} %>
			</td>
			<td width="10%" style="text-align: center">办公电话<br>Office Tel</td>
			<td width="20%"><BZ:input field="OFFICE_TEL" prefix="Person_" restriction="telephone" formTitle="" type="String" className="txt_new" defaultValue=""/></td>
			<!-- <td width="10%">办公室房间号</td>
			<td width="20%"><BZ:input field="ROOM_NUM" prefix="Person_" type="String" defaultValue="" className="txt_new"/></td>
			<td width="5%"></td>-->
			</tr>
			
			<tr>
			
			<td width="10%" style="text-align: center">办公传真<br>FAX</td>
			<td width="20%"><BZ:input field="OFFICE_FAX" prefix="Person_" restriction="telephone" formTitle="" type="String" className="txt_new" defaultValue="" /></td>
			<td width="10%" style="text-align: center">电子邮件<br>EMAIL</td>
			<td width="20%"><BZ:input field="EMAIL" prefix="Person_" restriction="email" formTitle="" type="String" defaultValue="<%=mail%>" className="txt_new"/></td>
			</tr>
		
		</table>
		</div>
	</div>
</div>
<br> 
<!-- 编辑区域end -->
<table border="0" cellpadding="0" cellspacing="0"  align="center" width="20%">
<tr>
<td>
<input type="button" value="<%=bt_save %>" class="button_add" onclick="tijiao()"/>
</td>
<td>
<input type="button" value="<%=bt_close %>" class="button_back" onclick="window.close()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>