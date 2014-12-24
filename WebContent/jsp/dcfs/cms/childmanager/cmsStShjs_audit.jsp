<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@page import="com.dcfs.cms.childManager.ChildStateManager"%>
<%@page import="com.dcfs.cms.childManager.ChildCommonManager"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@page import="com.hx.framework.authenticate.SessionInfo"%>
<%@page import="hx.util.DateUtility"%>
<%
  /**   
 * @Description: 省厅材料审核页面
 * @author wangzheng   
 * @date 2014-9-15
 * @version V1.0   
 */
TokenProcessor processor = TokenProcessor.getInstance();
String token = processor.getToken(request);
String path = request.getContextPath();

Data d = (Data)request.getAttribute("data");
String ciId = d.getString("CI_ID","");
String orgId = d.getString("WELFARE_ID","");
String strPar ="org_id="+orgId + ";ci_id=" + ciId;
String strPar1 ="org_id="+orgId + ",ci_id=" + ciId;
String CHILD_TYPE = d.getString("CHILD_TYPE","");
String CHILD_NO = d.getString("CHILD_NO");

String CHILD_IDENTITY = d.getString("CHILD_IDENTITY","");
String packId = "";
String uploadParameter = (String)request.getAttribute("uploadParameter");
//根据儿童身份选择附件集合
ChildCommonManager ccm = new ChildCommonManager();
packId = ccm.getChildPackIdByChildIdentity(CHILD_IDENTITY, CHILD_TYPE, false);

String personId = SessionInfo.getCurUser().getPerson().getPersonId();
String personName = SessionInfo.getCurUser().getPerson().getCName();
String curDate = DateUtility.getCurrentDate();
%>

<BZ:html>
<BZ:head>
    <link href="<%=path%>/resource/style/base/list.css" rel="stylesheet" type="text/css" />
	<up:uploadResource isImage="true"/>
	<title>材料信息审核（省厅）</title>
	<BZ:webScript edit="true"/>
	<!--批量附件上传：start-->
	<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
	<!--批量附件上传：end-->
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
	<script type="text/javascript" src="<%=path%>/resource/js/page.js"></script>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"/>
	
</BZ:head>	
<BZ:body property="data" codeNames="PROVINCE;ETXB;ETSFLX;BCZL;CHILD_TYPE;ETCLSHJG_ST">
<script type="text/javascript">
  	//iFrame高度自动调整
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
		 $('#tab-container').easytabs();
		//页面加载时如果是报刊公告则显示"公告日期"和"报刊名称"的填写行
		var isannounce = $('#P_IS_ANNOUNCEMENT').val();//是否报刊公告
		if(isannounce=="1"){
			$("#announcementInfo").show();
		}		 
	});

	//提交
	function _submit(){
		var audit_option = $('#A_AUDIT_OPTION').val();//审核意见
		var SUPPLY_STATE = '<BZ:dataValue field="SUPPLY_STATE" onlyValue="true"/>';
		if("<%=ChildStateManager.CHILD_AUD_OPTION_ADDITIONAL%>"==audit_option){//补充文件
			if("<%=ChildStateManager.CHILD_ADD_STATE_TODO%>"==SUPPLY_STATE || "<%=ChildStateManager.CHILD_ADD_STATE_DOING%>"==SUPPLY_STATE){
				alert("该材料正在补充中，请重新选择【审核结果】！");
				return;
			}
		}

		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		if(document.getElementById("P_IS_HOPE")!=null && document.getElementById("P_IS_HOPE").checked)
			document.getElementById("P_IS_HOPE").value = "1";
		if(document.getElementById("P_IS_PLAN")!=null && document.getElementById("P_IS_PLAN").checked)
			document.getElementById("P_IS_PLAN").value = "1";			
		if(confirm('确认要保存当前填写的数据么?')){
			if(document.getElementById("ADD_IS_MODIFY").checked)
				document.getElementById("ADD_IS_MODIFY").value = "1";				
			document.srcForm.action=path+"/cms/childManager/childInfoAuditSave.action";
			document.srcForm.submit();
		}else{
			return;
		}
		
	}

	
	function _chgAuditOption(){		
		var audit_option = $('#A_AUDIT_OPTION').val();//审核意见
		if("<%=ChildStateManager.CHILD_AUD_OPTION_ADDITIONAL%>"==audit_option){//补充文件
			$("#is_modify").show();
			$("#notice_content").show();
			$("#audit_content").hide();
			document.getElementById("state").value = "<%=ChildStateManager.OPERATION_STATE_DOING%>";
		}else{
			$("#is_modify").hide();
			$("#notice_content").hide();
			$("#audit_content").show();
			document.getElementById("state").value = "<%=ChildStateManager.OPERATION_STATE_DONE%>";
			if("<%=ChildStateManager.CHILD_AUD_OPTION_SUCCESS%>"==audit_option||"<%=ChildStateManager.CHILD_AUD_OPTION_FAILURE%>"==audit_option){//选择审核通过/不通过时自动填充审核意见内容为"通过"/"不通过"
				 $("#A_AUDIT_CONTENT").text($("#A_AUDIT_OPTION").find("option:selected").text());
			}else{
				$("#A_AUDIT_CONTENT").text("");
			}
		}
	}

	//取消
	function _cancle(){
		if(confirm('确认要取消当前填写的数据么?')){
			document.srcForm.action=path+"/cms/childManager/STAuditList.action";
			document.srcForm.submit();
		}else{
			return;
		}
	}

	//设置双胞胎
	function _setTwins(){
		$.layer({
			type : 2,
			title : "同胞设置",
			shade : [0.5 , '#D9D9D9' , true],
			border :[2 , 0.3 , '#000', true],
			//page : {dom : '#planList'},
			iframe: {src: '<BZ:url/>/cms/childManager/twinslist.action?CHILD_NO=<%=CHILD_NO%>&CI_ID=<%=ciId%>&WELFARE_ID=<%=orgId%>'},
			area: ['800px','400px'],
			offset: ['0px' , '0px']
		});
	
	}

	function getIframeVal(val)  
	{
		//document.getElementById("textareaid").value=urlDecode(val);
		//alert(document.getElementById("frmUpload"));
		//document.getElementById("frmUpload").location.reload();
		frmUpload.window.location.reload();
		
	}	
	
	var p = "0";
	//附件上传
	function _toipload(fn){
		p = fn;		
		var packageId,isEn;
		//p=0，上传翻译件
		if(p=="0"){
			packageId = "<BZ:dataValue field="FILE_CODE_EN" onlyValue="true"/>";
			isEn = "true";
		}else{//p=0，上传原件
			packageId = "<BZ:dataValue field="FILE_CODE" onlyValue="true"/>";
			isEn = "false";
		}
		document.uploadForm.PACKAGE_ID.value = packageId;
		document.uploadForm.IS_EN.value = isEn;
		document.uploadForm.action="<%=path%>/uploadManager";
		popWin.showWinIframe("1000","600","fileframe","附件管理","iframe","#");
		document.uploadForm.submit();
	}

	
	function scrollNav(){
		alert("12345");
		var headHeight=10;
		var nav=$("#etabs"); 
		$(window).scroll(function(){ 
			alert("d");
			if($(this).scrollTop()>headHeight){ 
				nav.addClass("navFix"); 
			} 
			else{ 
				nav.removeClass("navFix"); 
			} 
		}) 
	}
	function isAnnouncement(){
		var isannounce = $('#P_IS_ANNOUNCEMENT').val();//是否报刊公告
		if(isannounce=="1"){
			$("#announcementInfo").show();
		}else{
			$("#announcementInfo").hide();
		}
	}
</script>

<BZ:form name="srcForm" method="post" token="<%=token %>">
<!-- 隐藏区域begin -->
<!--儿童材料-->
<BZ:input type="hidden" prefix="P_" field="CI_ID"			id="P_CI_ID"/>
<BZ:input type="hidden" prefix="P_" field="CHILD_NO"		id="P_CHILD_NO"/>
<BZ:input type="hidden" prefix="P_" field="CHILD_TYPE"		id="P_CHILD_TYPE"/>
<BZ:input type="hidden" prefix="P_" field="PROVINCE_ID"		id="P_PROVINCE_ID"/> 
<BZ:input type="hidden" prefix="P_" field="WELFARE_ID"		id="P_WELFARE_ID"/> 
<BZ:input type="hidden" prefix="P_" field="CHILD_NO"		id="P_CHILD_NO"/> 
<BZ:input type="hidden" prefix="P_" field="WELFARE_NAME_CN"	id="P_WELFARE_NAME_CN"/>
<BZ:input type="hidden" prefix="P_" field="WELFARE_NAME_EN"	id="P_WELFARE_NAME_EN"/>
<BZ:input type="hidden" prefix="P_" field="NAME"			id="P_NAME"/>
<!-- <BZ:input type="hidden" prefix="P_" field="NAME_PINYIN"		id="P_NAME_PINYIN"/> -->
<BZ:input type="hidden" prefix="P_" field="SEX"				id="P_SEX"/>
<BZ:input type="hidden" prefix="P_" field="BIRTHDAY"		id="P_BIRTHDAY"/>
<BZ:input type="hidden" prefix="P_" field="CHILD_IDENTITY"	id="P_CHILD_IDENTITY" defaultValue=""/>
<BZ:input type="hidden" prefix="P_" field="AUD_STATE"		id="P_AUD_STATE"/>
<BZ:input type="hidden" prefix="P_" field="FILE_CODE"		id="P_FILE_CODE"/>
<BZ:input type="hidden" prefix="P_" field="FILE_CODE_EN"	id="P_FILE_CODE_EN"/>

<!--审核-->
<BZ:input type="hidden" prefix="A_" field="CA_ID"			id="A_CA_ID"/>
<input type="hidden" name="A_AUDIT_LEVEL" id="A_AUDIT_LEVEL" value="<%=ChildInfoConstants.LEVEL_PROVINCE%>">

<!--补充-->
<input type="hidden" name="ADD_SOURCE" id="ADD_SOURCE" value="<%=ChildInfoConstants.LEVEL_PROVINCE%>">
<input type="hidden" name="ADD_IS_FLY" id="ADD_IS_FLY" value="1">
<input type="hidden" name="ADD_IS_ST" id="ADD_IS_ST" value="0">
<!--操作类型-->
<input type="hidden" name="state" id="state" value="">
<!-- 隐藏区域end -->		
<div>
<!--基本信息:start-->
<div id="tab-container" class='tab-container'>
	<ul class='etabs' id='etabs'>
		<li class='tab'><a href="#tab1">基本信息</a></li>
		<li class='tab'><a href="<%=path%>/cms/childupdate/getShowDataByCIID.action?CI_ID=<%=ciId%>" data-target="#tab2">更新记录</a></li>
		<li class='tab'><a href="<%=path%>/cms/childaddition/getShowDataByCIID.action?CI_ID=<%=ciId%>" data-target="#tab3">补充记录</a></li>
	</ul>
	<div class='panel-container'>
		<!--材料基本信息：start-->
        <div id="tab1">
		<table class="specialtable" align="center" style='width:98%;text-align:center'>
			<tr>
				<td class="edit-data-title" colspan="5" style="text-align:center"><b>儿童信息</b></td>
			</tr>
			<tr>
				<td class="edit-data-title" width="15%">儿童编号</td>
				<td class="edit-data-value" width="30%"> 
				<BZ:dataValue field="CHILD_NO" defaultValue=""/>
				</td>
				<td class="edit-data-title" width="15%">儿童类型</td>
				<td class="edit-data-value" width="30%">
				<BZ:dataValue field="CHILD_TYPE" codeName="CHILD_TYPE" onlyValue="true"/>
				</td>
				<td class="edit-data-value" width="10%" rowspan="6"><up:uploadImage attTypeCode="CI" id="P_PHOTO_CARD" packageId="<%=ciId%>" name="P_PHOTO_CARD" imageStyle="width:150px;height:175px;" autoUpload="true" hiddenSelectTitle="true"	hiddenProcess="true" hiddenList="true" selectAreaStyle="border:0;" proContainerStyle="width:100px;" smallType="<%=AttConstants.CI_IMAGE %>"  bigType="CI"  diskStoreRuleParamValues="<%=strPar%>"/></td>
			</tr>
			<tr>
				<td class="edit-data-title">省份</td>
				<td class="edit-data-value"><BZ:dataValue codeName="PROVINCE" field="PROVINCE_ID" defaultValue="" onlyValue="true"/></td>
				<td class="edit-data-title">福利院</td>
				<td class="edit-data-value"><BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
			</tr>
			<tr>
				<td class="edit-data-title">姓名</td>
				<td class="edit-data-value"><BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/></td>
				<td class="edit-data-title">姓名拼音<font color="red">*</font></td>
				<td class="edit-data-value"><BZ:input prefix="P_" field="NAME_PINYIN" id="P_NAME_PINYIN" defaultValue="" notnull="姓名拼音不能为空！" maxlength="100" size="25"/></td>
			</tr>
			<tr>
				<td class="edit-data-title">性别</td>
				<td class="edit-data-value"><BZ:dataValue codeName="ETXB" field="SEX" defaultValue="" onlyValue="true"/></td>
				<td class="edit-data-title">出生日期</td>
				<td class="edit-data-value"><BZ:dataValue field="BIRTHDAY" type="date" defaultValue="" onlyValue="true"/></td>
			</tr>
			<tr>
				<td class="edit-data-title">体检日期<font color="red">*</font></td>
				<td class="edit-data-value">
				<BZ:input prefix="P_" field="CHECKUP_DATE" id="P_CHECKUP_DATE" type="date" notnull="体检日期不能为空！" />
				</td>
				<td class="edit-data-title">双胞胎</td>
				<td class="edit-data-value">
					<input type="button" value="同胞设置" class="btn btn-sm btn-primary" onclick="_setTwins()"/>
					
				</td>
			</tr>
			<tr>
				<td class="edit-data-title">身份证号<font color="red">*</font></td>
				<td class="edit-data-value"><BZ:input prefix="P_" field="ID_CARD" id="P_ID_CARD" defaultValue="" notnull="身份证号不能为空！"  maxlength="20" size="25"/></td>
				<td class="edit-data-title">儿童身份<font color="red">*</font></td>
				<td class="edit-data-value"><BZ:dataValue field="CHILD_IDENTITY" codeName="ETSFLX" defaultValue=""/>		
				</td>
			</tr>
			<tr>
				<td class="edit-data-title">送养人（中）<font color="red">*</font></td>
				<td class="edit-data-value"><BZ:input prefix="P_" field="SENDER" id="P_SENDER" defaultValue="" notnull="送养人（中）不能为空！" maxlength="25" size="25"/></td>
				<td class="edit-data-title">送养人（英）<font color="red">*</font></td>
				<td class="edit-data-value" colspan="2"><BZ:input prefix="P_" field="SENDER_EN" id="P_SENDER_EN" defaultValue="" notnull="送养人（英）不能为空！" maxlength="100" size="60"/></td>
			</tr>
			<tr>
				<td class="edit-data-title">送养人地址<font color="red">*</font></td>
				<td class="edit-data-value" colspan="4"><BZ:input prefix="P_" field="SENDER_ADDR" id="P_SENDER_ADDR" defaultValue="" notnull="送养人地址不能为空！" size="50" maxlength="100"/>		
			</tr>
			<tr>
				<td class="edit-data-title">入院日期</td>
				<td class="edit-data-value" ><BZ:input type="date" prefix="P_" field="ENTER_DATE" id="P_ENTER_DATE" defaultValue="" dateExtend="minDate:'#F{$dp.$D(\\'P_PICKUP_DATE\\')}',readonly:true"/></td>
				<td class="edit-data-title">捡拾日期</td>
				<td class="edit-data-value" colspan="2"><BZ:input type="date" prefix="P_" field="PICKUP_DATE" id="P_PICKUP_DATE" defaultValue="" dateExtend="maxDate:'#F{$dp.$D(\\'P_ENTER_DATE\\')}',readonly:true"/></td>
			</tr>
			<tr>
				<td class="edit-data-title">报送日期</td>
				<td class="edit-data-value"><BZ:input type="date" prefix="P_" field="SEND_DATE" id="P_SEND_DATE" defaultValue=""/></td>
				<td class="edit-data-title">报刊公告</td>
				<td class="edit-data-value" colspan="2">
				<BZ:select prefix="P_" field="IS_ANNOUNCEMENT" id="P_IS_ANNOUNCEMENT" formTitle="报刊公告" onchange="isAnnouncement()"  width="135px">
				    <BZ:option value="">--请选择--</BZ:option>
					<BZ:option value="1">是</BZ:option>
					<BZ:option value="0">否</BZ:option>
		        </BZ:select>
				</td>
			</tr>
			<tr id="announcementInfo" style="display:none">
				<td class="edit-data-title">公告日期</td>
				<td class="edit-data-value"><BZ:input type="date" prefix="P_" field="ANNOUNCEMENT_DATE" id="P_ANNOUNCEMENT_DATE" defaultValue=""/></td>
				<td class="edit-data-title">报刊名称</td>
				<td class="edit-data-value" colspan="2"><BZ:input prefix="P_" field="NEWS_NAME" id="P_NEWS_NAME" defaultValue="" maxlength="100" size="60"/></td>
			</tr>
			<%if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(CHILD_TYPE)){%>
			<tr>
				<td class="edit-data-title">病残种类</td>
				<td class="edit-data-value">
				<BZ:select prefix="P_" field="SN_TYPE" id="P_SN_TYPE" isCode="true" codeName="BCZL" formTitle="病残种类" defaultValue="" width="245px">
					<BZ:option value="">--请选择--</BZ:option>
				</BZ:select>
				</td>
				<td class="edit-data-title">特殊活动</td>
				<td class="edit-data-value" colspan="2">
					<input type="checkbox" name="P_IS_PLAN" id="P_IS_PLAN" <BZ:dataValue field="IS_PLAN" defaultValue="0" onlyValue="true" checkValue="0= ;1=checked"/>>明天计划
					<input type="checkbox" name="P_IS_HOPE" id="P_IS_HOPE" <BZ:dataValue field="IS_HOPE" defaultValue="0" onlyValue="true" checkValue="0= ;1=checked"/>>希望之旅
				</td>
			</tr>
			<tr>
				<td class="edit-data-title">病残诊断</td>
				<td class="edit-data-value" colspan="4">
				<textarea name="P_DISEASE_CN" id="P_DISEASE_CN" rows="5" cols="100" maxlength="1000"><BZ:dataValue field="DISEASE_CN" defaultValue="" onlyValue="true"/></textarea>
				</td>
			</tr>
			<%}%>
			<tr>
				<td class="edit-data-title">备注</td>
				<td class="edit-data-value" colspan="4">
				<textarea name="P_REMARKS" id="P_REMARKS" rows="3" cols="100" maxlength="1000"><BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true"/></textarea></td>
			</tr>
			<!--附件：start-->
			<tr>
			    <td class="edit-data-title" colspan="5" style="text-align:center">
				<b>附件信息</b>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" class="btn btn-sm btn-primary" value="附件上传" onclick="_toipload('1')" />
				</td>
			</tr>
			<tr>
				<td colspan="5">
				<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattmaintain.action?bigType=CI&packID=<%=packId%>&packageID=<BZ:dataValue field="FILE_CODE" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
				</td>
			</tr>
			<!--附件：end-->
		</table>
		<!--材料基本信息：end-->
        </div>
		<div id="tab2">
		</div>
		<div id="tab3">
		</div>
	</div>
</div>
<!--审核信息：start-->
<div id="tab-audit">
	<table class="specialtable" align="center" style="width:96%;text-align:center">
		<tr>
			<td class="edit-data-title" colspan="6" style="text-align:center"><b>审核信息</b></td>
		</tr>
		<tr>
			<td  class="edit-data-title" width="15%">审核人</td>
			<td  class="edit-data-value" width="18%"><%=personName %>
			</td>
			<td  class="edit-data-title" width="15%">审核日期</td>
			<td  class="edit-data-value" width="18%">
			<BZ:input type="date" prefix="A_" field="AUDIT_DATE" id="A_AUDIT_DATE" defaultValue="<%=curDate%>"/>
			</td>
			<td  class="edit-data-title" width="15%">审核结果<font color=red>*</font></td>
			<td  class="edit-data-value" width="19%">
			<BZ:select prefix="A_" field="AUDIT_OPTION" id="A_AUDIT_OPTION" isCode="true" codeName="ETCLSHJG_ST" formTitle="审核结果" defaultValue="" notnull="请选择审核结果" onchange="_chgAuditOption()" width="135px">
				<BZ:option value="">--请选择--</BZ:option>
			</BZ:select>
			</td>
		</tr>		
		<tr id="audit_content">
			<td  class="edit-data-title">审核意见</td>
			<td  class="edit-data-value" colspan="5"><BZ:input type="textarea" prefix="A_" field="AUDIT_CONTENT" id="A_AUDIT_CONTENT" defaultValue="" maxlength="250" style="width:92%" /></td>
		</tr>
		<tr id="is_modify" style="display:none">
			<td  class="edit-data-title">是否允许修改原材料</td>
			<td  class="edit-data-value" colspan="5">
			<input type="checkbox" name="ADD_IS_MODIFY" id="ADD_IS_MODIFY" value="">&nbsp;是
			</td>
		</tr>
		<tr id="notice_content" style="display:none">
			<td  class="edit-data-title">补充通知</td>
			<td  class="edit-data-value" colspan="5"><BZ:input type="textarea" prefix="ADD_" field="NOTICE_CONTENT" id="ADD_NOTICE_CONTENT" defaultValue="" maxlength="250" style="width:92%"/></td>
		</tr>
		<tr id="audit_remarks">
			<td  class="edit-data-title">备注</td>
			<td  class="edit-data-value" colspan="5"><BZ:input type="textarea" prefix="A_" field="AUDIT_REMARKS" id="A_AUDIT_REMARKS" defaultValue="" maxlength="500" style="width:92%"/></td>
		</tr>			
	</table>
</div>
<!--审核信息：end-->
</div>
<br>
<!-- 按钮区域:begin -->
<div class="bz-action-frame" style="text-align:center">
	<div class="bz-action-edit" desc="按钮区">
		 <!--<input type="button" value="保&nbsp;&nbsp;存" class="btn btn-sm btn-primary" onclick="_save()"/>&nbsp;&nbsp;-->
		<input type="button" value="确&nbsp;&nbsp;定" class="btn btn-sm btn-primary" onclick="_submit()"/>&nbsp;&nbsp;
		<input type="button" value="取&nbsp;&nbsp;消" class="btn btn-sm btn-primary" onclick="_cancle();"/>
	</div>
</div>
<!-- 按钮区域:end -->

</BZ:form>
<form name="uploadForm" method="post" action="/uploadManager" target="fileframe">
	<!--附件使用：start-->
		<input type="hidden" id="IFRAME_NAME"	name="IFRAME_NAME"	value=""/>
		<input type="hidden" id="PACKAGE_ID"	name="PACKAGE_ID"	value=''/>
		<input type="hidden" id="SMALL_TYPE"	name="SMALL_TYPE"	value='<%=uploadParameter%>'/>
		<input type="hidden" id="ENTITY_NAME"	name="ENTITY_NAME"	value="ATT_CI"/>
		<input type="hidden" id="BIG_TYPE"		name="BIG_TYPE"		value="CI"/>
		<input type="hidden" id="IS_EN"			name="IS_EN"		value="false"/>
		<input type="hidden" id="CREATE_USER"	name="CREATE_USER"	value=""/>
		<input type="hidden" id="PATH_ARGS"		name="PATH_ARGS"	value="<%=strPar1 %>"/>
		
		<!--附件使用：end-->
	</form>
<script type="text/javascript">
<!--
	_chgAuditOption();
//-->
</script>
</BZ:body>
</BZ:html>
