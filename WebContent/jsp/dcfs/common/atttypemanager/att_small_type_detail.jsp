<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Description:����С��鿴
 * @author wangzheng
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
	<title>�鿴</title>
	<BZ:webScript edit="true" tree="false"/>
</BZ:head>
	<script>
	
	//$(document).ready(function() {
	//	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	//});
	
	function _goback(){
		document.srcForm.action = path + "attsmalltype/findList.action";
		document.srcForm.submit();
	}
    </script>
<BZ:body property="data" >
	<BZ:form name="srcForm" method="post">
		<!-- ��������begin -->
		
		<!-- ��������end -->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>����С��鿴</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					 <tr>
					 	<td class="bz-edit-data-title" width="15%">ҵ�����</td>
						<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="BIG_TYPE"  defaultValue="" onlyValue="true" checkValue="CI=��ͯ����;AF=��ͥ�ļ�;AR=��������;OTHER=����"/>
						</td> 
						<td class="bz-edit-data-title" width="15%">����С�����</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="CODE"  defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr> 
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="CNAME"  defaultValue="" onlyValue="true"/>
						</td> 
					 
					<td class="bz-edit-data-title" width="15%">Ӣ������</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="ENAME"  defaultValue="" onlyValue="true"/>
						</td> 
					</tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">�Ƿ�฽��</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="ATT_MORE"  defaultValue="" onlyValue="true"/>
						</td> 
					 
					<td class="bz-edit-data-title" width="15%">������С</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="ATT_SIZE"  defaultValue="" onlyValue="true"/>
						</td> 
					</tr>
					 <tr>
					<td class="bz-edit-data-title" width="15%">������ʽ</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="ATT_FORMAT"  defaultValue="" onlyValue="true"/>
						</td> 
					 
					<td class="bz-edit-data-title" width="15%">�Ƿ�ת������ͼ</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="IS_NAILS"  defaultValue="" onlyValue="true" checkValue="0=��;1=��"/>
						</td> 
					</tr>
					
					 <tr>
					<td class="bz-edit-data-title" width="15%">��ʾ˳��</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="SEQ_NO"  defaultValue="" onlyValue="true"/>
						</td> 
					<td class="bz-edit-data-title" width="15%">��Ч��ʶ</td>
					<td class="bz-edit-data-value" width="18%">
						<BZ:dataValue field="IS_VALID"  defaultValue="" onlyValue="true" checkValue="0=��Ч;1=��Ч"/>
						</td> 
					 </tr>
					  <tr>
					<td class="bz-edit-data-title" width="15%">����˵��</td>
					<td class="bz-edit-data-value" colspan="3">
						<BZ:dataValue field="REMARKS"  defaultValue="" onlyValue="true"/>
						</td> 
					 </tr>
				</table>
				</div>
			</div>
		</div>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		</BZ:form>
</BZ:body>
</BZ:html>