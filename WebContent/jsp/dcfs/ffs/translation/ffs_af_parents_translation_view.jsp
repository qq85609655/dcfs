<%
/**   
 * @Title: ffs_af_translation_view.jsp
 * @Description:  双亲收养文件翻译页查看
 * @author wangz   
 * @date 2014-8-20
 * @version V1.0   
 */
%>
<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
	Data d = (Data)request.getAttribute("data");
	String afId = d.getString("AF_ID");
	String MALE_PHOTO = d.getString("MALE_PHOTO","");
	String FEMALE_PHOTO = d.getString("FEMALE_PHOTO","");
%>
<BZ:html>

<BZ:head>
    <title>文件翻译页（双亲）</title>
    <BZ:webScript edit="true"/>
    <script type="text/javascript" src="<%=path%>/resource/js/common.js"></script>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"/>
</BZ:head>

<BZ:body property="data" codeNames="WJLX;SYLX;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_CHILDREN_ABOVE;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_HEALTH;ADOPTER_CHILDREN_SEX;ADOPTER_MARRYCOND">

	<script type="text/javascript">
		var path = "<%=path%>";

		$(document).ready( function() {
			//dyniframesize(['mainFrame']);//公共功能，框架元素自适应
		    $('#tab-container').easytabs();
		})
			

	//关闭
	function _close(){
		window.close();
	}

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
                <li class='tab'><a href="#tab1">基本信息(中文)</a></li>
                <li class='tab'><a href="#tab2">基本信息(外文)</a></li>
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
                    <!--双亲收养：start--> 
                    <table class="specialtable" id="tb_sqsy_cn">
                        <tr>
                             <td class="edit-data-title" style="text-align:center"><b>收养人基本信息</b></td>
                        </tr>
                        <tr>
                            <td>
                                <!--收养人信息：start-->                            	  
                                <table class="specialtable">                          	
                                    <tr>                                    	
                                        <td class="edit-data-title" width="15%">&nbsp;</td>
                                        <td class="edit-data-title" colspan="2" style="text-align:center">男收养人</td>
                                        <td class="edit-data-title" colspan="2" style="text-align:center">女收养人</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">外文姓名</td>
                                        <td class="edit-data-value" width="27%"><BZ:dataValue field="MALE_NAME" onlyValue="true"/></td>
										<td class="edit-data-value" width="15%" rowspan="5">
											<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:150px;">
										</td>
                                        <td class="edit-data-value" width="28%"><BZ:dataValue field="FEMALE_NAME" onlyValue="true"/></td>
										<td class="edit-data-value" width="15%" rowspan="5">
											<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:150px;">
										</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">出生日期</td>
                                        <td class="edit-data-value"><BZ:dataValue type="date" field="MALE_BIRTHDAY" onlyValue="true"/></td>
                                        <td class="edit-data-value"><BZ:dataValue type="date" field="FEMALE_BIRTHDAY" onlyValue="true"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">年龄</td>
                                    	<td class="edit-data-value">
                                    		<div id="tb_sqsy_cn_MALE_AGE" style="font-size:14px">
											<script>
											document.write(getAge('<BZ:dataValue type="date" field="MALE_BIRTHDAY" onlyValue="true"/>'));
                                            </script>
                                            </div>
                                    	</td>
                                    	<td class="edit-data-value" style="font-size:14px">
                                        	<div id="tb_sqsy_cn_FEMALE_AGE" style="font-size:14px">
                                    		<script>
											document.write(getAge('<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" onlyValue="true"/>'));
                                            </script>
                                            </div>
                                    	</td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">国籍</td>
                                    	<td class="edit-data-value"><BZ:dataValue field="MALE_NATION" codeName="GJ"  defaultValue=""/></td>
                                    	<td class="edit-data-value"><BZ:dataValue field="FEMALE_NATION" codeName="GJ"  defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">护照号码</td>
                                    	<td class="edit-data-value"><BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/></td>
                                    	<td class="edit-data-value"><BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">受教育程度</td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU"  defaultValue=""/></td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU"  defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">职业</td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_JOB_CN" defaultValue=""/></td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_JOB_CN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">健康状况</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>
                                        	<script>
											var h = "<BZ:dataValue field="MALE_HEALTH" onlyValue="true"/>";
											if ("2"==h){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="MALE_HEALTH_CONTENT_CN" defaultValue=""/>');
											}
											</script>
                                        	
                                        </td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>
											<script>
											var h = "<BZ:dataValue field="FEMALE_HEALTH" onlyValue="true"/>";
											if ("2"==h){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="FEMALE_HEALTH_CONTENT_CN" defaultValue=""/>');
											}
											</script>
                                    	</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">身高</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_HEIGHT" defaultValue=""/> 厘米</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_HEIGHT" defaultValue=""/> 厘米</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">体重</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_WEIGHT" defaultValue=""/> 千克</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_WEIGHT" defaultValue=""/> 千克</td>
                                    </tr>                                    
                                    <tr>
                                    	<td class="edit-data-title">体重指数</td>
                                    	<td class="edit-data-value" colspan="2">
										<script>
											document.write(_bmi(<BZ:dataValue field="MALE_HEIGHT" onlyValue="true"/>/100,<BZ:dataValue field="MALE_WEIGHT" onlyValue="true"/>));
										</script>
                                    	</td>
                                    	<td class="edit-data-value" colspan="2">
                                    	<script>
											document.write(_bmi(<BZ:dataValue field="FEMALE_HEIGHT" onlyValue="true"/>/100,<BZ:dataValue field="FEMALE_WEIGHT" onlyValue="true"/>));
										</script>
                                    	</td>
                                    </tr>
                                    <tr>
                                    <tr>
                                        <td class="edit-data-title">违法行为及刑事处罚</td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											var f = "<BZ:dataValue field="MALE_PUNISHMENT_FLAG" onlyValue="true"/>";
											document.write("0"==f?'无':'有');
											if ("1"==f){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="MALE_PUNISHMENT_CN" defaultValue=""/>');
											}
											</script>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											var f = "<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" onlyValue="true"/>";
											document.write("0"==f?'无':'有');
											if ("1"==f){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="FEMALE_PUNISHMENT_CN" defaultValue=""/>');
											}
											</script>                                        	
                                        </td>
									</tr>
                                    <tr>
                                        <td class="edit-data-title">有无不良嗜好</td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											var f = "<BZ:dataValue field="MALE_ILLEGALACT_FLAG" onlyValue="true"/>";
											document.write("0"==f?'无':'有');
											if ("1"==f){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="MALE_ILLEGALACT_CN" defaultValue=""/>');
											}
											</script>                                        	
                                        </td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											var f = "<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" onlyValue="true"/>";
											document.write("0"==f?'无':'有');
											if ("1"==f){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="FEMALE_ILLEGALACT_CN" defaultValue=""/>');
											}
											</script>                                           
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">宗教信仰</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_RELIGION_CN" defaultValue=""/></td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_RELIGION_CN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">婚姻状况</td>
                                        <td class="edit-data-value" colspan="4">已婚</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" >结婚日期</td>
                                        <td class="edit-data-value" ><BZ:dataValue field="MARRY_DATE" type="Date" defaultValue=""/></td>
                                        <td class="edit-data-title"  >婚姻时长（年）</td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											document.write(getAge('<BZ:dataValue type="Date" field="MARRY_DATE" onlyValue="true"/>'));
											</script>  											
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">前婚次数</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_MARRY_TIMES" defaultValue=""/>次
                                        </td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_MARRY_TIMES" defaultValue=""/>次
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">货币单位</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="CURRENCY" codeName="ADOPTER_HEALTH" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">年收入</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_YEAR_INCOME" defaultValue=""/></td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">家庭总资产</td>
                                        <td class="edit-data-value"><BZ:dataValue field="TOTAL_ASSET" defaultValue=""/></td>
                                        <td class="edit-data-title">家庭总债务</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="TOTAL_DEBT" defaultValue=""/></td>
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
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="UNDERAGE_NUM" defaultValue=""/> 个
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">子女数量及情况</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="CHILD_CONDITION_CN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">家庭住址</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="ADDRESS" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">收养要求</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="ADOPT_REQUEST_CN" defaultValue=""/></td>
                                    </tr>
                                </table>
                                <table class="specialtable">
                                    <tr>
                                        <td class="edit-data-title" colspan="6" style="text-align:center"><b>家庭调查及组织意见信息</b></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">完成家调组织名称</td>
                                        <td class="edit-data-value" colspan="5"><BZ:dataValue field="HOMESTUDY_ORG_NAME" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">家庭报告完成日期</td>
                                        <td class="edit-data-value" width="18%"><BZ:dataValue field="FINISH_DATE" type="Date" defaultValue=""/></td>
                                        <td class="edit-data-title" width="15%">会见次数（次）</td>
                                        <td class="edit-data-value" width="18%"><BZ:dataValue field="INTERVIEW_TIMES" defaultValue=""/></td>                                    
                                        <td class="edit-data-title" width="15%">推荐信（封）</td>
                                        <td class="edit-data-value" width="19%"><BZ:dataValue field="RECOMMENDATION_NUM" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">心理评估报告</td>
                                        <td class="edit-data-value"><BZ:dataValue field="HEART_REPORT" codeName="ADOPTER_HEART_REPORT" defaultValue=""/></td>
                                        <td class="edit-data-title">收养动机</td>
                                        <td class="edit-data-value"><BZ:dataValue field="HEART_REPORT" codeName="ADOPTER_ADOPT_MOTIVATION" defaultValue=""/></td>                                    
                                        <td class="edit-data-title">家中10周岁及以上孩子对收养的意见</td>
                                        <td class="edit-data-value"><BZ:dataValue field="CHILDREN_ABOVE" codeName="ADOPTER_CHILDREN_ABOVE" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">有无指定监护人</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_FORMULATE" onlyValue="true"/>";
											document.write("0"==f?'无':'有');											
											</script>
                                        </td>
                                        <td class="edit-data-title">不遗弃不虐待声明</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_ABUSE_ABANDON" onlyValue="true"/>";
											document.write("0"==f?'无':'有');											
											</script>
                                        </td>
                                    
                                        <td class="edit-data-title">抚育计划</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_MEDICALRECOVERY" onlyValue="true"/>";
											document.write("0"==f?'无':'有');											
											</script>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">收养前准备</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="ADOPT_PREPARE" onlyValue="true"/>";
											document.write("0"==f?'无':'有');											
											</script>
                                        </td>
                                        <td class="edit-data-title">风险意识</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="RISK_AWARENESS" onlyValue="true"/>";
											document.write("0"==f?'无':'有');											
											</script>                                            
                                        </td>
                                   
                                        <td class="edit-data-title">同意递交安置后报告声明</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_SUBMIT_REPORT" onlyValue="true"/>";
											document.write("0"==f?'无':'有');											
											</script>
                                            
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td class="edit-data-title">育儿经验</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="PARENTING" onlyValue="true"/>";
											document.write("0"==f?'无':'有');											
											</script>
                                            
                                        </td>
                                        <td class="edit-data-title">社工意见</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="SOCIALWORKER" onlyValue="true"/>";
											var txt = "";
											switch (f)
											{
											case "":
												txt = "";
												break;
											case "1":
												txt = "支持";
												break;
											case "2":
												txt = "保留意见";
												break;
											case "3":
												txt = "不支持";
												break;											
											}
											document.write(txt);											
											</script>
                                        </td>
                                        <td class="edit-data-title">&nbsp;</td>
                                        <td class="edit-data-value">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">家中有无其他人同住</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" onlyValue="true"/>";
											document.write("0"==f?'无':'有');											
											</script>
                                        </td>
                                        <td class="edit-data-title">家中其他人同住说明</td>
                                        <td class="edit-data-value" colspan="3"><BZ:dataValue field="IS_FAMILY_OTHERS_CN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">家庭需说明的其他事项</td>
                                        <td class="edit-data-value" colspan="5"><BZ:dataValue field="REMARK_CN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" colspan="6" style="text-align:center"><b>政府批准信息</b></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">批准日期</td>
                                        <td class="edit-data-value"><BZ:dataValue field="GOVERN_DATE" type="Date" defaultValue=""/></td>
                                        <td class="edit-data-title">有效期限</td>
                                        <td class="edit-data-value">
											<script>
											var v = "<BZ:dataValue field="VALID_PERIOD" onlyValue="true"/>";
											document.write(("-1"!=v)?v+" 月":"长期");											
											</script>
                                        </td>
                                        <td class="edit-data-title">批准儿童数量</td>
                                        <td class="edit-data-value"><BZ:dataValue field="APPROVE_CHILD_NUM" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">收养儿童年龄</td>
                                        <td class="edit-data-value"><BZ:dataValue field="AGE_FLOOR" defaultValue=""/>岁~ <BZ:dataValue field="AGE_UPPER" defaultValue=""/>岁</td>
                                        <td class="edit-data-title">收养儿童性别</td>
                                        <td class="edit-data-value"><BZ:dataValue field="CHILDREN_SEX" codeName="ADOPTER_CHILDREN_SEX" defaultValue=""/></td>
                                        <td class="edit-data-title">收养儿童健康状况</td>
                                        <td class="edit-data-value"><BZ:dataValue field="CHILDREN_HEALTH_EN" codeName="ADOPTER_CHILDREN_HEALTH" defaultValue=""/></td>
                                    </tr>
									<tr id="attarea1">
										<td class="edit-data-title" colspan="6" style="text-align:center">
										<b>附件信息</b></td>										
                                    </tr>
									<tr id="attarea2">
										<td colspan="6">
										<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattview.action?bigType=AF&packID=<%=AttConstants.AF_PARENTS%>&packageID=<BZ:dataValue field="PACKAGE_ID_CN" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
										</td>
									</tr>
                                </table>                                 
                            </td>
                        </tr> 
                    <!--双亲收养：end--> 
                    </table>
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
                                <BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
                            </td>
                        </tr>
                    </table>
                    <!--文件基本信息：end-->
                    <!--双亲收养：start--> 
                    <table class="specialtable" id="tb_sqsy_en">
                        <tr>
                             <td class="edit-data-title" style="text-align:center"><b>收养人基本信息</b></td>
                        </tr>
                        <tr>
                            <td>
                                <!--收养人信息：start-->                            	  
                                <table class="specialtable">                          	
                                    <tr>                                    	
                                        <td class="edit-data-title" width="15%">&nbsp;</td>
                                        <td class="edit-data-title" colspan="2" style="text-align:center">男收养人</td>
                                        <td class="edit-data-title" colspan="2" style="text-align:center">女收养人</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">外文姓名</td>
                                        <td class="edit-data-value" width="27%"><BZ:dataValue field="MALE_NAME" onlyValue="true"/></td>
										<td class="edit-data-value" width="15%" rowspan="5">
											<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:150px;">
										</td>
                                        <td class="edit-data-value" width="28%"><BZ:dataValue field="FEMALE_NAME" onlyValue="true"/></td>
										<td class="edit-data-value" width="15%" rowspan="5">
											<input type="image" src='<up:attDownload attTypeCode="AF" packageId="<%=afId%>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:150px;">
										</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">出生日期</td>
                                        <td class="edit-data-value"><BZ:dataValue type="date" field="MALE_BIRTHDAY" onlyValue="true"/></td>
                                        <td class="edit-data-value"><BZ:dataValue type="date" field="FEMALE_BIRTHDAY" onlyValue="true"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">年龄</td>
                                    	<td class="edit-data-value">
                                    		<div id="tb_sqsy_en_MALE_AGE" style="font-size:14px">
											<script>
											document.write(getAge('<BZ:dataValue type="date" field="MALE_BIRTHDAY" onlyValue="true"/>'));
                                            </script>
                                            </div>
                                    	</td>
                                    	<td class="edit-data-value" style="font-size:14px">
                                        	<div id="tb_sqsy_en_FEMALE_AGE" style="font-size:14px">
                                    		<script>
											document.write(getAge('<BZ:dataValue type="date" field="FEMALE_BIRTHDAY" onlyValue="true"/>'));
                                            </script>
                                            </div>
                                    	</td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">国籍</td>
                                    	<td class="edit-data-value"><BZ:dataValue field="MALE_NATION" codeName="GJ"  defaultValue=""/></td>
                                    	<td class="edit-data-value"><BZ:dataValue field="FEMALE_NATION" codeName="GJ"  defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">护照号码</td>
                                    	<td class="edit-data-value"><BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/></td>
                                    	<td class="edit-data-value"><BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/></td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">受教育程度</td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU"  defaultValue=""/></td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU"  defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                    	<td class="edit-data-title">职业</td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_JOB_EN" defaultValue=""/></td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_JOB_EN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">健康状况</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>
                                        	<script>
											var h = "<BZ:dataValue field="MALE_HEALTH" onlyValue="true"/>";
											if ("2"==h){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="MALE_HEALTH_CONTENT_EN" defaultValue=""/>');
											}
											</script>
                                        	
                                        </td>
                                    	<td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>
											<script>
											var h = "<BZ:dataValue field="FEMALE_HEALTH" onlyValue="true"/>";
											if ("2"==h){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="FEMALE_HEALTH_CONTENT_EN" defaultValue=""/>');
											}
											</script>
                                    	</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">身高</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_HEIGHT" defaultValue=""/> 厘米</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_HEIGHT" defaultValue=""/> 厘米</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">体重</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_WEIGHT" defaultValue=""/> 千克</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_WEIGHT" defaultValue=""/> 千克</td>
                                    </tr>                                    
                                    <tr>
                                    	<td class="edit-data-title">体重指数</td>
                                    	<td class="edit-data-value" colspan="2">
										<script>
											document.write(_bmi(<BZ:dataValue field="MALE_HEIGHT" onlyValue="true"/>/100,<BZ:dataValue field="MALE_WEIGHT" onlyValue="true"/>));
										</script>
                                    	</td>
                                    	<td class="edit-data-value" colspan="2">
                                    	<script>
											document.write(_bmi(<BZ:dataValue field="FEMALE_HEIGHT" onlyValue="true"/>/100,<BZ:dataValue field="FEMALE_WEIGHT" onlyValue="true"/>));
										</script>
                                    	</td>
                                    </tr>
                                    <tr>
                                    <tr>
                                        <td class="edit-data-title">违法行为及刑事处罚</td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											var f = "<BZ:dataValue field="MALE_PUNISHMENT_FLAG" onlyValue="true"/>";
											document.write("0"==f?'无':'有');
											if ("1"==f){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="MALE_PUNISHMENT_EN" defaultValue=""/>');
											}
											</script>
                                        </td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											var f = "<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" onlyValue="true"/>";
											document.write("0"==f?'无':'有');
											if ("1"==f){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="FEMALE_PUNISHMENT_EN" defaultValue=""/>');
											}
											</script>                                        	
                                        </td>
									</tr>
                                    <tr>
                                        <td class="edit-data-title">有无不良嗜好</td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											var f = "<BZ:dataValue field="MALE_ILLEGALACT_FLAG" onlyValue="true"/>";
											document.write("0"==f?'无':'有');
											if ("1"==f){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="MALE_ILLEGALACT_EN" defaultValue=""/>');
											}
											</script>                                        	
                                        </td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											var f = "<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" onlyValue="true"/>";
											document.write("0"==f?'无':'有');
											if ("1"==f){
												document.write('<br>');
												document.write('<hr>');
												document.write('<BZ:dataValue field="FEMALE_ILLEGALACT_EN" defaultValue=""/>');
											}
											</script>                                           
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">宗教信仰</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_RELIGION_EN" defaultValue=""/></td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_RELIGION_EN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title"  >婚姻状况</td>
                                        <td class="edit-data-value" colspan="4">已婚</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" >结婚日期</td>
                                        <td class="edit-data-value" ><BZ:dataValue field="MARRY_DATE" type="Date" defaultValue=""/></td>
                                        <td class="edit-data-title" >婚姻时长（年）</td>
                                        <td class="edit-data-value" colspan="2">
											<script>
											document.write(getAge('<BZ:dataValue type="Date" field="MARRY_DATE" onlyValue="true"/>'));
											</script>  											
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">前婚次数</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_MARRY_TIMES" defaultValue=""/>次
                                        </td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_MARRY_TIMES" defaultValue=""/>次
                                        </td>
                                    </tr> 
                                    <tr>
                                        <td class="edit-data-title">货币单位</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="CURRENCY" codeName="ADOPTER_HEALTH" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">年收入</td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="MALE_YEAR_INCOME" defaultValue=""/></td>
                                        <td class="edit-data-value" colspan="2"><BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">家庭总资产</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="TOTAL_ASSET" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">家庭总债务</td>
                                        <td class="edit-data-value"><BZ:dataValue field="TOTAL_DEBT" defaultValue=""/></td>
                                        <td class="edit-data-title" >家庭净资产</td>
                                        <td class="edit-data-value" colspan="2">
                                            <script>
											document.write(_setTotalManny('<BZ:dataValue field="TOTAL_ASSET" onlyValue="true"/>','<BZ:dataValue field="TOTAL_DEBT" onlyValue="true"/>'));
											</script> 
                                        </td>
                                    </tr>
                                     <tr>
                                        <td class="edit-data-title">18周岁以下子女数量</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="UNDERAGE_NUM" defaultValue=""/> 个
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">子女数量及情况</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="CHILD_CONDITION_EN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">家庭住址</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="ADDRESS" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">收养要求</td>
                                        <td class="edit-data-value" colspan="4"><BZ:dataValue field="ADOPT_REQUEST_EN" defaultValue=""/></td>
                                    </tr>
                                </table>        
                            	<table class="specialtable">
                                    <tr>
                                        <td class="edit-data-title" colspan="6" style="text-align:center"><b>家庭调查及组织意见信息</b></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">完成家调组织名称</td>
                                        <td class="edit-data-value" colspan="5"><BZ:dataValue field="HOMESTUDY_ORG_NAME" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" width="15%">家庭报告完成日期</td>
                                        <td class="edit-data-value" width="18%"><BZ:dataValue field="FINISH_DATE" type="Date" defaultValue=""/></td>
                                        <td class="edit-data-title" width="15%">会见次数（次）</td>
                                        <td class="edit-data-value" width="18%"><BZ:dataValue field="INTERVIEW_TIMES" defaultValue=""/></td>                                    
                                        <td class="edit-data-title" width="15%">推荐信（封）</td>
                                        <td class="edit-data-value" width="19%"><BZ:dataValue field="RECOMMENDATION_NUM" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">心理评估报告</td>
                                        <td class="edit-data-value"><BZ:dataValue field="HEART_REPORT" codeName="ADOPTER_HEART_REPORT" defaultValue=""/></td>
                                        <td class="edit-data-title">收养动机</td>
                                        <td class="edit-data-value"><BZ:dataValue field="HEART_REPORT" codeName="ADOPTER_ADOPT_MOTIVATION" defaultValue=""/></td>                                    
                                        <td class="edit-data-title">家中10周岁及以上孩子对收养的意见</td>
                                        <td class="edit-data-value"><BZ:dataValue field="CHILDREN_ABOVE" codeName="ADOPTER_CHILDREN_ABOVE" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">有无指定监护人</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_FORMULATE" onlyValue="true"/>";
											document.write("0"==f?'无':'有');											
											</script>
                                        </td>
                                        <td class="edit-data-title">不遗弃不虐待声明</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_ABUSE_ABANDON" onlyValue="true"/>";
											document.write("0"==f?'无':'有');											
											</script>
                                        </td>
                                    
                                        <td class="edit-data-title">抚育计划</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_MEDICALRECOVERY" onlyValue="true"/>";
											document.write("0"==f?'无':'有');											
											</script>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">收养前准备</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="ADOPT_PREPARE" onlyValue="true"/>";
											document.write("0"==f?'无':'有');											
											</script>
                                        </td>
                                        <td class="edit-data-title">风险意识</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="RISK_AWARENESS" onlyValue="true"/>";
											document.write("0"==f?'无':'有');											
											</script>                                            
                                        </td>
                                   
                                        <td class="edit-data-title">同意递交安置后报告声明</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_SUBMIT_REPORT" onlyValue="true"/>";
											document.write("0"==f?'无':'有');											
											</script>
                                            
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td class="edit-data-title">育儿经验</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="PARENTING" onlyValue="true"/>";
											document.write("0"==f?'无':'有');											
											</script>
                                            
                                        </td>
                                        <td class="edit-data-title">社工意见</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="SOCIALWORKER" onlyValue="true"/>";
											var txt = "";
											switch (f)
											{
											case "":
												txt = "";
												break;
											case "1":
												txt = "支持";
												break;
											case "2":
												txt = "保留意见";
												break;
											case "3":
												txt = "不支持";
												break;											
											}
											document.write(txt);											
											</script>
                                        </td>
                                        <td class="edit-data-title">&nbsp;</td>
                                        <td class="edit-data-value">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">家中有无其他人同住</td>
                                        <td class="edit-data-value">
											<script>
											var f = "<BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" onlyValue="true"/>";
											document.write("0"==f?'无':'有');											
											</script>
                                        </td>
                                        <td class="edit-data-title">家中其他人同住说明</td>
                                        <td class="edit-data-value" colspan="3"><BZ:dataValue field="IS_FAMILY_OTHERS_EN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">家庭需说明的其他事项</td>
                                        <td class="edit-data-value" colspan="5"><BZ:dataValue field="REMARK_EN" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title" colspan="6" style="text-align:center"><b>政府批准信息</b></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">批准日期</td>
                                        <td class="edit-data-value"><BZ:dataValue field="GOVERN_DATE" type="Date" defaultValue=""/></td>
                                        <td class="edit-data-title">有效期限</td>
                                        <td class="edit-data-value">
											<script>											
											var v = "<BZ:dataValue field="VALID_PERIOD" onlyValue="true"/>";
											document.write(("-1"!=v)?v+" 月":"长期");											
											</script>
                                        </td>
                                        <td class="edit-data-title">批准儿童数量</td>
                                        <td class="edit-data-value"><BZ:dataValue field="APPROVE_CHILD_NUM" defaultValue=""/></td>
                                    </tr>
                                    <tr>
                                        <td class="edit-data-title">收养儿童年龄</td>
                                        <td class="edit-data-value"><BZ:dataValue field="AGE_FLOOR" defaultValue=""/>岁~ <BZ:dataValue field="AGE_UPPER" defaultValue=""/>岁</td>
                                        <td class="edit-data-title">收养儿童性别</td>
                                        <td class="edit-data-value"><BZ:dataValue field="CHILDREN_SEX" codeName="ADOPTER_CHILDREN_SEX" defaultValue=""/></td>
                                        <td class="edit-data-title">收养儿童健康状况</td>
                                        <td class="edit-data-value"><BZ:dataValue field="CHILDREN_HEALTH_EN" codeName="ADOPTER_CHILDREN_HEALTH" defaultValue=""/></td>
                                    </tr>
									<tr>
										<td class="edit-data-title" colspan="6" style="text-align:center">
										<b>附件信息</b></td>										
                                    </tr>
									<tr>
										<td colspan="6">
										<IFRAME ID="frmUpload1" SRC="<%=path%>/common/batchattview.action?bigType=AF&packID=<%=AttConstants.AF_PARENTS%>&packageID=<BZ:dataValue field="PACKAGE_ID" onlyValue="true"/>" frameborder=0 width="100%" height="100%"></IFRAME> 
										</td>
									</tr>
                                </table>                                 
                            </td>
                        </tr> 
                    <!--双亲收养：end--> 
                    </table>   
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
					<td  class="edit-data-value"><BZ:dataValue field="NOTICE_USERNAME"  defaultValue=""/></td>
					<td  class="edit-data-title" width="15%">通知日期</td>
					<td  class="edit-data-value"><BZ:dataValue field="NOTICE_DATE" type="date" defaultValue=""/></td>
					<td  class="edit-data-title" width="15%">接收日期</td>
					<td  class="edit-data-value"><BZ:dataValue field="RECEIVE_DATE" type="date" defaultValue=""/></td>
				</tr>
				<tr>
					<td  class="edit-data-title" width="15%">翻译单位</td>
					<td  class="edit-data-value"><BZ:dataValue field="TRANSLATION_UNITNAME"  defaultValue=""/></td>
					<td  class="edit-data-title" width="15%">翻译人</td>
					<td  class="edit-data-value"><BZ:dataValue field="TRANSLATION_USERNAME"  defaultValue=""/></td>
					<td  class="edit-data-title" width="15%">完成日期</td>
					<td  class="edit-data-value"><BZ:dataValue field="COMPLETE_DATE" type="date" defaultValue=""/></td>
				</tr>
				<tr>
					<td  class="edit-data-title" width="15%">翻译状态</td>
					<td  class="edit-data-value" colspan="5"><BZ:dataValue field="TRANSLATION_STATE"  defaultValue="" onlyValue="true" checkValue="0=待翻译;1=翻译中;2=已翻译"/></td>
				</tr>
                <tr>
					<td  class="edit-data-title" width="15%">翻译说明</td>
					<td  class="edit-data-value" colspan="5"><BZ:dataValue field="TRANSLATION_DESC"  defaultValue="" /></td>
				</tr>
			</table>
		</div>
		<!--翻译信息：end-->
		<br/>
		<!-- 按钮区域:begin -->
		<div class="bz-action-frame" style="text-align:center">
			<div class="bz-action-edit" desc="按钮区" id="buttonarea">
				<input type="button" value="打&nbsp;&nbsp;印" class="btn btn-sm btn-primary" onclick="beforeCNPrint();javascript:window.print();afterCNPrint();"/>&nbsp;&nbsp;
				<input type="button" value="关&nbsp;&nbsp;闭" class="btn btn-sm btn-primary" onclick="_close();"/>
			</div>
		</div>
		<!-- 按钮区域:end -->
		<br/>
	</BZ:body>
</BZ:html>
