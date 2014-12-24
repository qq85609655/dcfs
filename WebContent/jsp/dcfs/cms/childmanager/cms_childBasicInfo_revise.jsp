<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="com.dcfs.cms.childManager.ChildCommonManager"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>

<%
  /**   
 * @Description: 儿童材料基本信息修改
 * @author furx  
 * @date 2014-10-17
 * @version V1.0   
 */
TokenProcessor processor = TokenProcessor.getInstance();
String token = processor.getToken(request);
String path = request.getContextPath();
Data data = (Data)request.getAttribute("data");
String provinceId=data.getString("PROVINCE_ID");
String welfareId=data.getString("WELFARE_ID");
String owelfareCn=data.getString("WELFARE_NAME_CN");
DataList welfareList = (DataList)request.getAttribute("welfareList");
ChildCommonManager manager = new ChildCommonManager();
String listType=(String)request.getAttribute("listType");
%>

<BZ:html>
	<BZ:head>
		<title>儿童材料基本信息修改</title>
        <BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	</BZ:head>	
	
<script type="text/javascript">

var arrayWelfare = new Array();
<%
//初始化福利院数组
Data d = new Data();
for(int i=0;i<welfareList.size();i++){
	d = welfareList.getData(i);
	String orgCode = d.getString("ORG_CODE");
	String provinceCode = manager.getProviceId(orgCode);
	String CNAME = d.getString("CNAME");
	String ENAME = d.getString("ENNAME");	
%>
arrayWelfare[<%=i%>] = new Array("<%=provinceCode%>","<%=orgCode%>","<%=CNAME%>","<%=ENAME%>");
<%}%>
</script>
<script type="text/javascript">
  	//iFrame高度自动调整
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
		initSelectShow();
	});
	//下一步
	function _submit(){
		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		//if(confirm('确认要保存当前填写的数据么?')){
		    if("CMS_AZB_DL_LIST"=="<%=listType%>"||"CMS_AZB_ZCSH_LIST"=="<%=listType%>"||"CMS_AZB_TXSH_LIST"=="<%=listType%>"){
		    	document.getElementById("P_PROVINCE_ID").value = $("#PROVINCE_ID").val();
		    	document.getElementById("P_WELFARE_ID").value = $("#WELFARE_ID").val();
				document.getElementById("P_WELFARE_NAME_CN").value = $("#WELFARE_ID").find("option:selected").text();
				document.getElementById("P_WELFARE_NAME_EN").value = getEnamByOrgCode($("#WELFARE_ID").val());
			 }else if("CMS_FLY_CLBS_LIST"!="<%=listType%>"){
				 document.getElementById("P_WELFARE_ID").value = $("#WELFARE_ID").val();
				 document.getElementById("P_WELFARE_NAME_CN").value = $("#WELFARE_ID").find("option:selected").text();
				 document.getElementById("P_WELFARE_NAME_EN").value = getEnamByOrgCode($("#WELFARE_ID").val());
			}
			document.srcForm.action=path+"/cms/childManager/saveBasicInfo.action";
			document.srcForm.submit();
		/*}else{
			return;
		}*/		
	}

	//取消
	function _cancle(){
		if(confirm('确认要取消当前修改的数据?')){
			var uri="";
		    if("CMS_FLY_CLBS_LIST"=="<%=listType%>"){
				uri="/cms/childManager/findList.action";
			}else if("CMS_ST_DL_LIST"=="<%=listType%>"){
                uri="/cms/childstadd/findList.action";
			}else if("CMS_ST_SHJS_LIST"=="<%=listType%>"){
				uri="/cms/childManager/STAuditList.action";
			}else if("CMS_AZB_DL_LIST"=="<%=listType%>"){
				uri="/cms/childManager/findList.action";
			}else if("CMS_AZB_ZCSH_LIST"=="<%=listType%>"){
				uri="/cms/childManager/azbAuditList.action?CHILD_TYPE=1";
			}else if("CMS_AZB_TXSH_LIST"=="<%=listType%>"){
				uri="/cms/childManager/azbAuditList.action?CHILD_TYPE=2";
			}
			document.srcForm.action=path+uri;
			document.srcForm.submit();
		}else{
			return;
		}
	}

	var selProvince = "<%=provinceId%>";
	
	function _chgProvince(){
		
		if(selProvince != $("#PROVINCE_ID").val()){
			selProvince = $("#PROVINCE_ID").val();
			$("#WELFARE_ID").empty();
			initSelect();			 
		}
	}

	function initSelect(){
		
		for(var i=0;i<arrayWelfare.length;i++){
			if(arrayWelfare[i][0]==selProvince){	
			var strOption = "<option value='"+arrayWelfare[i][1]+"' ename='"+arrayWelfare[i][3]+"'>"+ arrayWelfare[i][2]+"</option>";
			$("#WELFARE_ID").append(strOption);  //为Select追加一个Option(下拉项)
			if('<%=welfareId%>'==arrayWelfare[i][1]){
				document.getElementById("WELFARE_ID").value ='<%=welfareId%>';
			}
			}
		}
		
	}
   function initSelectShow(){
	   if("CMS_FLY_CLBS_LIST"!="<%=listType%>"){
		   initSelect();
	   }
   }
	function getEnamByOrgCode(orgCode){
		for(var i=0;i<arrayWelfare.length;i++){
			if(arrayWelfare[i][1]==orgCode){
				return arrayWelfare[i][3];
				break;
			}		
		}
	}	

</script>
<BZ:body property="data" codeNames="PROVINCE;ETXB;ETSFLX;CHILD_TYPE">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<!-- 隐藏区域begin -->
<BZ:input type="hidden" prefix="P_" field="CI_ID"		id="P_CI_ID"/> 
<BZ:input type="hidden" prefix="P_" field="PROVINCE_ID"		id="P_PROVINCE_ID"/> 
<BZ:input type="hidden" prefix="P_" field="WELFARE_ID"		id="P_WELFARE_ID"/> 
<BZ:input type="hidden" prefix="P_" field="WELFARE_NAME_CN"	id="P_WELFARE_NAME_CN"/>
<BZ:input type="hidden" prefix="P_" field="WELFARE_NAME_EN"	id="P_WELFARE_NAME_EN"/>
<input type="hidden" name="listType" value="<%=listType %>">
<input type="hidden" name="OPROVINCE_ID" value="<%=provinceId %>">
<input type="hidden" name="OWELFARE_ID" value="<%=welfareId %>">
<input type="hidden" name="OWELFARE_NAME_CN" value="<%=owelfareCn %>">
<!-- 隐藏区域end -->		

<!--基本信息:start-->
<br>
<!-- 进度条begin -->
<div class="stepflex" style="margin-right: 100px;">
       <dl id="payStepFrist" class="normal doing">
           <dt class="s-num">1</dt>
           <dd class="s-text" style="margin-left:0px">修改儿童基本信息</dd>
       </dl>
       <dl id="payStepNormal" class="last">
           <dt class="s-num">2</dt>
           <dd class="s-text" style="margin-left:0px">修改儿童详细信息<s></s>
               <b></b>
           </dd>
       </dl>	        
</div>
<!-- 进度条end -->
<table class="specialtable" align="center" style='width:80%;text-align:center'>
	<tr>
		<td class="edit-data-title" colspan="2" style="text-align:center"><b>儿童基本信息修改</b></td>
	</tr>
	<tr>
		<td class="edit-data-title" width="30%">省&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;份<font color="red">*</font></td>
		<td class="edit-data-value" width="70%"> 
		<%
		if("CMS_AZB_DL_LIST".equals(listType)||"CMS_AZB_ZCSH_LIST".equals(listType)||"CMS_AZB_TXSH_LIST".equals(listType)){//安置部代录修改、安置部正常儿童审核修改、安置部特需儿童审核修改
		%>
		<BZ:select field="PROVINCE_ID" id="PROVINCE_ID" isCode="true" codeName="PROVINCE" formTitle="省份" width="245px" notnull="true" onchange="_chgProvince()">
			<BZ:option value="">--请选择--</BZ:option>
		</BZ:select>
		<%
		}else{//福利院录入
		%>
		<BZ:dataValue codeName="PROVINCE" field="PROVINCE_ID" onlyValue="true"/>
		<%} %>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">福 利 院<font color="red">*</font></td>
		<td class="edit-data-value">
		<%
		if("CMS_FLY_CLBS_LIST".equals(listType)){//福利院修改
		%>
		<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" />
		<%
		}else{//省厅代录修改、省厅审核列表页面的修改、安置部代录修改、安置部正常审核列表修改、安置部特需审核列表修改
		%>
		<select name="WELFARE_ID" class="txt_select" style="width:245px" size="1" notnull="true" id="WELFARE_ID">
			<option value="" selected>--请选择--</option>
		</select>
		<%} %>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">儿童类型<font color="red">*</font></td>
		<td class="edit-data-value">
		<BZ:select prefix="P_" field="CHILD_TYPE" id="P_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="儿童类型" width="245px" notnull="true">
			<BZ:option value="">--请选择--</BZ:option>
		</BZ:select>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名<font color="red">*</font></td>
		<td class="edit-data-value">
		<BZ:input prefix="P_" field="NAME" id="P_NAME" notnull="姓名不能为空！" defaultValue="" size="35"/>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别<font color="red">*</font></td>
		<td class="edit-data-value">
		<BZ:select prefix="P_" field="SEX" id="P_SEX" isCode="true" codeName="ETXB" formTitle="性别" width="245px" notnull="性别不能为空！">
			<option value="">--请选择--</option>
		</BZ:select>
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">出生日期<font color="red">*</font></td>
		<td class="edit-data-value">
		<BZ:input prefix="P_" field="BIRTHDAY" id="P_BIRTHDAY" type="date" notnull="出生日期不能为空！" />
		</td>
	</tr>
	<tr>
		<td class="edit-data-title">儿童身份<font color="red">*</font></td>
		<td class="edit-data-value">
		
		<BZ:input prefix="P_" field="CHILD_IDENTITY" id="S_CHILD_IDENTITY" type="helper" helperCode="ETSFLX" helperTitle="儿童身份" treeType="-1" 
								helperSync="true" showParent="false" defaultShowValue="" showFieldId="CHILD_IDENTITY_ID"  style="width:250px;" notnull="true"/>
		
	</tr>
</table>			
<!--通知信息:end-->
<br>
<!-- 按钮区域:begin -->
<div class="bz-action-frame" style="text-align:center">
	<div class="bz-action-edit" desc="按钮区">
		<input type="button" value="下一步" class="btn btn-sm btn-primary" onclick="_submit()"/>&nbsp;&nbsp;
		<input type="button" value="取&nbsp;&nbsp;消" class="btn btn-sm btn-primary" onclick="_cancle();"/>
	</div>
</div>
<!-- 按钮区域:end -->
<table class="specialtable" align="center" style='width:80%;text-align:center;line-height:250%'>
	<tr>
		<td class="edit-data-value"><b>儿童材料填报说明 :</b><br></>在录入儿童基本信息后，系统将根据福利院名称、儿童姓名、性别、出生日期验证是否存在相同基本信息的儿童，
			如果存在则无法录入新的儿童信息。</td>
		</td>
	</tr>
</table>

</BZ:form>
</BZ:body>
</BZ:html>
