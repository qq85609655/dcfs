<%
/**   
 * @Title: parents_cn_view.jsp
 * @Description:  双亲收养文件_英文_显示
 * @author wangzheng   
 * @date 2014-10-29
 * @version V1.0   
 */
%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="java.util.Map"%>

<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>

<%
	String path = request.getContextPath();
	String xmlstr = (String)request.getAttribute("xmlstr");
	Data d = (Data)request.getAttribute("data");
	String orgId = d.getString("ADOPT_ORG_ID","");
	String afId = d.getString("AF_ID","");
	String strPar = "org_id="+orgId + ";af_id=" + afId;
	String strPar1 = "org_id="+orgId + ",af_id=" + afId;
%>
<BZ:html>
<BZ:head>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
    <title>收养文件中文</title>
    <BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=path%>/resource/js/common.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
	<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
</BZ:head>
<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND;SGYJ">
	<script type="text/javascript">
		//附件上传-接受返回值	
		var path = "<%=path%>";		
		var male_health = "<BZ:dataValue type="String" field="MALE_HEALTH" defaultValue="1" onlyValue="true"/>";		//男收养人的健康状况
		var female_health = "<BZ:dataValue type="String" field="FEMALE_HEALTH" defaultValue="1" onlyValue="true"/>";	//女收养人的健康状况		
		//var measurement = "<BZ:dataValue type="String" field="MEASUREMENT" defaultValue="0" onlyValue="true"/>";		//计量单位
		var MALE_PUNISHMENT_FLAG = "<BZ:dataValue type="String" field="MALE_PUNISHMENT_FLAG" defaultValue="0" onlyValue="true"/>";	//男收养人违法行为及刑事处罚
		var FEMALE_PUNISHMENT_FLAG = "<BZ:dataValue type="String" field="FEMALE_PUNISHMENT_FLAG" defaultValue="0" onlyValue="true"/>";	//女收养人违法行为及刑事处罚
		var MALE_ILLEGALACT_FLAG = "<BZ:dataValue type="String" field="MALE_ILLEGALACT_FLAG" defaultValue="0" onlyValue="true"/>";	//男收养人有无不良嗜好
		var FEMALE_ILLEGALACT_FLAG = "<BZ:dataValue type="String" field="FEMALE_ILLEGALACT_FLAG" defaultValue="0" onlyValue="true"/>";	//女收养人有无不良嗜好		

		var MARRY_DATE = '<BZ:dataValue type="date" field="MARRY_DATE" defaultValue="" onlyValue="true"/>';		//结婚日期
		var TOTAL_ASSET = "<BZ:dataValue type="String" field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>";		//家庭总资产
		var TOTAL_DEBT = "<BZ:dataValue type="String" field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>";		//家庭总债务
		var VALID_PERIOD= "<BZ:dataValue type="String" field="VALID_PERIOD" defaultValue="" onlyValue="true"/>";	//有效期限
		
		$(document).ready( function() {
			//加载iframe
			dyniframesize(['iframe','mainFrame']);//公共功能，框架元素自适应

		   
			//初始化健康状况说明的显示与隐藏
			_setMale_health(male_health);
			_setFemale_health(female_health);
			//设置身高、体重的显示方式（公制、英制）
			//_setMeasurement(measurement);
			
			//设置BMI
			//_setBMI("1");
			//_setBMI("2");
			
			
			//初始化设置违法行为及刑事处罚
			_setMALE_PUNISHMENT_FLAG(MALE_PUNISHMENT_FLAG);
			_setFEMALE_PUNISHMENT_FLAG(FEMALE_PUNISHMENT_FLAG);
			
			//初始化设置有无不良嗜好
			_setMALE_ILLEGALACT_FLAG(MALE_ILLEGALACT_FLAG);
			_setFEMALE_ILLEGALACT_FLAG(FEMALE_ILLEGALACT_FLAG);
			//设置结婚时长
			
			_setMarryLength(MARRY_DATE);
			//设置家庭净资产
			_setTotalManny(TOTAL_ASSET,TOTAL_DEBT);
			//设置有效期限
			_setValidPeriod(VALID_PERIOD);
		})
	
	
	/*
	* 健康状况设置，选择不健康后，显示健康情况说明
	* p=2 不健康 p=1 健康
	*/
	function _setMale_health(p){		
		if("2"== p){
			$("#FE_MALE_HEALTH_CONTENT_EN").show();			
		}else{
			$("#FE_MALE_HEALTH_CONTENT_EN").hide();
		}
	}
	function _setFemale_health(p){
		if("2"== p){
			$("#FE_FEMALE_HEALTH_CONTENT_EN").show();			
		}else{
			$("#FE_FEMALE_HEALTH_CONTENT_EN").hide();
		}			
	}	
	
	/*
	* 设置男收养人违法行为及刑事处罚	
	*f 0：无 1:有
	*/
	function _setMALE_PUNISHMENT_FLAG(f){
		if(f == "1"){	
			$("#FE_MALE_PUNISHMENT_EN").show();
		}else{
			$("#FE_MALE_PUNISHMENT_EN").hide();
		}	
	}

	//设置女收养人违法行为及刑事处罚
	function _setFEMALE_PUNISHMENT_FLAG(f){
		if(f == "1"){
			$("#FE_FEMALE_PUNISHMENT_EN").show();
		}else{
			$("#FE_FEMALE_PUNISHMENT_EN").hide();
		}			
	}

	//设置有无不良嗜好
	function _setMALE_ILLEGALACT_FLAG(f){
		if("1" == f){
			$("#FE_MALE_ILLEGALACT_EN").show();
		}else{
			$("#FE_MALE_ILLEGALACT_EN").hide();
		}			
	}
	
	//设置有无不良嗜好
	function _setFEMALE_ILLEGALACT_FLAG(f){
		if(f == "1"){
			$("#FE_FEMALE_ILLEGALACT_EN").show();
		}else{
			$("#FE_FEMALE_ILLEGALACT_EN").hide();
		}			
	}
	
	/*
	* 设置结婚时长
	* d：结婚日期
	*/
	function _setMarryLength(d){		
		$("#FE_MARRY_LENGTH").text(getAge(d));
	}

	
	/*
	* 设置家庭净资产
	*/
	function _setTotalManny(a,d){
		if(a=="" || d==""){
			return;
		}		
		$("#FE_TOTAL_MANNY").text(a - d);
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
	</script>

	<!--双亲收养：start-->                            	  
	<table class="specialtable">
		<tr>
			 <td class="edit-data-title" style="text-align:center"><b>收养人基本信息</b></td>
		</tr>
		<tr>
			<td>
				<table class="specialtable">
					<tr>                                    	
						<td class="edit-data-title" width="15%">&nbsp;</td>
						<td class="edit-data-title" colspan="2" style="text-align:center">男收养人</td>
						<td class="edit-data-title" colspan="2" style="text-align:center">女收养人</td>
					</tr>
					<tr>
						<td class="edit-data-title" width="15%">姓名</td>
						<td class="edit-data-value" width="27%">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>							
						</td>
						<td class="edit-data-value" width="15%" rowspan="5">							
							<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:150px;">
						</td>
						<td class="edit-data-value" width="28%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-value" width="15%" rowspan="5">
							<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:150px;">							
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">出生日期</td>
						<td class="edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY" type="date" defaultValue="" onlyValue="true"/>								
						</td>
						<td class="edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY" type="date" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">年龄</td>
						<td class="edit-data-value">
							<div id="MALE_AGE" style="font-size:14px">
							<script>								
							document.write(getAge('<BZ:dataValue field="MALE_BIRTHDAY" type="date" defaultValue="" onlyValue="true"/>'));
							</script>
							</div>
						</td>
						<td class="edit-data-value" style="font-size:14px">
							<div id="FEMALE_AGE" style="font-size:14px">
							<script>								
							document.write(getAge('<BZ:dataValue field="FEMALE_BIRTHDAY" type="date" defaultValue="" onlyValue="true"/>'));
							</script>
							</div>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">国籍</td>
						<td class="edit-data-value">
							<BZ:dataValue codeName="GJ" field="MALE_NATION"  defaultValue="" onlyValue="true"/>							
						</td>
						<td class="edit-data-value">
							<BZ:dataValue codeName="GJ" field="FEMALE_NATION"  defaultValue="" onlyValue="true"/>							
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">护照号码</td>
						<td class="edit-data-value">
							<BZ:dataValue field="MALE_PASSPORT_NO"  defaultValue="" onlyValue="true"/>							
						</td>
						<td class="edit-data-value">
							<BZ:dataValue field="FEMALE_PASSPORT_NO"  defaultValue="" onlyValue="true"/>							
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">受教育程度</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue codeName="ADOPTER_EDU" field="MALE_EDUCATION"  defaultValue="" onlyValue="true"/>							
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue codeName="ADOPTER_EDU" field="FEMALE_EDUCATION"  defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">职业</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_JOB_EN"  defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_JOB_EN"  defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">健康状况</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue codeName="ADOPTER_HEALTH" field="MALE_HEALTH"  defaultValue="" onlyValue="true"/>
							<span id="FE_MALE_HEALTH_CONTENT_EN">
							<BZ:dataValue field="MALE_HEALTH_CONTENT_EN" onlyValue="true" defaultValue=""/>
							</span>
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue codeName="ADOPTER_HEALTH" field="FEMALE_HEALTH"  defaultValue="" onlyValue="true"/>
							<span id="FE_FEMALE_HEALTH_CONTENT_EN">
							<BZ:dataValue field="FEMALE_HEALTH_CONTENT_EN" onlyValue="true" defaultValue=""/>
							</span>
						</td>
					</tr>
					 <tr>
						<td class="edit-data-title">身高</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_HEIGHT" onlyValue="true" defaultValue=""/>							
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_HEIGHT" onlyValue="true" defaultValue=""/>							
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">体重</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_WEIGHT" onlyValue="true" defaultValue=""/>							
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_WEIGHT" onlyValue="true" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">体重指数</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_BMI" onlyValue="true" defaultValue=""/>	
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_BMI" onlyValue="true" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">违法行为及刑事处罚</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_PUNISHMENT_FLAG" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>	
							<span id="FE_MALE_PUNISHMENT_EN">
							<BZ:dataValue field="MALE_PUNISHMENT_EN" onlyValue="true" defaultValue=""/>
							</span>	
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>	
							<span id="FE_FEMALE_PUNISHMENT_EN">
							<BZ:dataValue field="FEMALE_PUNISHMENT_EN" onlyValue="true" defaultValue=""/>
							</span>	
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">有无不良嗜好</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_ILLEGALACT_FLAG" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>	
							<span id="FE_MALE_ILLEGALACT_EN">
							<BZ:dataValue field="MALE_ILLEGALACT_EN" onlyValue="true" defaultValue=""/>
							</span>	
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" onlyValue="true" defaultValue="" checkValue="0=无;1=有"/>	
							<span id="FE_FEMALE_ILLEGALACT_EN">
							<BZ:dataValue field="FEMALE_ILLEGALACT_EN" onlyValue="true" defaultValue=""/>
							</span>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">宗教信仰</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_RELIGION_EN"  defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_RELIGION_EN"  defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" width="15%">婚姻状况</td>
						<td class="edit-data-value" colspan="4">已婚</td>
					</tr>
					<tr>
						<td class="edit-data-title" width="15%">结婚日期</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="MARRY_DATE"  type="date" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">婚姻时长（年）</td>
						<td class="edit-data-value" colspan="2">
							<div id="FE_MARRY_LENGTH" style="font-size:16px">&nbsp;</div>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">前婚次数</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_MARRY_TIMES"  defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_MARRY_TIMES"  defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">货币单位</td>
						<td class="edit-data-value" colspan="4">
							<BZ:dataValue codeName="HBBZ" field="CURRENCY"  defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">年收入</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="MALE_YEAR_INCOME"  defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="FEMALE_YEAR_INCOME"  defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">家庭总资产</td>
						<td class="edit-data-value">
							<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">家庭总债务</td>
						<td class="edit-data-value" colspan="2">
							<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">家庭净资产</td>
						<td class="edit-data-value" colspan="4">
							<div id="FE_TOTAL_MANNY"></div>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">18周岁以下子女数量</td>
						<td class="edit-data-value" colspan="4">
							<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">子女数量及情况</td>
						<td class="edit-data-value" colspan="4">
							<BZ:dataValue field="CHILD_CONDITION_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">家庭住址</td>
						<td class="edit-data-value" colspan="4">
							<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" width="15%">收养要求</td>
						<td class="edit-data-value" colspan="4">
							<BZ:dataValue field="ADOPT_REQUEST_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					 
				</table>
			
				<table class="specialtable">
					<tr>
						<td class="edit-data-title" colspan="6" style="text-align:center"><b>家庭调查及组织意见信息</b></td>
					</tr>
					<tr>
						<td class="edit-data-title">完成家调组织名称</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="HOMESTUDY_ORG_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" width="15%">家庭报告完成日期</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="FINISH_DATE" type="date" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">会见次数（次）</td>
						<td class="edit-data-value" width="18%">
							<BZ:dataValue field="INTERVIEW_TIMES" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title" width="15%">推荐信（封）</td>
						<td class="edit-data-value" width="19%">
							<BZ:dataValue field="RECOMMENDATION_NUM" defaultValue="" onlyValue="true"/>
					</tr>
					<tr>
						<td class="edit-data-title">心理评估报告</td>
						<td class="edit-data-value">
							<BZ:dataValue codeName="ADOPTER_HEART_REPORT" field="HEART_REPORT" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">收养动机</td>
						<td class="edit-data-value">
							<BZ:dataValue codeName="ADOPTER_ADOPT_MOTIVATION" field="HEART_REPORT" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">家中10周岁及以上孩子对收养的意见</td>
						<td class="edit-data-value">
							<BZ:dataValue codeName="ADOPTER_CHILDREN_ABOVE" field="CHILDREN_ABOVE" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>                                        
						<td class="edit-data-title">有无指定监护人</td>
						<td class="edit-data-value">
							<BZ:dataValue field="IS_FORMULATE" defaultValue="" onlyValue="true" checkValue="0=无;1=有"/>
						</td>
						<td class="edit-data-title">不遗弃不虐待声明</td>
						<td class="edit-data-value">
							<BZ:dataValue field="IS_ABUSE_ABANDON" defaultValue="" onlyValue="true" checkValue="0=无;1=有"/>
						</td>                                    
						<td class="edit-data-title">抚育计划</td>
						<td class="edit-data-value">
							<BZ:dataValue field="IS_MEDICALRECOVERY" defaultValue="" onlyValue="true" checkValue="0=无;1=有"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">收养前准备</td>
						<td class="edit-data-value">
							<BZ:dataValue field="ADOPT_PREPARE" defaultValue="" onlyValue="true" checkValue="0=无;1=有"/>
						</td>
						<td class="edit-data-title">风险意识</td>
						<td class="edit-data-value">
							<BZ:dataValue field="RISK_AWARENESS" defaultValue="" onlyValue="true" checkValue="0=无;1=有"/>
						</td>                                    
						<td class="edit-data-title">同意递交安置后报告声明</td>
						<td class="edit-data-value">
							<BZ:dataValue field="IS_SUBMIT_REPORT" defaultValue="" onlyValue="true" checkValue="0=无;1=有"/>
						</td>
					</tr>
					
					<tr>
						<td class="edit-data-title">育儿经验</td>
						<td class="edit-data-value">
							<BZ:dataValue field="PARENTING" defaultValue="" onlyValue="true" checkValue="0=无;1=有"/>
						</td>
						<td class="edit-data-title">社工意见</td>
						<td class="edit-data-value">
							<BZ:dataValue codeName="SGYJ" field="SOCIALWORKER" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">&nbsp;</td>
						<td class="edit-data-value">&nbsp;</td>
					</tr>
					<tr>
						<td class="edit-data-title">家中有无其他人同住</td>
						<td class="edit-data-value">
							<BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" defaultValue="" onlyValue="true" checkValue="0=无;1=有"/>
						</td>
						<td class="edit-data-title">家中其他人同住说明</td>
						<td class="edit-data-value" colspan="3">
							<BZ:dataValue field="IS_FAMILY_OTHERS_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title">家庭需说明的其他事项</td>
						<td class="edit-data-value" colspan="5">
							<BZ:dataValue field="REMARK_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" colspan="6" style="text-align:center"><b>政府批准信息</b></td>
					</tr>
					<tr>
						<td class="edit-data-title">批准日期</td>
						<td class="edit-data-value">
							<BZ:dataValue field="GOVERN_DATE" type="date" defaultValue="" onlyValue="true"/>
						</td>
						<td class="edit-data-title">有效期限</td>
						<td class="edit-data-value">							
							<div id="FE_VALID_PERIOD"></div>
						</td>
						<td class="edit-data-title">批准儿童数量</td>
						<td class="edit-data-value" width="19%">
							<BZ:dataValue field="APPROVE_CHILD_NUM" defaultValue="" onlyValue="true"/>
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
						<td class="edit-data-value" width="19%">
							<BZ:dataValue codeName="ADOPTER_CHILDREN_HEALTH" field="CHILDREN_HEALTH_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" colspan="1" style="text-align:center"></td>
						<td class="edit-data-title" colspan="4" style="text-align:center">
						<b>附件信息</b></td>
						<td class="edit-data-title" colspan="1" style="text-align:center">
						</td>
					</tr>
					<tr>
						<td colspan="6">
						<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&packID=<%=AttConstants.AF_PARENTS%>&packageID=<BZ:dataValue field="PACKAGE_ID" onlyValue="true"/>" frameborder=0 width="100%" ></IFRAME> 
						</td>
					</tr>					
				</table>
			</td>
		</tr>
	</table>
	</BZ:body>
</BZ:html>

