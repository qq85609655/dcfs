<%
/**   
 * @Title: AFPlan_list.jsp
 * @Description: ������ͯԤ����ƻ���
 * @author xugy   
 * @date 2014-9-3����3:14:37
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
DataList AFdl = (DataList)request.getAttribute("AFdl");
int i=0;
if(AFdl.size()>0){
    i=AFdl.size();
}
%>
<BZ:html>
	<BZ:head>
		<title>������ͯԤ����ƻ���</title>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
	</BZ:head>
	<script>
	$(document).ready(function() {
		dyniframesize(['planListFrame']);
		_scroll(1500,1500);
	});
	//����excel
	function _export(){
		document.srcForm.action=path+"mormalMatch/exportExcel.action";
		document.srcForm.submit();
	}
	//�رյ���ҳ
	function _close(){
		var index = parent.layer.getFrameIndex(window.name);
		parent.layer.close(index);
	}
	</script>
</BZ:html>
<BZ:body property="Data" codeNames="WJLX_DL">
	<BZ:form name="srcForm" method="post" token="">
		<BZ:input type="hidden" prefix="E_" field="COUNT_DATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="E_" field="DATE_START" defaultValue=""/>
		<BZ:input type="hidden" prefix="E_" field="DATE_END" defaultValue=""/>
		<BZ:input type="hidden" prefix="E_" field="FILE_TYPE" defaultValue=""/>
		<div class="bz-action-frame">
			<div class="bz-action" desc="��ť��" style="text-align: left;">
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_export()" />
				<input type="button" value="�ر�" class="btn btn-sm btn-primary" onclick="_close()" />
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<div class="ui-state-default bz-edit-title" style="border: 1px #DDDDDD solid;">
						<div><font color="#669FC7">������ͯԤ����ƻ���</font></div>
					</div>
					<div style="padding-left: 10px;">
	            		<table>
	            			<tr style="height: 40px;">
	            				<td>
	            					�Ʊ��׼��<BZ:dataValue field="COUNT_DATE" defaultValue="" checkValue="REG_DATE=���ĵǼ�����;RECEIVER_DATE=�ļ���������;"/>
	            				</td>
	            			</tr>
	            			<tr style="height: 40px;">
	            				<td>
	            					�Ʊ����䣺<BZ:dataValue field="DATE_START" defaultValue="" />~<BZ:dataValue field="DATE_END" defaultValue="" />
	            				</td>
	            			</tr>
	            			<tr style="height: 40px;">
	            				<td>
	            					�Ʊ����<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX_DL" />�ļ�
	            				</td>
	            			</tr>
	            		</table>
					</div>
					<div style="overflow-x:scroll;">
					<div id="scrollDiv">
					<table width="500" border="1" cellspacing="0" cellpadding="0" style="border-color:#DDDDDD;" class="table-infocontent">
	                	<thead>
		                	<tr style="height: 30px;" align="center">
			                    <th width="3%" bgcolor="#EFF3F8">���</th>
			                    <th width="6%" bgcolor="#EFF3F8">�ļ����</th>
			                    <th width="6%" bgcolor="#EFF3F8">�Ǽ�����</th>
			                    <th width="4%" bgcolor="#EFF3F8">����</th>
			                    <th width="14%" bgcolor="#EFF3F8">��������</th>
			                    <th width="11%" bgcolor="#EFF3F8">��������</th>
			                    <th width="6%" bgcolor="#EFF3F8">�з���������</th>
			                    <th width="11%" bgcolor="#EFF3F8">Ů������</th>
			                    <th width="6%" bgcolor="#EFF3F8">Ů����������</th>
			                    <th width="7%" bgcolor="#EFF3F8">������׼������</th>
			                    <th width="6%" bgcolor="#EFF3F8">��������</th>
			                    <th width="10%" bgcolor="#EFF3F8">��Ů���</th>
			                    <th width="10%" bgcolor="#EFF3F8">����Ҫ��</th>
		                	</tr>
	                	</thead>
	                	<tbody>
	                	<BZ:for property="AFdl">
		                  	<tr style="height: 30px;">
			                    <td><BZ:i/></td>
			                    <td><BZ:data field="FILE_NO" defaultValue=""/></td>
			                    <td><BZ:data field="REG_DATE" defaultValue="" type="date" /></td>
			                    <td><BZ:data field="COUNTRY_CN" defaultValue=""/></td>
			                    <td><BZ:data field="NAME_CN" defaultValue="" /></td>
			                    <td><BZ:data field="MALE_NAME" defaultValue=""/></td>
			                    <td><BZ:data field="MALE_BIRTHDAY" defaultValue="" type="date"/></td>
			                    <td><BZ:data field="FEMALE_NAME" defaultValue=""/></td>
			                    <td><BZ:data field="FEMALE_BIRTHDAY" defaultValue="" type="date"/></td>
			                    <td><BZ:data field="GOVERN_DATE" defaultValue="" type="date"/></td>
			                    <td><BZ:data field="EXPIRE_DATE" defaultValue="" type="date"/></td>
			                    <td><BZ:data field="CHILD_CONDITION_CN" defaultValue="" /></td>
			                    <td><BZ:data field="ADOPT_REQUEST_CN" defaultValue="" /></td>
		                  	</tr>
		                </BZ:for>
		                	<tr>
		                		<td colspan="13" style="height: 30px;">�ϼƣ�����<%=i %>��</td>
		                	</tr>
	                  	</tbody>
	                </table>
	                </div>
	                </div>
				</div>	
			</div>
		</div>
	</BZ:form>
</BZ:body>