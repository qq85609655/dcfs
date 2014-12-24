<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head language="EN">
	<title>预批审核结果通知</title>
	<BZ:webScript edit="true" tree="false"/>
	<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>	
	<script>
	
	</script>
</BZ:head>

<BZ:body property="data" codeNames="PROVINCE;">
	<BZ:form name="srcForm" method="post">
	<div id='PrintArea'>
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0" cellspacing="0" cellpadding="20" align=center style="width: 560px;height:450px;margin: 0 auto;" align="center">
					<tr>
			    		<td colspan="5" style="line-height:400%;text-align: center;font-size: 21pt;" >
			    			通 知
			    		</td>
			    	</tr>
			    	<tr>
			    		<td colspan="5" style="text-align: left;font-size: 14pt;" >
			    			<span style="text-decoration: underline;">
			            		<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
			            	</span>
			            	收养组织：
			        	</td>
			    	</tr>
			   		<tr>
			    		<td colspan="5" style="text-align: left; line-height:250%;font-size: 14pt;">
			            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;你们递交的
		            	<%
			            	String adopter_sex = (String)request.getAttribute("ADOPTER_SEX");
			            	if(adopter_sex.equals("1")){
			            %>
			            	<span style="text-decoration: underline;">
			            		<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
			            	</span>
			            <%
			            	}else if(adopter_sex.equals("1")){
	            		%>
			            	<span style="text-decoration: underline;">
		            			<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
		            		</span>
			            <%
			            	}else{
		            	%>
			            	<span style="text-decoration: underline;">
			            		<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
			            	</span>
			            	和
			            	<span style="text-decoration: underline;">
		            			<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
		            		</span>
	            		<%	} %>
		            		收养
		            		<span style="text-decoration: underline;">
		            			<BZ:dataValue field="PROVINCE_ID"  codeName="PROVINCE" defaultValue="" onlyValue="true"/>
		            		</span>
		            		（省、市、自治区）
		            		<span style="text-decoration: underline;">
		            			<BZ:dataValue field="WELFARE_NAME_CN"  defaultValue="" onlyValue="true"/>
		            		</span>
		            		儿童
		            		<span style="text-decoration: underline;">
		            			<BZ:dataValue field="NAME"  defaultValue="" onlyValue="true"/>
		            		</span>
		            		&#40;
		            		<span style="text-decoration: underline;">
		            			<%=(String)request.getAttribute("birthyear") %>年
		            			<%=(String)request.getAttribute("birthmonth") %>月
		            			<%=(String)request.getAttribute("birthday") %>日
		            		</span>
		            		出生&#41;的申请已收到，经过对该家庭的基本情况及其为该儿童制定的医疗康复及抚育计划的审核，中国儿童福利和收养中心同意在该申请文件到达
		            		&#40;截止日期
							<%=(String)request.getAttribute("submityear") %>年
							<%=(String)request.getAttribute("submitmonth") %>月
							<%=(String)request.getAttribute("submitday") %>日，含当日
							&#41;
		            		后，按照收养特殊需要儿童的程序处理，特此告知。
			        	</td>
			    	</tr>
			    	<tr><td style="line-height:400%;">&nbsp;</td></tr>
			        <tr>
			    		<td colspan="2" width="300px" style="text-align: center;" >
			        	</td>
			            <td colspan="3" style="line-height:200%;text-align: right;font-size: 14pt;" >
			           	 中国儿童福利和收养中心</br>
			            <%=(String)request.getAttribute("year") %>年
						<%=(String)request.getAttribute("month") %>月
						<%=(String)request.getAttribute("day") %>日&nbsp;&nbsp;
			        	</td>
			    	</tr>
			    </table>
			    <h1>&nbsp;</h1>
			    <table class="bz-edit-data-table" border="0" cellspacing="0" cellpadding="20" align=center style="width: 560px;height:450px;margin: 0 auto;font-family: 'Times New Roman',Georgia,Serif;" align="center">
					<tr>
			    		<td colspan="5" style="line-height:400%;text-align: center;font-size: 21pt;">
			    			Notice
			    		</td>
			    	</tr>
			    	<tr>
			    		<td colspan="5" style="text-align: left;font-size: 14pt;" >
		            		<%=(String)request.getAttribute("monthEN") %>&nbsp;
		            		<%=(String)request.getAttribute("day") %>,
		            		<%=(String)request.getAttribute("year") %>
			        	</td>
			    	</tr>
			    	<tr>
			    		<td colspan="5" style="text-align: left;font-size: 14pt;" >
		            		<BZ:dataValue field="ADOPT_ORG_NAME_EN" defaultValue="" onlyValue="true"/>:
			        	</td>
			    	</tr>
			   		<tr>
			    		<td colspan="5" style="text-align: left; line-height:250%;font-size: 14pt;">
			            	&nbsp;&nbsp;The application of&nbsp;
			            <%
			            	if(adopter_sex.equals("1")){
			            %>
			            	<b><BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/></b>
			            <%
			            	}else if(adopter_sex.equals("2")){
	            		%>
			            	<b><BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/></b>
			            <%		
			            	}else{
			            %>
			            	<b><BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/></b>
			            	&nbsp;and&nbsp;
	            			<b><BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/></b>
	            		<%	} %>
		            		&nbsp;for adoption of&nbsp;
		            		<b>
		            			<BZ:dataValue field="NAME_PINYIN"  defaultValue="" onlyValue="true"/>
		            			&#40;DOB&nbsp;
		            			<%=(String)request.getAttribute("birthmonthEN") %>&nbsp;
		            			<%=(String)request.getAttribute("birthday") %>,
		            			<%=(String)request.getAttribute("birthyear") %>
		            			&#41;
		            		</b>
		            		&nbsp;from&nbsp;
		            		<b>
		            			<BZ:dataValue field="WELFARE_NAME_EN"  defaultValue="" onlyValue="true"/>
		            		</b>
		            		&nbsp;of&nbsp;
		            		<b>
		            			<BZ:dataValue field="PROVINCE_ID"  codeName="PROVINCE" isShowEN="true" defaultValue="" onlyValue="true"/>
		            		</b>
		            		&nbsp;province that you submitted was received. It is hereby advised that with a review of the basic family situation and the Rehabilitation and Nurture Plan for the Child made by the family, the China Centre for Children’s Welfare and Adoption agrees to handle and process the case as an adoption of a special-need child after the application file arrives&nbsp;
		            		&#40;
		            			deadline&nbsp;
		            			<%=(String)request.getAttribute("submitmonthEN") %>&nbsp;
		            			<%=(String)request.getAttribute("submitday") %>,
		            			<%=(String)request.getAttribute("submityear") %>, that day inclusive
		            		&#41;.
			        	</td>
			    	</tr>
			    	<tr>
			    		<td colspan="5" style="line-height:800%;text-align: right;font-size: 14pt;" >
			    			China Centre for Children’s Welfare and Adoption
			        	</td>
			    	</tr>
			    </table>
			</div>
		</div>
	<br/>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区" id="print1">
			<button class="btn btn-sm btn-primary" id="print_button" onclick="">Print</button>&nbsp;&nbsp;
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
	<script>
	//打印控制语句
	$("#print_button").click(function(){
		$("#PrintArea").jqprint(); 
	}); 
	</script>
</BZ:body>
</BZ:html>
