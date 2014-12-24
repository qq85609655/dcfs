<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description:����
 * @author xxx   
 * @date 2014-10-27 12:28:58
 * @version V1.0   
 */
    /******Java���빦������Start******/
 	//�������ݶ���
	Data data = (Data)request.getAttribute("data");
	
	DataList smallTypeList = (DataList)request.getAttribute("smallTypeList");
    if(data==null){
        data = new Data();
    }
    String SMALL_TYPE_IDS = ","+data.getString("SMALL_TYPE_IDS")+",";
    
    
	request.setAttribute("data",data);
	/******Java���빦������End******/
%>
<BZ:html>
<BZ:head>
	<title>���</title>
	<BZ:webScript edit="true" tree="false"/>
</BZ:head>
	<script>
	
	//$(document).ready(function() {
	//	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	//});
	
	function _submit() {
		if (_check(document.srcForm)) {
			document.srcForm.action = path + "attpackage/save.action";
			document.srcForm.submit();
		  }
	}
	
	function _goback(){
		document.srcForm.action = path + "attpackage/findList.action";
		document.srcForm.submit();
	}
    </script>
<BZ:body property="data" >
	<BZ:form name="srcForm" method="post">
		<!-- ��������begin -->
		<BZ:input prefix="P_" field="ID" type="hidden" defaultValue=""/>
		<BZ:input prefix="P_" field="SMALL_TYPE_IDS" type="hidden" defaultValue=""/>
		<!-- ��������end -->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�������ϱ༭</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
				 <tr>
					<td class="bz-edit-data-title" width="15%">ҵ�����</td>
						<td class="bz-edit-data-value" width="75%">
						
						<BZ:select prefix="P_" field="BIG_TYPE" id="P_BIG_TYPE" isCode="false" formTitle="ҵ�����" notnull="ҵ����಻��Ϊ��">
							<option value="">--��ѡ��--</option>
							<BZ:option value="AF">��ͥ�ļ�</BZ:option>
							<BZ:option value="CI">��ͯ����</BZ:option>
							<BZ:option value="AR">��������</BZ:option>
						</BZ:select>
						</td> 
					 </tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">����</td>
					<td class="bz-edit-data-value">
						<BZ:input prefix="P_" field="PACKAGE_NAME" id="P_PACKAGE_NAME" defaultValue="" className="inputOne" formTitle="����"  size="100" maxlength="200"/>
						</td> 
					</tr>
					<tr>
					<td class="bz-edit-data-title" width="15%">С�༯��</td>
					<td class="bz-edit-data-value">
						<%
						if(smallTypeList!=null && smallTypeList.size()!=0){
						%>
							<table class="attlisttable">
						<%
							for(int i=0;i<smallTypeList.size();i++){
								Data typeData = smallTypeList.getData(i);
								//С������
								String CNAME = typeData.getString("CNAME");
								//С�����
								String CODE = typeData.getString("CODE");
								String s = ","+CODE+",";
								String checked = "";
								if(SMALL_TYPE_IDS.indexOf(s)>-1){
									checked = "checked";
								}
												
						%>
						<% if((i%2)==0){%><tr><% }%>
							<td width="50%"><input type="checkbox" id="SMALL_TYPE" value="<%= CODE%>" <%=checked %>><%=CNAME%></td>
						<% if((i%2)==1){%></tr><% }%>
							<%}%>
						
						</table>
						<%}%>
					</td> 
					 </tr>
					
				</table>
				</div>
			</div>
		</div>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		</BZ:form>
</BZ:body>
</BZ:html>