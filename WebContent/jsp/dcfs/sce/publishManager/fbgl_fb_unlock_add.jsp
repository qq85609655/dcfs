<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title:fbgl_fb_unlock_add.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-16
 * @version V1.0   
 */
   
    /******Java代码功能区域Start******/
    //发布记录主键ID
	String pubid= (String)request.getAttribute("pubid");//发布记录主键ID
	String riid= (String)request.getAttribute("riid");//预批记录主键ID
	String ciid= (String)request.getAttribute("ciid");//儿童材料主键ID
	Data rtfbData= (Data)request.getAttribute("rtfbData");
	String IS_TWINS = rtfbData.getString("IS_TWINS");
	
	//生成token串
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
	/******Java代码功能区域End******/
	
%>
<BZ:html>

<BZ:head>
	<title>儿童发布解除锁定页面</title>
	<up:uploadResource/>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>

<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	});
	
	
	
	
	//撤销发布提交
	function _submit(){
		if(confirm("确定提交吗？")){
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			//只读下拉列表重置为可编辑，目的为了后台获得此数据
			$("#P_UNLOCKER_DATE").attr("disabled",false);
			$("#P_UNLOCKER_ID").attr("disabled",false);
			$("#P_UNLOCKER_NAME").attr("disabled",false);
			//表单提交
			var obj = document.forms["srcForm"];
			obj.action=path+'sce/publishManager/saveUnlockFbInfo.action';
			obj.submit();
		}
	}
	
	//页面返回
	function _goback(){
		window.history.back();
	}
	
</script>

<BZ:body codeNames="GJSY;SYZZ;PROVINCE;BCZL;DFLX;SYS_ADOPT_ORG" property="rtfbData">

	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="H_" field="PUB_ID" defaultValue="<%=pubid %>"/>
		<BZ:input type="hidden" prefix="H_" field="RI_ID" defaultValue="<%=riid %>"/>
		<BZ:input type="hidden" prefix="H_" field="CI_ID" defaultValue="<%=ciid %>"/>
		<!-- 隐藏区域end -->
		
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>儿童基本信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%">省份</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE"  defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">福利院</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="10%">姓名</td>
							<td class="bz-edit-data-value" >
								<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">性别</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" checkValue="1=男;2=女;3=两性"/>
							</td>
							<td class="bz-edit-data-title"  width="10%">出生日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="Date" />
							</td>
							
							<td class="bz-edit-data-title"  width="10%">病残种类</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true" />
							</td>
						</tr>
						<tr>
							
							<td class="bz-edit-data-title" width="10%">特别关注</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=否;1=是;"/>
							</td>
							<td class="bz-edit-data-title"  width="10%">发布类型</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_TYPE" defaultValue="" onlyValue="true" checkValue="1=点发;2=群发"/>
							</td>
							<td class="bz-edit-data-title"  width="10%">发布日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_LASTDATE" defaultValue="" onlyValue="true" type="Date" />
							</td>
							<td class="bz-edit-data-title"  width="10%">锁定组织</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"  width="10%">锁定日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="LOCK_DATE" defaultValue="" onlyValue="true" type="Date"/>
							</td>
							<td class="bz-edit-data-title"  width="10%">预批编号</td>
							<td class="bz-edit-data-value" >
								<BZ:dataValue field="REQ_NO" defaultValue=""/>
							</td>
							
							<td class="bz-edit-data-title" width="10%">是否多胞胎</td>
							<td class="bz-edit-data-value" >
								<BZ:dataValue field="IS_TWINS" defaultValue="" onlyValue="true" checkValue="0=否;1=是"/>
							</td>
							<td class="bz-edit-data-title" width="10%"><%if("1".equals(IS_TWINS)||"1"==IS_TWINS){ %>同胞姓名<%} %></td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="TB_NAME" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div> 
		<!-- 编辑区域end -->
		<br/>
		
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>解除锁定信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>解除锁定原因</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="UNLOCKER_REASON" id="P_UNLOCKER_REASON" type="textarea" prefix="P_" formTitle="解除锁定原因" defaultValue="" style="width:80%"  maxlength="900" notnull="请输入撤销原因"/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="10%">解除人</td>
							<td class="bz-edit-data-value">
								<BZ:input  prefix="P_" field="UNLOCKER_NAME" id="P_REVOKE_USERNAME" defaultValue="" formTitle="解除人"  readonly="true"/>
								<BZ:input type="hidden" field="UNLOCKER_ID"  prefix="P_" id="P_UNLOCKER_ID"/>
							</td>
							<td class="bz-edit-data-title" width="10%">解除日期</td>
							<td class="bz-edit-data-value"  >
								<BZ:input type="Date" field="UNLOCKER_DATE" prefix="P_" readonly="true" formTitle="解除日期"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div> 
		<!-- 编辑区域end -->
		<br/>
		
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
	</BZ:form>
</BZ:body>
</BZ:html>
