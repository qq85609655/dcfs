<%
/**   
 * @Title: singleparent_cn_view.jsp
 * @Description:  单亲收养_中文_查看
 * @author wangz   
 * @date 2014-10-29
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
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
</BZ:head>
<script type="text/javascript">
	var path = "<%=path%>";
	$(document).ready( function() {
		dyniframesize(['iframe','mainFrame']);//公共功能，框架元素自适应
		_setValidPeriod('<%=data.getString("VALID_PERIOD")%>');
		})
	
	//计算bmi
	function _bmi(h,w){
		if(""==h || ""==w || "null"==h || "null"==w){
			return ""
		}
		h = h/100;
		return parseFloat(w / (h * h)).toFixed(2);
	}
	/*
	* 设置家庭净资产
	*/
	function _setTotalManny(a,d){
		if(""==a || ""==d || "null"==a || "null"==d){
			return "";
		}		
		return(a - d);	
	}

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
<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND;SEX;SGYJ">
	                 
	<!--单亲收养：start-->
	<table class="specialtable">
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
						<td class="edit-data-value" width="18%" rowspan="6" style="text-align:center">
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
							<script>
							document.write(getAge('<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/><%}else{%><BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/><%}%>'));
							</script>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">国籍</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue codeName="GJ" field="MALE_NATION" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue codeName="GJ" field="FEMALE_NATION" defaultValue="" onlyValue="true"/>
						<%}%>
						</td>
						<td class="edit-data-title">护照号码</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue type="String" field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue type="String" field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						<%}%>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">受教育程度</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue codeName="ADOPTER_EDU" field="MALE_EDUCATION" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue  codeName="ADOPTER_EDU" field="FEMALE_EDUCATION" defaultValue="" onlyValue="true"/>
						<%}%>
						</td>
						<td class="edit-data-title">职业</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue type="String" field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue type="String" field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>
						<%}%>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">健康状况</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue codeName="ADOPTER_HEALTH" field="MALE_HEALTH" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_HEALTH_CONTENT_CN" defaultValue="" onlyValue="true"/>
						</td>
						<%}else{%>
						<BZ:dataValue codeName="ADOPTER_HEALTH" field="FEMALE_HEALTH" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_HEALTH_CONTENT_CN" defaultValue="" onlyValue="true"/>
						</td>
						<%}%>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">身高</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue field="MALE_HEIGHT" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue field="FEMALE_HEIGHT" defaultValue="" onlyValue="true"/>
						<%}%>厘米
						</td>
						<td class="edit-data-title">体重</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue field="MALE_WEIGHT" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue field="FEMALE_WEIGHT" defaultValue="" onlyValue="true"/>
						<%}%>千克
						</td>
					</tr>                                    
					<tr>
						<td class="edit-data-title">体重指数</td>
						<td class="edit-data-value" colspan="4">
						<%if("1".equals(ADOPTER_SEX)){%>
							<BZ:dataValue field="MALE_BMI" defaultValue="" onlyValue="true"/>
						<%}else{%>
							<BZ:dataValue field="FEMALE_BMI" defaultValue="" onlyValue="true"/>						
						<%}%>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">违法行为及刑事处罚</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue field="MALE_PUNISHMENT_FLAG" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
						</td>
						<td class="edit-data-value" colspan="3">
							<BZ:dataValue field="MALE_PUNISHMENT_CN" defaultValue=""/>
						</td>
						<%}else{%>
						<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
						</td>
						<td class="edit-data-value" colspan="3">
							<BZ:dataValue field="FEMALE_PUNISHMENT_CN" defaultValue=""/>
						</td>
						<%}%>
					</tr>
					<tr>
						<td class="edit-data-title">有无不良嗜好</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue field="MALE_ILLEGALACT_FLAG" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
						</td>
						<td class="edit-data-value" colspan="3">
							<BZ:dataValue field="MALE_ILLEGALACT_CN" defaultValue=""/>
						</td>
						<%}else{%>
						<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
						</td>
						<td class="edit-data-value" colspan="3">
							<BZ:dataValue field="FEMALE_ILLEGALACT_CN" defaultValue=""/>
						</td>
						<%}%>									
					</tr>
					<tr>
						<td class="edit-data-title">宗教信仰</td>
						<td class="edit-data-value">
						<%if("1".equals(ADOPTER_SEX)){%>
						<BZ:dataValue field="MALE_RELIGION_CN" defaultValue="" onlyValue="true"/>
						<%}else{%>
						<BZ:dataValue field="FEMALE_RELIGION_CN" defaultValue="" onlyValue="true"/>
						<%}%>
						</td>
						<td class="edit-data-title">婚姻状况</td>
						<td class="edit-data-value" colspan="2">
						<BZ:dataValue codeName="ADOPTER_MARRYCOND" field="MARRY_CONDITION" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">同居伙伴</td>
						<td class="edit-data-value">
							<BZ:dataValue field="CONABITA_PARTNERS" defaultValue="" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
						</td>
						<td class="edit-data-title">同居时长</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="CONABITA_PARTNERS_TIME" defaultValue=""/> 年
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">非同性恋声明</td>
						<td class="edit-data-value" colspan="4">
							<BZ:dataValue field="GAY_STATEMENT" defaultValue="" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">货币单位</td>
						<td class="edit-data-value">
						<BZ:dataValue codeName="HBBZ" field="CURRENCY" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">年收入</td>
						<td class="edit-data-value" colspan="2">
						<BZ:dataValue field="MALE_YEAR_INCOME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">家庭总资产</td>
						<td class="edit-data-value"><BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/></td>
						<td class="edit-data-title">家庭总债务</td>
						<td class="edit-data-value" colspan="2"><BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/></td>
					</tr>
					<tr>
						<td class="edit-data-title">家庭净资产</td>
						<td class="edit-data-value" colspan="4">
							<script>
							document.write(_setTotalManny('<BZ:dataValue field="TOTAL_ASSET" onlyValue="true"/>','<BZ:dataValue field="TOTAL_DEBT" onlyValue="true"/>'));
							</script>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">18周岁以下子女数量</td>
						<td class="edit-data-value" colspan="4"><BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/> 个
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">子女数量及情况</td>
						<td class="edit-data-value" colspan="4"><BZ:dataValue field="CHILD_CONDITION_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">家庭住址</td>
						<td class="edit-data-value" colspan="4"><BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">收养要求</td>
						<td class="edit-data-value" colspan="4"><BZ:dataValue field="ADOPT_REQUEST_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
				<table class="specialtable">
					<tr>
						<td class="edit-data-title" colspan="6" style="text-align:center"><b>家庭调查及组织意见信息</b></td>
					</tr>
					<tr>
						<td class="edit-data-title">完成家调组织名称</td>
						<td class="edit-data-value" colspan="5"><BZ:dataValue field="HOMESTUDY_ORG_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" style="width:15%">家庭报告完成日期</td>
						<td class="edit-data-value" style="width:18%"><BZ:dataValue type="date" field="FINISH_DATE" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" style="width:15%">会见次数（次）</td>
						<td class="edit-data-value" style="width:18%"><BZ:dataValue field="INTERVIEW_TIMES" defaultValue="" onlyValue="true"/>
						</td>                                    
						<td class="edit-data-title" style="width:15%">推荐信（封）</td>
						<td class="edit-data-value" style="width:19%"><BZ:dataValue field="RECOMMENDATION_NUM" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">心理评估报告</td>
						<td class="edit-data-value"><BZ:dataValue codeName="ADOPTER_HEART_REPORT" field="HEART_REPORT" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">收养动机</td>
						<td class="edit-data-value"><BZ:dataValue codeName="ADOPTER_ADOPT_MOTIVATION" field="ADOPT_MOTIVATION" defaultValue="" onlyValue="true"/>
						</td>								
						<td class="edit-data-title">家中10周岁及以上孩子对收养的意见</td>
						<td class="edit-data-value"><BZ:dataValue codeName="ADOPTER_CHILDREN_ABOVE" field="CHILDREN_ABOVE" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">有无指定监护人</td>
						<td class="edit-data-value"><BZ:dataValue field="IS_FORMULATE" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
						</td>
						<td class="edit-data-title">不遗弃不虐待声明</td>
						<td class="edit-data-value"><BZ:dataValue field="IS_ABUSE_ABANDON" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
						</td>
					
						<td class="edit-data-title">抚育计划</td>
						<td class="edit-data-value"><BZ:dataValue field="IS_MEDICALRECOVERY" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">收养前准备</td>
						<td class="edit-data-value"><BZ:dataValue field="ADOPT_PREPARE" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
						</td>
						<td class="edit-data-title">风险意识</td>
						<td class="edit-data-value"><BZ:dataValue field="RISK_AWARENESS" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
						</td>							   
						<td class="edit-data-title">同意递交安置后报告声明</td>
						<td class="edit-data-value"><BZ:dataValue field="IS_SUBMIT_REPORT" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
						</td>
					</tr>                                    
					<tr>
						<td class="edit-data-title">育儿经验</td>
						<td class="edit-data-value"><BZ:dataValue field="PARENTING" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
						</td>
						<td class="edit-data-title">社工意见</td>
						<td class="edit-data-value"><BZ:dataValue codeName="SGYJ" field="SOCIALWORKER" defaultValue="" onlyValue="true"/>										
						</td>
						<td class="edit-data-title">&nbsp;</td>
						<td class="edit-data-value">&nbsp;</td>
					</tr>
					<tr>
						<td class="edit-data-title">家中有无其他人同住</td>
						<td class="edit-data-value"><BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
						</td>
						<td class="edit-data-title">家中其他人同住说明</td>
						<td class="edit-data-value" colspan="3"><BZ:dataValue field="IS_FAMILY_OTHERS_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">家庭需说明的其他事项</td>
						<td class="edit-data-value" colspan="5"><BZ:dataValue field="REMARK_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" colspan="6" style="text-align:center"><b>政府批准信息</b></td>
					</tr>
					<tr>
						<td class="edit-data-title">批准日期</td>
						<td class="edit-data-value"><BZ:dataValue type="date" field="GOVERN_DATE" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">有效期限</td>
						<td class="edit-data-value">
						<div id="FE_VALID_PERIOD"></div>
						</td>
						<td class="edit-data-title">批准儿童数量</td>
						<td class="edit-data-value"><BZ:dataValue field="APPROVE_CHILD_NUM" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">收养儿童年龄</td>
						<td class="edit-data-value">
						<BZ:dataValue field="AGE_FLOOR" defaultValue="" onlyValue="true"/>岁~
						<BZ:dataValue field="AGE_UPPER" defaultValue="" onlyValue="true"/>岁
						</td>
						<td class="edit-data-title">收养儿童性别</td>
						<td class="edit-data-value">
						<BZ:dataValue codeName="ADOPTER_CHILDREN_SEX" field="CHILDREN_SEX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">收养儿童健康状况</td>
						<td class="edit-data-value">
						<BZ:dataValue codeName="ADOPTER_CHILDREN_HEALTH" field="CHILDREN_HEALTH_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" colspan="6" style="text-align:center">
						<b>附件信息</b></td>										
					</tr>
					<tr>
						<td colspan="6">
						<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattview.action?bigType=AF&packID=<%=AttConstants.AF_SIGNALPARENT%>&packageID=<BZ:dataValue field="PACKAGE_ID_CN" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table> 
	<!--单亲收养：end-->			
	</BZ:body>
</BZ:html>
