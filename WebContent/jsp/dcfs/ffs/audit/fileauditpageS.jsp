<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
%>
<BZ:html>
<BZ:head>
	<title>��ͥ�ļ������ף����������</title>
	<BZ:webScript edit="true"/>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"/>
</BZ:head>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
	});
</script>
<BZ:body property="filedata">
	<script type="text/javascript">
	    $(document).ready( function() {
	      $('#tab-container').easytabs();
	    });
	</script>
	<BZ:form name="srcForm" method="post">
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action" desc="��ť��">
			<a href="reporter_files_list.html" >
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="����Ԥ��" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="��ӡ" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="window.location.href='reporter_files_list.html'"/>
			</a>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="bz-edit-data-content clearfix" desc="������">
				<!-- �༭���� ��ʼ -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">������֯(CN)��</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������֯(EN)��</td>
						<td class="bz-edit-data-value" colspan="5"> 
							<BZ:dataValue field="NAME_EN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�������ڣ�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REGISTER_DATE" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">���ı�ţ�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_NO" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">�ļ����ͣ�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue=""/>
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">�������ͣ�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_CONVENTION_ADOPT" checkValue="0=��;1=��" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">�Ƿ�Լ������</td>
						<td class="bz-edit-data-value"><BZ:dataValue field="IS_CONVENTION_ADOPT" checkValue="0=��;1=��" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title poptitle">֮ǰ���ı�ţ�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ƿ�Ԥ��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_ALERT" checkValue="0=��;1=��" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">�Ƿ�ת��֯��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_CHANGE_ORG" checkValue="0=��;1=��" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">ԭ������֯��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORIGINAL_ORG_NAME_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͣ״̬��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_PAUSE" checkValue="0=δ��ͣ;1=����ͣ" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">��ͣԭ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PAUSE_REASON" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">ĩ���ļ�����״̬��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SUPPLY_STATE" checkValue="0=δ����;1=�Ѳ���" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״̬��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_STATE" checkValue="0=��ȷ��;1=��ȷ��;2=������;3=�Ѵ���" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">����ԭ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_REASON" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">�ļ����������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_REASON" defaultValue=""/>
						</td>
					</tr>
				</table>
				<!-- �༭���� ���� -->
			</div>
		</div>
	</div>
	<div id="tab-container" class='tab-container'>
		<ul class='etabs'>
			<li class='tab'><a href="#tab1">������Ϣ(����)</a></li>
			<li class='tab'><a href="#tab2">������Ϣ(Ӣ��)</a></li>
			<li class='tab'><a href="<%=path%>/ffs/jbraudit/ajaxaction.action #ajaxtab" data-target="#tab3">��˼�¼</a></li>
			<li class='tab'><a href="<%=path%>/ffs/jbraudit/ajaxaction.action #ajaxtab" data-target="#tab4">�����¼</a></li>
			<li class='tab'><a href="<%=path%>/ffs/jbraudit/ajaxaction.action #ajaxtab" data-target="#tab5">�޸ļ�¼</a></li>
			<li class='tab'><a href="<%=path%>/ffs/jbraudit/ajaxaction.action #ajaxtab" data-target="#tab6">�����¼</a></li>
		</ul>
		<div class='panel-container'>
			<div id="tab1">
				<table width="100%" border="1">
				  <tr>
				    <td colspan="7" align="center">�����˻�����Ϣ</td>
				  </tr>
				  <tr>
				    <td width="12%">��������</td>
				    <td width="20%">&nbsp;</td>
				    <td width="15%">�Ա�</td>
				    <td width="14%">&nbsp;</td>
				    <td width="13%">��������</td>
				    <td width="15%">&nbsp;</td>
				    <td width="11%" rowspan="5">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>����</td>
				    <td>&nbsp;</td>
				    <td>����</td>
				    <td>&nbsp;</td>
				    <td>���պ���</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td>�ܽ����̶�</td>
				    <td>&nbsp;</td>
				    <td>ְҵ</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>����״��</td>
				    <td colspan="2">&nbsp;</td>
				    <td>�����������</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>���</td>
				    <td colspan="2">&nbsp;</td>
				    <td>����</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>����ָ��</td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				    <td>Υ����Ϊ�����´���</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>���޲����Ⱥ�</td>
				    <td colspan="2">&nbsp;</td>
				    <td>�ڽ�����</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>����״��</td>
				    <td colspan="2">&nbsp;</td>
				    <td>ͬ�ӻ��</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>ͬ��ʱ��</td>
				    <td colspan="2">&nbsp;</td>
				    <td>��ͬ��������</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>������</td>
				    <td colspan="2">&nbsp;</td>
				    <td>��ͥ���ʲ�</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>��ͥ��ծ��</td>
				    <td colspan="2">&nbsp;</td>
				    <td>��ͥ���ʲ�</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>��Ů���������</td>
				    <td colspan="6">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>δ������Ů����</td>
				    <td colspan="6">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>��ͥסַ</td>
				    <td colspan="6">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>����Ҫ��</td>
				    <td colspan="6">&nbsp;</td>
				  </tr>
				  <tr>
				    <td colspan="7" align="center">��ͥ���鼰��֯�����Ϣ</td>
				  </tr>
				  <tr>
				    <td>��ɼҵ���֯����</td>
				    <td>&nbsp;</td>
				    <td>��ͥ���鱨���������</td>
				    <td>&nbsp;</td>
				    <td>�������</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>�Ƽ���</td>
				    <td>&nbsp;</td>
				    <td>������������</td>
				    <td>&nbsp;</td>
				    <td>��������</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>����10���꼰���Ϻ��Ӷ����������</td>
				    <td>&nbsp;</td>
				    <td>�����ƻ�</td>
				    <td>&nbsp;</td>
				    <td>���޼໤������</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>����ǰ׼��</td>
				    <td>&nbsp;</td>
				    <td>������ʶ</td>
				    <td>&nbsp;</td>
				    <td>��������Ű�� <br />
				����</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>ͬ��ݽ����� <br />
				�󱨸�����</td>
				    <td>&nbsp;</td>
				    <td>��������������ͬס</td>
				    <td>&nbsp;</td>
				    <td>����������ͬס˵��</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>��������</td>
				    <td>&nbsp;</td>
				    <td>�繤���</td>
				    <td colspan="4">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>��ͥ��˵������������</td>
				    <td colspan="6">&nbsp;</td>
				  </tr>
				  <tr>
				    <td colspan="7" align="center">������׼��Ϣ</td>
				  </tr>
				  <tr>
				    <td>��׼����</td>
				    <td>&nbsp;</td>
				    <td>��Ч����</td>
				    <td>&nbsp;</td>
				    <td>��׼��ͯ����</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>������ͯ����</td>
				    <td>&nbsp;</td>
				    <td>������ͯ�Ա�</td>
				    <td>&nbsp;</td>
				    <td>������ͯ����״��</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td colspan="7" align="center">������Ϣ</td>
				  </tr>
				  <tr>
				    <td>�������������</td>
				    <td colspan="2">&nbsp;</td>
				    <td>����֤��</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>����״��֤��</td>
				    <td colspan="2">&nbsp;</td>
				    <td>ְҵ֤��</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>�������뼰����״��֤��</td>
				    <td colspan="2">&nbsp;</td>
				    <td>���彡�����֤��</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>�����ܹ����´���֤��</td>
				    <td colspan="2">&nbsp;</td>
				    <td>��ͥ���鱨��</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>������������</td>
				    <td colspan="2">&nbsp;</td>
				    <td>�������������ڹ����ܻ���ͬ������������Ů��֤��</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>��ͥ������Ƭ</td>
				    <td colspan="2">&nbsp;</td>
				    <td>�Ƽ���</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				</table>
				
				<!-- �����Ԥ����Ϣ -->
				
				<table width="100%" border="1">
				  <tr>
				    <td colspan="6" align="center">Ԥ��������ͯ������Ϣ</td>
				  </tr>
				  <tr>
				    <td width="19%">ʡ��</td>
				    <td width="26%">&nbsp;</td>
				    <td width="14%">����Ժ</td>
				    <td colspan="2">&nbsp;</td>
				    <td rowspan="5">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>����</td>
				    <td>&nbsp;</td>
				    <td>�Ա�</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>��������</td>
				    <td>&nbsp;</td>
				    <td>�ر��ע</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>��������</td>
				    <td>&nbsp;</td>
				    <td>���г̶�</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>�ļ��ݽ�����</td>
				    <td>&nbsp;</td>
				    <td>����ͬ��</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>�������</td>
				    <td colspan="5">&nbsp;</td>
				  </tr>
				  <tr>
				    <td colspan="6" align="center">Ԥ�������Ϣ</td>
				  </tr>
				  <tr>
				    <td>��˼���</td>
				    <td>&nbsp;</td>
				    <td>���ʱ��</td>
				    <td width="15%">&nbsp;</td>
				    <td width="14%">�����</td>
				    <td width="12%">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>��˽��</td>
				    <td>&nbsp;</td>
				    <td>������</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>��˼���</td>
				    <td>&nbsp;</td>
				    <td>���ʱ��</td>
				    <td>&nbsp;</td>
				    <td>�����</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td>��˽��</td>
				    <td>&nbsp;</td>
				    <td>������</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>��˼���</td>
				    <td>&nbsp;</td>
				    <td>���ʱ��</td>
				    <td>&nbsp;</td>
				    <td>�����</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td>��˽��</td>
				    <td>&nbsp;</td>
				    <td>������</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				</table>
			</div>
			<div id="tab2">
				<h2>JS for these tabs</h2>
			</div>
			<div id="tab3">
				<h2>CSS Styles for these tabs</h2>
			</div>
			<div id="tab4">
				<h2>CSS Styles for these tabs</h2>
			</div>
			<div id="tab5">
				<h2>CSS Styles for these tabs</h2>
			</div>
			<div id="tab6">
				
			</div>
		</div>
	</div>
	<!-- �����Ϣ -->
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					������
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<!-- �༭���� ��ʼ -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">����֤�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REGISTER_DATE" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">���뵥λ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_NO" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">����������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue=""/>
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">��˽����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_CONVENTION_ADOPT" checkValue="0=��;1=��" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">����ˣ�</td>
						<td class="bz-edit-data-value"><BZ:dataValue field="IS_CONVENTION_ADOPT" checkValue="0=��;1=��" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">�������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea style="height: 60px;width: 97%;"></textarea>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע��</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea style="height: 60px;width: 97%;"></textarea>
						</td>
					</tr>
				</table>
				<!-- �༭���� ���� -->
			</div>
		</div>
	</div>
	</BZ:form>
</BZ:body>
</BZ:html>
