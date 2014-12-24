<%
/**   
 * @Title: stepchild_cn_view.jsp
 * @Description:  继子女收养-英文-查看
 * @author wangz   
 * @date 2014-9-29
 * @version V1.0   
 */
%>


<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%
	String path = request.getContextPath();
	Data data = (Data)request.getAttribute("data");
	String ADOPTER_SEX = data.getString("ADOPTER_SEX");
	String afId = data.getString("AF_ID");
%>
<BZ:html>
<BZ:head>
    <title>收养文件中文</title>
    <BZ:webScript edit="true"/>
    <script type="text/javascript" src="<%=path%>/resource/js/common.js"></script>
    </BZ:head>

<BZ:body property="data" codeNames="WJLX;SYLX;GJ;SEX;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND">

	<script type="text/javascript">
		$(document).ready( function() {
			dyniframesize(['iframe','mainFrame']);//公共功能，框架元素自适应
			_setValidPeriod('<%=data.getString("VALID_PERIOD")%>');
		})
		
	/*
	* 设置有效期限类型
	* 1:有效期限
	* 2:长期
	*/
	function _setValidPeriod(v){
		var strText;
		if("-1"==v){				
			strText = "长期";
		}else{
			strText = v + "月";			
		}
		$("#FE_VALID_PERIOD").text(strText);	
	}		

	//关闭
	function _close(){
		window.close();
	}
	
	</script>
	                  
	<!--收养文件：start-->
	<table id="tb_jzv_cn" class="specialtable">
		<tr>
			 <td class="edit-data-title" style="text-align:center"><b>收养人基本信息</b></td>
		</tr>
		<tr>
			<td>
				<!--收养人信息：start-->                            	  
				<table class="specialtable">                          	
					<tr>
						<td class="edit-data-title" width="15%">外文姓名</td>
						<td class="edit-data-value" width="26%">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue type="String" field="MALE_NAME" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue type="String" field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						<%}%>
						</td>
						<td class="edit-data-title" width="15%">性别</td>
						<td class="edit-data-value" width="26%">
						<BZ:dataValue codeName="SEX" field="ADOPTER_SEX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-value" width="18%" rowspan="4" style="text-align:center">
							<%if("1".equals(ADOPTER_SEX)){%>
							<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:150px;">
							<%}else{%>
							<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:150px;">
							<%}%>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">出生日期</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
						<%}%>
						</td>
						<td class="edit-data-title">年龄</td>
						<td class="edit-data-value">
							<div id="tb_dqsy_cn_MALE_AGE" style="font-size:14px">
							<script>
							document.write(getAge('<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/><%}else{%><BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/><%}%>'));
							</script>
							</div>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">国籍</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue codeName="GJ" field="MALE_NATION" defaultValue="" onlyValue="true"/>
						<%}else{%><BZ:dataValue codeName="GJ" field="FEMALE_NATION" defaultValue="" onlyValue="true"/>
						<%}%>
						</td>
						<td class="edit-data-title">护照号码</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						<%}else{%><BZ:dataValue type="String" field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						<%}%>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">婚姻状况</td>
						<td class="edit-data-value">已婚</td>
						<td class="edit-data-title">结婚日期</td>
						<td class="edit-data-value"><BZ:dataValue type="date" field="MARRY_DATE" defaultValue="" onlyValue="true"/></td>
					</tr>
					<tr>
						<td class="edit-data-title" colspan="5" style="text-align:center"><b>政府批准信息</b></td>
					</tr>
					<tr>
						<td class="edit-data-title">批准日期</td>
						<td class="edit-data-value"><BZ:dataValue type="date" field="GOVERN_DATE" defaultValue="" onlyValue="true"/>
						<td class="edit-data-title">有效期限</td>
						<td class="edit-data-value">
						<div id="FE_VALID_PERIOD"></div>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" colspan="6" style="text-align:center">
						<b>附件信息</b></td>										
					</tr>
					<tr>
						<td colspan="6">
						<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattview.action?bigType=AF&packID=<%=AttConstants.AF_STEPCHILD%>&packageID=<BZ:dataValue field="PACKAGE_ID" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
						</td>
					</tr>                                    
				</table>
			</td>
		</tr>
	</table> 
	<!--收养：end-->			
	</BZ:body>
</BZ:html>


