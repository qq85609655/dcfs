<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description:����
 * @author xxx   
 * @date 2014-10-27 9:38:04
 * @version V1.0   
 */
    /******Java���빦������Start******/
 	//�������ݶ���
	Data data = (Data)request.getAttribute("data");
    if(data==null){
        data = new Data();
    }
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
			document.srcForm.action = path + "attsmalltype/save.action";
			document.srcForm.submit();
		  }
	}
	
	function _goback(){
		document.srcForm.action = path + "attsmalltype/findList.action";
		document.srcForm.submit();
	}
    </script>
<BZ:body property="data" >
	<BZ:form name="srcForm" method="post">
		<!-- ��������begin -->
		<BZ:input prefix="P_" field="ID" type="hidden" defaultValue=""/>
		<!-- ��������end -->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>����С����Ϣ</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					 <tr>
					 	<td class="bz-edit-data-title" width="15%">ҵ�����</td>
						<td class="bz-edit-data-value" width="18%">
						
						<BZ:select prefix="P_" field="BIG_TYPE" id="P_BIG_TYPE" isCode="false" formTitle="ҵ�����" notnull="ҵ����಻��Ϊ��">
							<option value="">--��ѡ��--</option>
							<BZ:option value="AF">��ͥ�ļ�</BZ:option>
							<BZ:option value="CI">��ͯ����</BZ:option>
							<BZ:option value="AR">��������</BZ:option>
						</BZ:select>
						</td> 
						<td class="bz-edit-data-title" width="15%">����С�����</td>
						<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CODE" id="P_CODE" defaultValue="" className="inputOne" formTitle="����С�����" restriction="hasSpecialChar" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="CNAME" id="P_CNAME" defaultValue="" className="inputOne" formTitle="��������" maxlength="200"/>
						</td> 
					 
						<td class="bz-edit-data-title" width="15%">Ӣ������</td>
						<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="ENAME" id="P_ENAME" defaultValue="" className="inputOne" formTitle="Ӣ������"  maxlength="200"/>
						</td> 
					</tr>
					 <tr>
						<td class="bz-edit-data-title" width="15%">�Ƿ�฽��</td>
						<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="ATT_MORE" id="P_ATT_MORE" defaultValue="" className="inputOne" formTitle="�Ƿ�฽��" maxlength="100"/>
						</td> 
					
					<td class="bz-edit-data-title" width="15%">������С</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="ATT_SIZE" id="P_ATT_SIZE" defaultValue="" className="inputOne" formTitle="������С"  maxlength="10"/>
						</td> 
					 </tr>
					 <tr>
						<td class="bz-edit-data-title" width="15%">������ʽ</td>
						<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="ATT_FORMAT" id="P_ATT_FORMAT" defaultValue="" className="inputOne" formTitle="������ʽ" maxlength="1000"/>
						</td> 
					
					<td class="bz-edit-data-title" width="15%">�Ƿ�ת������ͼ</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:select prefix="P_" field="IS_NAILS" id="P_IS_NAILS" isCode="false" formTitle="�Ƿ�ת������ͼ" notnull="�Ƿ�ת������ͼ">
							<option value="">--��ѡ��--</option>
							<BZ:option value="0">��</BZ:option>
							<BZ:option value="1">��</BZ:option>
						</BZ:select>
						
						</td> 
					 </tr>
					
					 <tr>
					<td class="bz-edit-data-title" width="15%">��ʾ˳��</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:input prefix="P_" field="SEQ_NO" id="P_SEQ_NO" defaultValue="" className="inputOne" formTitle="��ʾ˳��" restriction="hasSpecialChar" maxlength="10"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">��Ч��ʶ</td>
					<td class="bz-edit-data-value" width="18%">
					
						<BZ:select prefix="P_" field="IS_VALID" id="P_IS_VALID" isCode="false" formTitle="��Ч��ʶ" notnull="��Ч��ʶ">
							<option value="">--��ѡ��--</option>
							<BZ:option value="0">��Ч</BZ:option>
							<BZ:option value="1">��Ч</BZ:option>
						</BZ:select>
						</td> 
					 </tr>
					  <tr>
					<td class="bz-edit-data-title" width="15%">����˵��</td>
					<td colspan="3">
						<textarea name="P_REMARKS" id="P_REMARKS" rows="3" cols="100" maxlength="1000"><BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true"/></textarea>
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