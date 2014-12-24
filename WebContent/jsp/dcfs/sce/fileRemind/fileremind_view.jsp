<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	String male_name = (String)request.getAttribute("male_name");
	String female_name = (String)request.getAttribute("female_name");
%>

<BZ:html>
<BZ:head language="EN">
	<title>�߰�֪ͨ�鿴ҳ��</title>
	<BZ:webScript tree="false"/>
</BZ:head>
<BZ:body property="remindData">
	<BZ:form name="srcForm" method="post">
	<div class="bz-edit clearfix" desc="�༭����">
			<table border="0" align="center" style="width: 480px;height:240px;margin: 0 auto;">
				<tr>
		    		<td style="text-align: center;" >
		    		<h3>�߰�֪ͨ</h3>
		    		</td>
		    	</tr>
		    	<tr>
		    		<td style="text-align: left;" >
		            	<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/>������֯��
		        	</td>
		    	</tr>
		    	<tr>
		    		<td style="text-align: left;" >
		           		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���ǵݽ���
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
						<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>��
		           		<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
		           		<%
						}
		           		%>
		           		���������ͯ
		           		<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
		           		�����룬��������ˣ�������
		           		<BZ:dataValue field="CN_NOTICE_DATE" defaultValue="" onlyValue="true"/>
		           		��֪���Ǿ���ݽ���ͥ�����ļ�����������5���£�Ϊʹ�����ͯ��������ͥ������
		           		<BZ:dataValue field="CN_SUBMIT_DATE" defaultValue="" onlyValue="true"/>
		           		�������գ�֮ǰ���ü�ͥ���������ļ��ݽ����й���ͯ�������������ġ��������ǽ�Ϊ�ö�ͯ����Ѱ��������ͥ��
		           		</font>
		        	</td>
		    	</tr>
		    	<tr>
		    		<td style="text-align: right;" >
			    		�й���ͯ��������������
			    		</br>
			            <BZ:dataValue field="CN_REM_DATE" defaultValue="" onlyValue="true"/>
		        	</td>
		    	</tr>
			</table>
		<br/>
		<br/>
			<table border="0" align="center" style="width: 480px;height:240px;margin: 0 auto;">
				<tr>
		    		<td style="text-align: center;" >
		    		<h3>Reminder notice</h3>
		    		</td>
		    	</tr>
		    	<tr>
		    		<td style="text-align: left;" >
		            	<BZ:dataValue field="ADOPT_ORG_NAME_EN" defaultValue="" onlyValue="true"/>&nbsp;ADOPTION��
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
		           		 for adoption of a special-need child
		           		<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/> 
		           		 that you submitted and have advised you on 
		           		<BZ:dataValue field="EN_NOTICE_DATE" defaultValue="" onlyValue="true"/>
		           		 that the family application file must be submitted as soon as possible. It has been 5 months since then. In order to help the special-need child join a family as early as possible, please submit their application file to the China Children��s Welfare and Adoption Center and make sure it will arrive at our office before
		           		<BZ:dataValue field="EN_SUBMIT_DATE" defaultValue="" onlyValue="true"/> (that day inclusive). If overdue, we will search for another family for the child. 
		           		</font>
		        	</td>
		    	</tr>
		    	<tr>
		    		<td style="text-align: right;" >
			    		China Children��s Welfare and Adoption Center
			    		</br>
			            <BZ:dataValue field="EN_REM_DATE" defaultValue="" onlyValue="true"/>
		        	</td>
		    	</tr>
			</table>
		<br/>
		<br/>
	</div>
	</BZ:form>
</BZ:body>
</BZ:html>
