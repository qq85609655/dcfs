<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	String male_name = (String)request.getAttribute("male_name");
	String female_name = (String)request.getAttribute("female_name");
%>

<BZ:html>
<BZ:head>
	<title>文件超期提醒页面</title>
	<BZ:webScript tree="false"/>
</BZ:head>
<BZ:body codeNames="SYZZ" property="remindData">
	<BZ:form name="srcForm" method="post">
	<div class="bz-edit clearfix" desc="编辑区域">
			<table border="0" align="center" style="width: 480px;height:240px;margin: 0 auto;">
				<tr>
		    		<td style="text-align: center;" >
		    		<h3>暂停超期通知</h3>
		    		</td>
		    	</tr>
		    	<tr>
		    		<td style="text-align: left;" >
		            	<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>收养组织：
		        	</td>
		    	</tr>
		    	<tr>
		    		<td style="text-align: left;" >
		           		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;你们递交的
		           		<%
						if("".equals(female_name) && (!"".equals(male_name))){
						%>
		           		<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
		           		<%
						}else if("".equals(male_name) && (!"".equals(female_name))){
						%>
						<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						<%
						}else{
						%>
						<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>和
		           		<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
		           		<%
						}
		           		%>
		           		的收养文件的暂停期限即将到期，请在<BZ:dataValue field="CN_END_DATE" defaultValue="" onlyValue="true"/>
		           		（含当日）之前办理取消暂停业务。否则，逾期我们将对该文件进行退文处理。
		           		</font>
		        	</td>
		    	</tr>
		    	<tr>
		    		<td style="text-align: right;" >
			    		中国儿童福利和收养中心
			    		</br>
			            <BZ:dataValue field="CN_REMIND_DATE" defaultValue="" onlyValue="true"/></br>
		        	</td>
		    	</tr>
			</table>
		<br/>
		<br/>
			<table border="0" align="center" style="width: 480px;height:240px;margin: 0 auto;">
				<tr>
		    		<td style="text-align: center;" >
		    		<h3>Urgent Notice</h3>
		    		</td>
		    	</tr>
		    	<tr>
		    		<td style="text-align: left;" >
		            	<BZ:dataValue field="NAME_EN" defaultValue="" onlyValue="true"/>&nbsp;ADOPTION：
		        	</td>
		    	</tr>
		    	<tr>
		    		<td style="text-align: left;" >
		           		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;We reviewed the application of 
		           		<%
						if("".equals(female_name) && (!"".equals(male_name))){
						%>
		           		<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
		           		<%
						}else if("".equals(male_name) && (!"".equals(female_name))){
						%>
						<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						<%
						}else{
						%>
						<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>&nbsp;and
		           		<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
		           		<%
						}
		           		%>
		           		 for adoption of a special-need child that you submitted and have advised you on 
		           		<BZ:dataValue field="PAUSE_DATE" type="date" defaultValue="" onlyValue="true"/>
		           		  that the family application file must be submitted as soon as possible. It has been 5 months since then. In order to help the special-need child join a family as early as possible, please submit their application file to the China Children’s Welfare and Adoption Center and make sure it will arrive at our office before
		           		  <BZ:dataValue field="EN_END_DATE" defaultValue="" onlyValue="true"/> (that day inclusive). If overdue, we will search for another family for the child. 
		           		</font>
		        	</td>
		    	</tr>
		    	<tr>
		    		<td style="text-align: right;" >
			    		China Children’s Welfare and Adoption Center
			    		</br>
			            <BZ:dataValue field="EN_REMIND_DATE" defaultValue="" onlyValue="true"/></br>
		        	</td>
		    	</tr>
			</table>
		<br/>
		<br/>
	</div>
	</BZ:form>
</BZ:body>
</BZ:html>
