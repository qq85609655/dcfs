<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head language="EN">
	<title>Ԥ����˽��֪ͨ</title>
	<BZ:webScript edit="true" tree="false"/>
	<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>	
	<script>
	
	</script>
</BZ:head>

<BZ:body property="data" codeNames="PROVINCE;">
	<BZ:form name="srcForm" method="post">
	<div id='PrintArea'>
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" cellspacing="0" cellpadding="20" align=center style="width: 560px;height:450px;margin: 0 auto;" align="center">
					<tr>
			    		<td colspan="5" style="line-height:400%;text-align: center;font-size: 21pt;" >
			    			ͨ ֪
			    		</td>
			    	</tr>
			    	<tr>
			    		<td colspan="5" style="text-align: left;font-size: 14pt;" >
			    			<span style="text-decoration: underline;">
			            		<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
			            	</span>
			            	������֯��
			        	</td>
			    	</tr>
			   		<tr>
			    		<td colspan="5" style="text-align: left; line-height:250%;font-size: 14pt;">
			            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���ǵݽ���
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
			            	��
			            	<span style="text-decoration: underline;">
		            			<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
		            		</span>
	            		<%	} %>
		            		����
		            		<span style="text-decoration: underline;">
		            			<BZ:dataValue field="PROVINCE_ID"  codeName="PROVINCE" defaultValue="" onlyValue="true"/>
		            		</span>
		            		��ʡ���С���������
		            		<span style="text-decoration: underline;">
		            			<BZ:dataValue field="WELFARE_NAME_CN"  defaultValue="" onlyValue="true"/>
		            		</span>
		            		��ͯ
		            		<span style="text-decoration: underline;">
		            			<BZ:dataValue field="NAME"  defaultValue="" onlyValue="true"/>
		            		</span>
		            		&#40;
		            		<span style="text-decoration: underline;">
		            			<%=(String)request.getAttribute("birthyear") %>��
		            			<%=(String)request.getAttribute("birthmonth") %>��
		            			<%=(String)request.getAttribute("birthday") %>��
		            		</span>
		            		����&#41;���������յ��������Ըü�ͥ�Ļ����������Ϊ�ö�ͯ�ƶ���ҽ�ƿ����������ƻ�����ˣ��й���ͯ��������������ͬ���ڸ������ļ�����
		            		&#40;��ֹ����
							<%=(String)request.getAttribute("submityear") %>��
							<%=(String)request.getAttribute("submitmonth") %>��
							<%=(String)request.getAttribute("submitday") %>�գ�������
							&#41;
		            		�󣬰�������������Ҫ��ͯ�ĳ������ش˸�֪��
			        	</td>
			    	</tr>
			    	<tr><td style="line-height:400%;">&nbsp;</td></tr>
			        <tr>
			    		<td colspan="2" width="300px" style="text-align: center;" >
			        	</td>
			            <td colspan="3" style="line-height:200%;text-align: right;font-size: 14pt;" >
			           	 �й���ͯ��������������</br>
			            <%=(String)request.getAttribute("year") %>��
						<%=(String)request.getAttribute("month") %>��
						<%=(String)request.getAttribute("day") %>��&nbsp;&nbsp;
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
		            		&nbsp;province that you submitted was received. It is hereby advised that with a review of the basic family situation and the Rehabilitation and Nurture Plan for the Child made by the family, the China Centre for Children��s Welfare and Adoption agrees to handle and process the case as an adoption of a special-need child after the application file arrives&nbsp;
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
			    			China Centre for Children��s Welfare and Adoption
			        	</td>
			    	</tr>
			    </table>
			</div>
		</div>
	<br/>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��" id="print1">
			<button class="btn btn-sm btn-primary" id="print_button" onclick="">Print</button>&nbsp;&nbsp;
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
	<script>
	//��ӡ�������
	$("#print_button").click(function(){
		$("#PrintArea").jqprint(); 
	}); 
	</script>
</BZ:body>
</BZ:html>
