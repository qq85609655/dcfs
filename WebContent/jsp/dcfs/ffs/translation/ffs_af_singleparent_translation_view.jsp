<%
/**   
 * @Title: ffs_af_singleparent_translation.jsp
 * @Description:  文件翻译页（单亲收养）
 * @author wangz   
 * @date 2014-8-11 上午10:00:00 
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
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
    <title>文件翻译页（单亲收养）</title>
    <BZ:webScript edit="true"/>
    <script type="text/javascript" src="<%=path%>/resource/js/common.js"></script>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" ></link>
    <script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"></script>	
</BZ:head>

<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND;SEX;">

<script type="text/javascript">
	var path = "<%=path%>";
	$(document).ready( function() {
			//dyniframesize(['mainFrame']);//公共功能，框架元素自适应
		    $('#tab-container').easytabs();
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

	//关闭
	function _close(){
		window.close();
	}
	
	//-----  下面是打印控制语句  ----------
	window.onbeforeprint=beforeCNPrint;
	window.onafterprint=afterCNPrint;
	//打印之前隐藏不想打印出来的信息
	function beforeCNPrint()
	{
		_title.style.display='none';
		tab2.style.display='none';
		attarea1.style.display='none';
		attarea2.style.display='none';
		buttonarea.style.display='none';
		tranarea.style.display='none';
	}
	//打印之后将隐藏掉的信息再显示出来
	function afterCNPrint()
	{
		_title.style.display='';
		attarea1.style.display='';
		attarea2.style.display='';
		buttonarea.style.display='';
		tranarea.style.display='';
	}
	
	</script>
	<div id="tab-container" class='tab-container'>
		<ul class='etabs' id="_title">
				<li class='tab' id="tb1"><a href="#tab1">基本信息(中文)</a></li>
				<li class='tab' id="tb2"><a href="#tab2">基本信息(外文)</a></li>
		</ul>
		<div class='panel-container'>
			<!--家庭基本情况(中)：start-->
			<div id="tab1">
				<!--文件基本信息：start-->
				<table class="specialtable">
					<tr>
						<td class="edit-data-title" width="15%">收养组织(CN)</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">收养组织(EN)</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">文件类型</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">收养类型</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">收文编号</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
				<!--文件基本信息：end-->                   
				<!--单亲收养：start-->
				<table id="tb_dqsy_cn" class="specialtable">
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
									<td class="edit-data-value" width="18%" rowspan="6">
										<%if("1".equals(ADOPTER_SEX)){%>
										<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:150px;">
										<%}else{%>
										<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:150px;">
										<%}%>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">出生日期</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
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
									<td class="edit-data-title">受教育程度</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue codeName="ADOPTER_EDU" field="MALE_EDUCATION" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue  codeName="ADOPTER_EDU" field="FEMALE_EDUCATION" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
									<td class="edit-data-title">职业</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">健康状况</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue codeName="ADOPTER_HEALTH" field="MALE_HEALTH" defaultValue="" onlyValue="true"/>
									</td>
									<td class="edit-data-value" colspan="2">
										<BZ:dataValue field="MALE_HEALTH_CONTENT_CN" defaultValue="" onlyValue="true"/>
									</td>
									<%}else{%><BZ:dataValue codeName="ADOPTER_HEALTH" field="FEMALE_HEALTH" defaultValue="" onlyValue="true"/>
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
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_HEIGHT" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_HEIGHT" defaultValue="" onlyValue="true"/>
									<%}%>厘米
									</td>
									<td class="edit-data-title">体重</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_WEIGHT" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_WEIGHT" defaultValue="" onlyValue="true"/>
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
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_RELIGION_CN" defaultValue=""/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_RELIGION_CN" defaultValue=""/>
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
									<BZ:dataValue type="String" field="MALE_YEAR_INCOME" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">家庭总资产</td>
									<td class="edit-data-value"><BZ:dataValue type="String" field="TOTAL_ASSET" defaultValue=""/></td>
									<td class="edit-data-title">家庭总债务</td>
									<td class="edit-data-value" colspan="2"><BZ:dataValue type="String" field="TOTAL_DEBT" defaultValue=""/></td>
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
									<td class="edit-data-value" colspan="4"><BZ:dataValue type="String" field="UNDERAGE_NUM" defaultValue=""/> 个
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">子女数量及情况</td>
									<td class="edit-data-value" colspan="4"><BZ:dataValue type="String" field="CHILD_CONDITION_CN" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">家庭住址</td>
									<td class="edit-data-value" colspan="4"><BZ:dataValue type="String" field="ADDRESS" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">收养要求</td>
									<td class="edit-data-value" colspan="4"><BZ:dataValue type="String" field="ADOPT_REQUEST_CN" defaultValue=""/>
									</td>
								</tr>
							</table>
							<table class="specialtable">
								<tr>
									<td class="edit-data-title" colspan="6" style="text-align:center"><b>家庭调查及组织意见信息</b></td>
								</tr>
								<tr>
									<td class="edit-data-title">完成家调组织名称</td>
									<td class="edit-data-value" colspan="5"><BZ:dataValue type="String" field="HOMESTUDY_ORG_NAME" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title" style="width:15%">家庭报告完成日期</td>
									<td class="edit-data-value" style="width:18%"><BZ:dataValue type="date" field="FINISH_DATE" defaultValue=""/>
									</td>
									<td class="edit-data-title" style="width:15%">会见次数（次）</td>
									<td class="edit-data-value" style="width:18%"><BZ:dataValue type="String" field="INTERVIEW_TIMES" defaultValue=""/>
									</td>                                    
									<td class="edit-data-title" style="width:15%">推荐信（封）</td>
									<td class="edit-data-value" style="width:19%"><BZ:dataValue type="String" field="RECOMMENDATION_NUM" defaultValue=""/>
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
									<td class="edit-data-value"><BZ:dataValue field="SOCIALWORKER" defaultValue="" onlyValue="true" checkValue="1=支持;2=保留意见;3=不支持"/>										
									</td>
									<td class="edit-data-title">&nbsp;</td>
									<td class="edit-data-value">&nbsp;</td>
								</tr>
								<tr>
									<td class="edit-data-title">家中有无其他人同住</td>
									<td class="edit-data-value"><BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
									</td>
									<td class="edit-data-title">家中其他人同住说明</td>
									<td class="edit-data-value" colspan="3"><BZ:dataValue type="String" field="IS_FAMILY_OTHERS_CN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">家庭需说明的其他事项</td>
									<td class="edit-data-value" colspan="5"><BZ:dataValue type="String" field="REMARK_CN" defaultValue="" onlyValue="true"/>
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
										<script>											
											var v = "<BZ:dataValue field="VALID_PERIOD" onlyValue="true"/>";
											document.write(("-1"!=v)?v+" 月":"长期");											
										</script>
									</td>
									<td class="edit-data-title">批准儿童数量</td>
									<td class="edit-data-value"><BZ:dataValue type="String" field="APPROVE_CHILD_NUM" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">收养儿童年龄</td>
									<td class="edit-data-value"><BZ:dataValue type="String" field="AGE_FLOOR" defaultValue="" onlyValue="true"/>岁~<BZ:dataValue type="String" field="AGE_UPPER" defaultValue="" onlyValue="true"/>岁
									</td>
									<td class="edit-data-title">收养儿童性别</td>
									<td class="edit-data-value"><BZ:dataValue codeName="ADOPTER_CHILDREN_SEX" field="CHILDREN_SEX" defaultValue="" onlyValue="true"/>
									</td>
									<td class="edit-data-title">收养儿童健康状况</td>
									<td class="edit-data-value"><BZ:dataValue codeName="ADOPTER_CHILDREN_HEALTH" field="CHILDREN_HEALTH_EN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr id="attarea1">
									<td class="edit-data-title" colspan="6" style="text-align:center">
									<b>附件信息</b></td>										
								</tr>
								<tr id="attarea2">
									<td colspan="6">
									<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattview.action?bigType=AF&packID=<%=AttConstants.AF_SIGNALPARENT%>&packageID=<BZ:dataValue field="PACKAGE_ID_CN" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table> 
				<!--单亲收养：end-->
			</div>
			<!--家庭基本情况(中)：end-->
			<!--家庭基本情况(外)：start-->
			<div id="tab2">
				<!--文件基本信息：start-->
				<table class="specialtable">
					<tr>
						<td class="edit-data-title" width="15%">收养组织(CN)</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">收养组织(EN)</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">文件类型</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">收养类型</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">收文编号</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FILE_NO" hrefTitle="收文编号" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
				<!--文件基本信息：end-->                   
				<!--单亲收养(EN)：start-->
				<table id="tb_dqsy_cn" class="specialtable">
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
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_NAME" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
									
									<td class="edit-data-title" width="15%">性别</td>
									<td class="edit-data-value" width="26%">
									<BZ:dataValue codeName="SEX" field="ADOPTER_SEX" defaultValue="" onlyValue="true"/>
									</td>
									
									<td class="edit-data-value" width="18%" rowspan="6">
										<%if("1".equals(ADOPTER_SEX)){%>
										<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:150px;">
										<%}else{%>
										<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:150px;">
										<%}%>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">出生日期</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="date" field="MALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="date" field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true"/>
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
									<td class="edit-data-title">受教育程度</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue codeName="ADOPTER_EDU" field="MALE_EDUCATION" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue  codeName="ADOPTER_EDU" field="FEMALE_EDUCATION" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
									<td class="edit-data-title">职业</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_JOB_EN" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_JOB_EN" defaultValue="" onlyValue="true"/>
									<%}%>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">健康状况</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue codeName="ADOPTER_HEALTH" field="MALE_HEALTH" defaultValue="" onlyValue="true"/>
									</td>
									<td class="edit-data-value" colspan="2">
										<BZ:dataValue field="MALE_HEALTH_CONTENT_EN" defaultValue="" onlyValue="true"/>
									</td>
									<%}else{%><BZ:dataValue codeName="ADOPTER_HEALTH" field="FEMALE_HEALTH" defaultValue="" onlyValue="true"/>
									</td>
									<td class="edit-data-value" colspan="2">
										<BZ:dataValue field="FEMALE_HEALTH_CONTENT_EN" defaultValue="" onlyValue="true"/>
									</td>
									<%}%>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">身高</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_HEIGHT" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_HEIGHT" defaultValue="" onlyValue="true"/>
									<%}%>厘米
									</td>
									<td class="edit-data-title">体重</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_WEIGHT" defaultValue="" onlyValue="true"/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_WEIGHT" defaultValue="" onlyValue="true"/>
									<%}%>千克
									</td>
								</tr>                                    
								<tr>
									<td class="edit-data-title">体重指数</td>
									<td class="edit-data-value" colspan="4">
									<%if("1".equals(ADOPTER_SEX)){%>
									<script>
										document.write(_bmi(<BZ:dataValue field="MALE_HEIGHT" onlyValue="true"/>/100,<BZ:dataValue field="MALE_WEIGHT" onlyValue="true"/>));
									</script>
									<%}else{%>
									<script>
										document.write(_bmi(<BZ:dataValue field="FEMALE_HEIGHT" onlyValue="true"/>/100,<BZ:dataValue field="FEMALE_WEIGHT" onlyValue="true"/>));
									</script>
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
										<BZ:dataValue field="MALE_PUNISHMENT_EN" defaultValue=""/>
									</td>
									<%}else{%>
									<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
									</td>
									<td class="edit-data-value" colspan="3">
										<BZ:dataValue field="FEMALE_PUNISHMENT_EN" defaultValue=""/>
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
										<BZ:dataValue field="MALE_ILLEGALACT_EN" defaultValue=""/>
									</td>
									<%}else{%>
									<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>
									</td>
									<td class="edit-data-value" colspan="3">
										<BZ:dataValue field="FEMALE_ILLEGALACT_EN" defaultValue=""/>
									</td>
									<%}%>									
								</tr>
								<tr>
									<td class="edit-data-title">宗教信仰</td>
									<td class="edit-data-value">
									<%if("1".equals(ADOPTER_SEX)){%><BZ:dataValue type="String" field="MALE_RELIGION_EN" defaultValue=""/>
									<%}else{%><BZ:dataValue type="String" field="FEMALE_RELIGION_EN" defaultValue=""/>
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
									<BZ:dataValue type="String" field="MALE_YEAR_INCOME" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">家庭总资产</td>
									<td class="edit-data-value"><BZ:dataValue type="String" field="TOTAL_ASSET" defaultValue=""/></td>
									<td class="edit-data-title">家庭总债务</td>
									<td class="edit-data-value" colspan="2"><BZ:dataValue type="String" field="TOTAL_DEBT" defaultValue=""/></td>
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
									<td class="edit-data-value" colspan="4"><BZ:dataValue type="String" field="UNDERAGE_NUM" defaultValue=""/> 个
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">子女数量及情况</td>
									<td class="edit-data-value" colspan="4"><BZ:dataValue type="String" field="CHILD_CONDITION_EN" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">家庭住址</td>
									<td class="edit-data-value" colspan="4"><BZ:dataValue type="String" field="ADDRESS" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">收养要求</td>
									<td class="edit-data-value" colspan="4"><BZ:dataValue type="String" field="ADOPT_REQUEST_EN" defaultValue=""/>
									</td>
								</tr>
							</table>
							<table class="specialtable">
								<tr>
									<td class="edit-data-title" colspan="6" style="text-align:center"><b>家庭调查及组织意见信息</b></td>
								</tr>
								<tr>
									<td class="edit-data-title">完成家调组织名称</td>
									<td class="edit-data-value" colspan="5"><BZ:dataValue type="String" field="HOMESTUDY_ORG_NAME" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title" style="width:15%">家庭报告完成日期</td>
									<td class="edit-data-value" style="width:18%"><BZ:dataValue type="date" field="FINISH_DATE" defaultValue=""/>
									</td>
									<td class="edit-data-title" style="width:15%">会见次数（次）</td>
									<td class="edit-data-value" style="width:18%"><BZ:dataValue type="String" field="INTERVIEW_TIMES" defaultValue=""/>
									</td>                                    
									<td class="edit-data-title" style="width:15%">推荐信（封）</td>
									<td class="edit-data-value" style="width:19%"><BZ:dataValue type="String" field="RECOMMENDATION_NUM" defaultValue=""/>
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
									<td class="edit-data-value"><BZ:dataValue field="SOCIALWORKER" defaultValue="" onlyValue="true" checkValue="1=支持;2=保留意见;3=不支持"/>										
									</td>
									<td class="edit-data-title">&nbsp;</td>
									<td class="edit-data-value">&nbsp;</td>
								</tr>
								<tr>
									<td class="edit-data-title">家中有无其他人同住</td>
									<td class="edit-data-value"><BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" onlyValue="true" defaultValue="" defaultValue="" checkValue="0=无;1=有"/>
									</td>
									<td class="edit-data-title">家中其他人同住说明</td>
									<td class="edit-data-value" colspan="3"><BZ:dataValue type="String" field="IS_FAMILY_OTHERS_EN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">家庭需说明的其他事项</td>
									<td class="edit-data-value" colspan="5"><BZ:dataValue type="String" field="REMARK_EN" defaultValue="" onlyValue="true"/>
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
									<td class="edit-data-value"><BZ:dataValue field="VALID_PERIOD_TYPE" onlyValue="true" defaultValue="" checkValue="1=有效期限;2=长期"/>
										<script>											
											var v = "<BZ:dataValue field="VALID_PERIOD" onlyValue="true"/>";
											document.write(("-1"!=v)?v+" 月":"长期");											
										</script>
									</td>
									<td class="edit-data-title">批准儿童数量</td>
									<td class="edit-data-value"><BZ:dataValue type="String" field="APPROVE_CHILD_NUM" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">收养儿童年龄</td>
									<td class="edit-data-value"><BZ:dataValue type="String" field="AGE_FLOOR" defaultValue="" onlyValue="true"/>岁~<BZ:dataValue type="String" field="AGE_UPPER" defaultValue="" onlyValue="true"/>岁
									</td>
									<td class="edit-data-title">收养儿童性别</td>
									<td class="edit-data-value"><BZ:dataValue codeName="ADOPTER_CHILDREN_SEX" field="CHILDREN_SEX" defaultValue="" onlyValue="true"/>
									</td>
									<td class="edit-data-title">收养儿童健康状况</td>
									<td class="edit-data-value"><BZ:dataValue codeName="ADOPTER_CHILDREN_HEALTH" field="CHILDREN_HEALTH_EN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title" colspan="6" style="text-align:center">
									<b>附件信息</b></td>										
								</tr>
								<tr>
									<td colspan="6">
									<IFRAME ID="frmUpload1" SRC="<%=path%>/common/batchattview.action?bigType=AF&packID=<%=AttConstants.AF_SIGNALPARENT%>&packageID=<BZ:dataValue field="PACKAGE_ID" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table> 
				<!--单亲收养：end-->
			</div>  	
			<!--家庭基本情况(外)：end-->                                
		</div>
	</div>
	<!--翻译信息：start-->
	<div id="tranarea">
		<table class="specialtable" align="center" style="width:98%;text-align:center">
			<tr>
				<td class="edit-data-title" colspan="6" style="text-align:center"><b>翻译信息</b></td>
			</tr>
			<tr>
				<td  class="edit-data-title" width="15%">翻译通知人</td>
				<td  class="edit-data-value"><BZ:dataValue field="NOTICE_USERNAME" defaultValue="" onlyValue="true"/></td>
				<td  class="edit-data-title" width="15%">通知日期</td>
				<td  class="edit-data-value"><BZ:dataValue field="NOTICE_DATE" type="date" defaultValue="" onlyValue="true"/></td>
				<td  class="edit-data-title" width="15%">接收日期</td>
				<td  class="edit-data-value"><BZ:dataValue field="RECEIVE_DATE" type="date" defaultValue="" onlyValue="true"/></td>
			</tr>
			<tr>
				<td  class="edit-data-title" width="15%">翻译单位</td>
				<td  class="edit-data-value"><BZ:dataValue field="TRANSLATION_UNITNAME"  defaultValue="" onlyValue="true"/></td>
				<td  class="edit-data-title" width="15%">翻译人</td>
				<td  class="edit-data-value"><BZ:dataValue field="TRANSLATION_USERNAME"  defaultValue="" onlyValue="true"/></td>
				<td  class="edit-data-title" width="15%">完成日期</td>
				<td  class="edit-data-value"><BZ:dataValue field="COMPLETE_DATE" type="date" defaultValue="" onlyValue="true"/></td>
			</tr>
			<tr>
				<td  class="edit-data-title" width="15%">翻译状态</td>
				<td  class="edit-data-value" colspan="5"><BZ:dataValue field="TRANSLATION_STATE"  defaultValue="" onlyValue="true" checkValue="0=待翻译;1=翻译中;2=已翻译"/></td>
			</tr>
			<tr>
				<td  class="edit-data-title" width="15%">翻译说明</td>
				<td  class="edit-data-value" colspan="5"><BZ:dataValue field="TRANSLATION_DESC"  defaultValue="" onlyValue="true"/></td>
			</tr>
		</table>
	</div>
	<br>
		<!-- 按钮区域:begin -->
		<div class="bz-action-frame" style="text-align:center">
			<div class="bz-action-edit" desc="按钮区" id="buttonarea">
				<input type="button" value="打&nbsp;&nbsp;印" class="btn btn-sm btn-primary" onclick="beforeCNPrint();javascript:window.print();afterCNPrint();"/>&nbsp;&nbsp;
				<input type="button" value="关&nbsp;&nbsp;闭" class="btn btn-sm btn-primary" onclick="_close();"/>
			</div>
		</div>
		<!-- 按钮区域:end -->
	</BZ:body>
</BZ:html>
