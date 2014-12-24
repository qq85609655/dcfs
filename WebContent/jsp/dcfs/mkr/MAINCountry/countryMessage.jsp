<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
	Data d = (Data)request.getAttribute("data");
	String path = request.getContextPath();
	String ID=d.getString("COUNTRY_CODE");
	String CURRENCY=d.getString("CURRENCY");
	
	String m = (String)request.getAttribute("m");
%>
<BZ:html>
<BZ:head>
	<title>����ά��</title>
	<BZ:webScript edit="true" list="true"/>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"></script>
</BZ:head>
<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['rightFrame','mainFrame']);
		$('#tab-container').easytabs();
		var m = "<%=m %>";
		if(m == "ok"){
			document.getElementById("govement").click();
		}
		
	});
	function _submit(){
		if(confirm("ȷ���ύ��")){
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			document.srcForm.action=path+"mkr/MAINCountry/reviseCountry.action";
			document.srcForm.submit();
		}
	}
</script>
<BZ:body property="data" codeNames="HBBZ;">
	<BZ:form name="srcForm" action="MAINCountry/reviseCountry.action" method="post">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<div id="tab-container" class='tab-container'>
			<ul class='etabs'>
				<li class='tab'><a href="#tab1">���һ�����Ϣ</a></li>
				<li class='tab'><a id="govement" href="<%=path%>/mkr/MAINCountry/findGovement.action?ID=<%=ID%>" data-target="#tab2" >��������</a></li>
			</ul>
			
			<div class='panel-container'>
			<!-- ��֯������Ϣbegin -->
				<div id="tab1">
				<div class="bz-edit clearfix" desc="�༭����" >
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
					<div class="bz-edit-data-content clearfix" desc="������">
					<!-- �༭���� ��ʼ -->
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title">������������</td>
							<td class="bz-edit-data-value"  colspan="5">
								<BZ:dataValue field="NAME_CN" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����Ӣ������</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="NAME_EN" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">���ұ���</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue   field="COUNTRY_CODE" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">����</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:select field="CURRENCY"  prefix="C_"  formTitle="" codeName="HBBZ" isCode="true">
									<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">��Լ��</td> 
							<td class="bz-edit-data-value" width="18%">
								<BZ:radio field="CONVENTION" value="1" prefix="C_"  formTitle="">��</BZ:radio>
								<BZ:radio field="CONVENTION" value="0" prefix="C_" formTitle="">��</BZ:radio>
							</td>
							<td class="bz-edit-data-title" width="15%">�ڻ���ס��Լ����</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:radio field="SOLICIT_SUBMISSIONS" value="1" prefix="C_"  formTitle="">��</BZ:radio>
								<BZ:radio field="SOLICIT_SUBMISSIONS" value="0" prefix="C_" formTitle="">��</BZ:radio>
							</td>
							<td class="bz-edit-data-title" width="15%">����</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:input field="SEQ_NO"  prefix="C_" id="C_SEQ_NO"  defaultValue=""/>
								<BZ:input type="hidden" field="COUNTRY_CODE" prefix="C_" id="C_COUNTRY_CODE"  defaultValue=""/>
							</td>
						</tr>
					</table>
					<!-- �༭���� ���� -->
					</div>
					</div>
				</div>
				<!--��֯������Ϣ end -->
					<!-- ��ť�� ��ʼ -->
					<div class="bz-action-frame">
					<div class="bz-action-edit" desc="��ť��">
						<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="_submit();"/>
					</div>
					</div>
					<!-- ��ť�� ���� -->
				</div>
				<div id="tab2"></div>
			</div>
		</div>
		</BZ:frameDiv>
	</BZ:form>
</BZ:body>
<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
		$('#tab-container').easytabs();
	});
</script>
</BZ:html>
