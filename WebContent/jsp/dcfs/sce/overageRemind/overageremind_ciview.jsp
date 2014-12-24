<%
/**   
 * @Title: overageremind_ciview.jsp
 * @Description: �鿴��ͯ��Ϣ
 * @author panfeng
 * @date 2014-9-16����4:19:28 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
DataList CIdls = (DataList)request.getAttribute("CIdls");
%>
<BZ:html>
<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/common.js"/>
<BZ:head>
	<title>��ͯ��Ϣ�鿴</title>
	<BZ:webScript edit="true"/>
	<link href="<%=request.getContextPath() %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/easytabs/jquery.easytabs.js"/>
</BZ:head>

<BZ:body codeNames="PROVINCE;ETXB;ETSFLX;CHILD_TYPE">
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	$('#tab-container').easytabs();
});
//�رյ���ҳ
function _close(){
	var index = parent.layer.getFrameIndex(window.name);
	parent.layer.close(index);
}
</script>
<BZ:form name="srcForm" method="post">
	<div id="tab-container" class='tab-container'>
            <%
			if(CIdls.size()>1){
			%>
			<ul class="etabs">
				<%
				for(int i=0;i<CIdls.size();i++){
				    Data d = CIdls.getData(i);
				    String NAME = d.getString("NAME");
				%>
			   <li class="tab"><a href="#tab<%=i+1 %>"><%=NAME %></a></li>
			   <%} %>
			</ul>
			<%} %>
			<div class='panel-container'>
				<%
				int i=0;
				%>
				<BZ:for property="CIdls" fordata="mydata">
            	<div id="tab<%=i+1 %>">
                    <table class="specialtable">
                        <tr>
                             <td class="edit-data-title" style="text-align:center"><b>��ͯ������Ϣ</b></td>
                        </tr>
                        <tr>
                        	<td>
                            	<table class="specialtable">
                                    <tr>
										<td class="edit-data-title" width="13%">��ͯ���</td>
										<td class="edit-data-value" width="30%">
											<BZ:dataValue field="CHILD_NO" defaultValue="" property="mydata" onlyValue="true"/>
										</td>
										<td class="edit-data-title" width="13%">��ͯ����</td>
										<td class="edit-data-value" width="30%">
											<BZ:dataValue field="CHILD_TYPE" defaultValue="" codeName="CHILD_TYPE" property="mydata" onlyValue="true"/>
										</td>
										<td class="edit-data-value" width="14%" rowspan="5">
											<BZ:dataValue field="PHOTO_CARD" defaultValue="" property="mydata"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">ʡ��</td>
										<td class="edit-data-value">
											<BZ:dataValue field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" property="mydata" onlyValue="true"/>
										</td>
										<td class="edit-data-title">����Ժ</td>
										<td class="edit-data-value">
											<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" property="mydata" onlyValue="true"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">����</td>
										<td class="edit-data-value">
											<BZ:dataValue field="NAME" defaultValue="" property="mydata" onlyValue="true"/>
										</td>
										<td class="edit-data-title">����ƴ��</td>
										<td class="edit-data-value">
											<BZ:dataValue field="NAME_PINYIN" defaultValue="" property="mydata" onlyValue="true"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">�Ա�</td>
										<td class="edit-data-value">
											<BZ:dataValue field="SEX" defaultValue="" codeName="ETXB" property="mydata" onlyValue="true"/>
										</td>
										<td class="edit-data-title">��������</td>
										<td class="edit-data-value">
											<BZ:dataValue field="BIRTHDAY" defaultValue="" type="date" property="mydata" onlyValue="true"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">�������</td>
										<td class="edit-data-value">
											<BZ:dataValue field="CHECKUP_DATE" defaultValue="" type="date" property="mydata" onlyValue="true"/>
										</td>
										<td class="edit-data-title">�Ƿ���ͬ��</td>
										<td class="edit-data-value">
											<BZ:dataValue field="IS_TWINS" defaultValue="" checkValue="0=��;1=��;" property="mydata" onlyValue="true"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">���֤��</td>
										<td class="edit-data-value">
											<BZ:dataValue field="ID_CARD" defaultValue="" property="mydata" onlyValue="true"/>
										</td>
										<td class="edit-data-title">��ͯ���</td>
										<td class="edit-data-value" colspan="2">
											<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" codeName="ETSFLX" property="mydata" onlyValue="true"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">������</td>
										<td class="edit-data-value">
											<BZ:dataValue field="SENDER" defaultValue="" property="mydata" onlyValue="true"/>
										</td>
										<td class="edit-data-title">�����˵�ַ</td>
										<td class="edit-data-value" colspan="2">
											<BZ:dataValue field="SENDER_ADDR" defaultValue="" property="mydata" onlyValue="true"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">��ͯ������</td>
										<td class="edit-data-value">
											<BZ:dataValue field="" defaultValue="" property="mydata" onlyValue="true"/>
										</td>
										<td class="edit-data-title">��ʰ����</td>
										<td class="edit-data-value" colspan="2">
											<BZ:dataValue field="PICKUP_DATE" defaultValue="" type="date" property="mydata" onlyValue="true"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">��Ժ����</td>
										<td class="edit-data-value">
											<BZ:dataValue field="ENTER_DATE" defaultValue="" type="date" property="mydata" onlyValue="true"/>
										</td>
										<td class="edit-data-title">��������</td>
										<td class="edit-data-value" colspan="2">
											<BZ:dataValue field="SEND_DATE" defaultValue="" type="date" property="mydata" onlyValue="true"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">�Ƿ񱨿�����</td>
										<td class="edit-data-value">
											<BZ:dataValue field="IS_ANNOUNCEMENT" defaultValue="" checkValue="0=��;1=��;" property="mydata" onlyValue="true"/>
										</td>
										<td class="edit-data-title">��������</td>
										<td class="edit-data-value" colspan="2">
											<BZ:dataValue field="ANNOUNCEMENT_DATE" defaultValue="" type="date" property="mydata" onlyValue="true"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">��������</td>
										<td class="edit-data-value" colspan="4">
											<BZ:dataValue field="NEWS_NAME" defaultValue="" property="mydata" onlyValue="true"/>
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">��ע</td>
										<td class="edit-data-value" colspan="4">
											<BZ:dataValue field="REMARKS" defaultValue="" property="mydata" onlyValue="true"/>
										</td>
									</tr>
                                </table>                                 
                            </td>
                        </tr>
                        <tr>
                             <td class="edit-data-title" style="text-align:center"><b>������Ϣ</b></td>
                        </tr>
                        <tr>
                        	<td>
                            	<table class="specialtable">
                                    <tr>
										<td class="edit-data-title" width="15%">����</td>
										<td class="edit-data-value" width="35%">
											
										</td>
										<td class="edit-data-title" width="15%">�ɳ�����</td>
										<td class="edit-data-value" width="35%">
											
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">����״��</td>
										<td class="edit-data-value">
											
										</td>
										<td class="edit-data-title">������Ƭ</td>
										<td class="edit-data-value">
											
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">�����Ƭ</td>
										<td class="edit-data-value">
											
										</td>
										<td class="edit-data-title">���翨</td>
										<td class="edit-data-value">
											
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">������</td>
										<td class="edit-data-value">
											
										</td>
										<td class="edit-data-title">���鵥</td>
										<td class="edit-data-value">
											
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">��ǰ��Ƭ</td>
										<td class="edit-data-value">
											
										</td>
										<td class="edit-data-title">������Ƭ</td>
										<td class="edit-data-value">
											
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">����С��</td>
										<td class="edit-data-value">
											
										</td>
										<td class="edit-data-title">�������</td>
										<td class="edit-data-value">
											
										</td>
									</tr>
									<tr>
										<td class="edit-data-title">��������</td>
										<td class="edit-data-value" colspan="3">
											
										</td>
									</tr>
                                </table>                                 
                            </td>
                        </tr>
                    </table>
                </div>
                <%
				i++;
				%>
				</BZ:for>
				<div style="text-align:center; margin-top: 10px;">
					<input type="button" value="�ر�" class="btn btn-sm btn-primary" onclick="_close()" />
				</div>
			</div>
		</div>
</BZ:form>
</BZ:body>
</BZ:html>
