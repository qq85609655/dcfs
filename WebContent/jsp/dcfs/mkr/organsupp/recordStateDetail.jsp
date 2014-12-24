<%@page import="hx.code.Code"%>
<%@page import="hx.code.CodeList"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.authenticate.SessionInfo"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	String personName = SessionInfo.getCurUser().getPerson().getCName();
	
    Data data = (Data)request.getAttribute("data");
    if(data == null){
    	data = new Data();
    }
    
    //服务项目
    CodeList FWXMList = (CodeList)request.getAttribute("FWXMList");
%>
<BZ:html>
<BZ:head>
	<title>机构维护</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	<script type="text/javascript">
	
	//加载iframe
	$(document).ready(function() {
		dyniframesize(['iframe','mainFrame']);//公共功能，框架元素自适应
	});
	
	//返回组织机构备案列表
	function _goback(){
		document.organForm.action=path+"mkr/organSupp/organRecordStateList.action";
		document.organForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data" codeNames="ZZHZZT;FWXM;ZZBASHZT">
	<BZ:form name="organForm" method="post">
	<!-- 用于保存数据结果提示 -->
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<!-- 审核信息begin -->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- <div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					组织基本信息
				</div>
			</div> -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<BZ:input type="hidden" prefix="ORG_" field="ID" defaultValue='<%=data.getString("ID") %>'/>
				<BZ:input type="hidden" prefix="MKR_" field="ADOPT_ORG_ID" defaultValue='<%=data.getString("ADOPT_ORG_ID") %>'/>
				<!-- 编辑区域 开始 -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="13%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">中文名称(CN)</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CNAME" onlyValue="true" defaultValue='' />					
						</td>
						<td class="bz-edit-data-title">英文名称(EN)</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ENNAME" onlyValue="true" defaultValue='' />					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">机构代码</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORG_CODE" defaultValue=""/>					
						</td>
						<td class="bz-edit-data-title">国家</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CODE"  defaultValue="" codeName="GJList" />		
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">所在地区</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PLACE_AREA" defaultValue=""/>					
						</td>
						<td class="bz-edit-data-title">认证生效日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="LICENSE_STARTVALID" defaultValue="" type="date" />					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">认证失效日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="LICENSE_VALID" defaultValue="" type="date"/>			
						</td>
						<td class="bz-edit-data-title">组织成立时间</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FOUNDED_DATE" defaultValue="" type="date" />					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">开展中国项目时间</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CNSTART_DATE" defaultValue="" type="date"/>			
						</td>
						<td class="bz-edit-data-title">总部地址</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="HEADQUARTER_ADDRESS" defaultValue=""/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">邮寄地址</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MAILING_ADDRESS" defaultValue=""/>					
						</td>
						<td class="bz-edit-data-title">电话</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="TEL" defaultValue="" />					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">传真</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAX" defaultValue=""/>			
						</td>
						<td class="bz-edit-data-title">网址</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="WEBSITE" defaultValue=""/>					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">电子邮件</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="EMAIL" defaultValue="" />			
						</td>
						<td class="bz-edit-data-title">委托或认证部门</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AUTHOR_DEPARTMENT" defaultValue="" />					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">服务项目</td>
						<td class="bz-edit-data-value">
							<%
								if(FWXMList != null && FWXMList.size() > 0){
									String ser = data.getString("SERVICE");
									String serv = new String();
									if(ser!=null && !"".equals(ser)){
										serv = ser;
									}
									for(int i = 0; i < FWXMList.size(); i ++){
										Code code = FWXMList.get(i);
										if(serv.contains(code.getValue())){
								%>
									<%=code.getName() %>
								<%
										}
									}
								}
							%>
						</td>
						<td class="bz-edit-data-title">其他合作国家</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="OTHER_COUNTRY" defaultValue="" />					
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">组织合作状态</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="STATE" codeName="ZZHZZT" defaultValue="" />		
						</td>
						<td class="bz-edit-data-title">备案状态</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RECORD_STATE" codeName="ZZBASHZT" defaultValue=""/>	
						</td>
					</tr>
					<tr>
						
					</tr>
				</table>
				<!-- 编辑区域 结束 -->
			</div>
		</div>
	</div>
	<!-- 审核信息end -->
	
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>
