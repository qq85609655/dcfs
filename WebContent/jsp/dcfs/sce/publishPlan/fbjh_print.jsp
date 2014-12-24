<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Description:�����ƻ���ӡҳ��
	 * @author panfeng   
	 * @date 2014-10-26 9:19:11
	 * @version V1.0   
	 */
    
%>
<BZ:html>
<BZ:head>
	<title>�����ƻ���ӡҳ��</title>
	<BZ:webScript list="true" edit="true" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/resources/resource1/js/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/jquery.jqprint.js"></script>
</BZ:head>

<BZ:body property="printData" codeNames="PROVINCE;ETXB;BCZL;BCCD;SYS_ADOPT_ORG">
	
	<div class="page-content"  style="width:170mm">
		<div class="wrapper">
            <div class="blue-hr" id="print1"> 
				<button class="btn btn-sm btn-primary" id="print_button" onclick="">��ӡ</button>&nbsp;
				<button class="btn btn-sm btn-primary" onclick="window.close();">�ر�</button>
			</div>
			<div id='PrintArea'>
            <div align="center"><font size="+2">�����ƻ�������</font>
            </div> 
            <div align="center"><font size="+1">&nbsp;</font></div>

			<div class="table-responsive">            	
                <table cellspacing="0" cellpadding="4" border="0">
                	<tr height="25px"></tr>
                    <tr>
                        <td style="width:15%" align="right">�ƻ���ţ�</td>
                        <td style="width:45%"><BZ:dataValue field="PLAN_NO" onlyValue="true"/></td>
                        <td style="width:20%" align="right">�ⷢ�����ڣ�</td>
                        <td style="width:20%"><BZ:dataValue field="PUB_DATE" onlyValue="true" type="date"/></td></td>
                    </tr>	
                    <tr height="25px"></tr>							
                </table>						
			</div>
			
			<!--list:start-->
			<div class="table-responsive">
				<!--��ͯ������Ϣ����б���Start -->
					<div class="table-responsive">
						<table
							class="table table-striped table-bordered table-hover dataTable"
							border="1"
							adsorb="both" init="true" id="table">
							
								<tr>
									<th style="width:5%;">
										 ���
									</th>
									<th style="width:10%;">
										��ί������
									</th>
									<th style="width:10%;">
										��ί����֯
									</th>
									<th style="width:5%;">
										ʡ��
									</th>
									<th style="width:10%;">
										����Ժ
									</th>
									<th style="width:8%;">
										����
									</th>
									<th style="width:5%;">
										�Ա�
									</th>
									<th style="width:10%;">
										��������
									</th>
									<th style="width:10%;">
										��������
									</th>
									<th style="width:9%;">
										���г̶�
									</th>
									<th style="width:8%;">
										�ر��ע
									</th>
									<th style="width:10%;">
										��ע
									</th>
								</tr>
								
								<BZ:for property="List" fordata="fordata">
									<script type="text/javascript">
										<%
										String pub_type = ((Data)pageContext.getAttribute("fordata")).getString("W_PUB_TYPE","");
										%>
									</script>
									<tr class="emptyData">
										<td class="center"><BZ:i /></td>
										<td><BZ:data field="W_PUB_DATE" type="date"
												defaultValue="" onlyValue="true" dateFormat="yyyy-MM-dd"/></td>
										<%
										if("2".equals(pub_type)){
										%>
										<td>Ⱥ��</td>
										<%
										}else{
										%>
										<td><BZ:data field="W_PUB_ORGID" codeName="SYS_ADOPT_ORG"
												defaultValue="" onlyValue="true" /></td>
										<%} %>
										<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="WELFARE_NAME_CN" defaultValue=""
												onlyValue="true" /></td>
										<td><BZ:data field="NAME"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="SEX" codeName="ETXB"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="BIRTHDAY" type="date"
												defaultValue="" onlyValue="true" dateFormat="yyyy-MM-dd"/></td>
										<td><BZ:data field="SN_TYPE" codeName="BCZL"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="SN_DEGREE" codeName="BCCD"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="SPECIAL_FOCUS" checkValue="0=��;1=��;"
												defaultValue="" onlyValue="true" /></td>
										<td><BZ:data field="REMARKS"
												defaultValue="" onlyValue="true" /></td>
									</tr>
								</BZ:for>
							
						</table>
					</div>
					<!--��ͯ������Ϣ����б���End -->
                <table cellspacing="0" cellpadding="4" border="0" class="">
                	<tr height="25px"></tr>
                    <tr>
                        <td style="width:15%" align="right">�Ʊ��ˣ�</td>
                        <td style="width:45%">_________________</td>
                        <td style="width:15%" align="right">�Ʊ����ڣ�</td>
                        <td style="width:25%">_________________</td>
                    </tr>
                </table>
			</div>
			<!--list:end-->	
			</div>
		</div>
	</div>
   
</BZ:body>
<script>
$("#print_button").click(function(){
	$("#PrintArea").jqprint(); 
}); 
</script>

</BZ:html>
