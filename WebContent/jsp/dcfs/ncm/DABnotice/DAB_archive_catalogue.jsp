<%
/**   
 * @Title: DAB_archive_catalogue.jsp
 * @Description: ����Ŀ¼
 * @author xugy
 * @date 2014-11-2����7:00:22
 * @version V1.0   
 * @add function web print by kings
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data data = (Data)request.getAttribute("data");

String CHILD_IDENTITY = data.getString("CHILD_IDENTITY");

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>����Ŀ¼</title>
	<BZ:webScript edit="true"/>
	<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/jquery.jqprint.js"></script>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	_check_one();
});
//
function _check_one(){
	var inputElement = $(".fileNum");
	var total = 0;
	for(var i=0;i<inputElement.length;i++){
		var num = inputElement[i].value;
		total = total + Number(num);
	}
	$("#total").text(total);
}
//
function _print(){
	$("#PrintArea").jqprint(); 
}
//
function _save(){
	//ҳ���У��
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"notice/saveDABCatalog.action";
	document.srcForm.submit();
}
//����
function _goback(){
	document.srcForm.action=path+"notice/DABArchiveFilingList.action";
	document.srcForm.submit();
}
</script>
<style type="text/css">
	#tab tr {
		height: 30px;
	}
	#tab tr td {
		border: 1px black solid;
	}
	#tab tr th {
		border: 1px black solid;
	}
	.center {
		text-align: center;
	}
</style>
<BZ:body property="data" codeNames="WJLX;ETSFLX;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input prefix="AI_" field="ARCHIVE_ID" defaultValue="" type="hidden"/>
	<div id="PrintArea"> 
	<div class="bz-edit clearfix" style="text-align: center;" desc="�༭����">
		<div style="text-align: center;"><b><font size="4"><p class="title3">����������������Ŀ¼��һ��</p></font></b></div>
	</div>
	<table style="width: 90%;margin-top: 10px;" align="center">
		<tr style="height: 30px;">
			<td style="width: 30%;">�����ţ�<BZ:dataValue field="ARCHIVE_NO" defaultValue="" /></td>
			<td style="text-align: right;">��������������<BZ:dataValue field="NAME" defaultValue="" /></td>
		</tr>
		<tr style="height: 30px;">
			<td>�ļ����ͣ�<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX"/></td>
			<td  style="text-align: right;">��ͯ��ݣ�<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" codeName="ETSFLX"/></td>
		</tr>
	</table>
	<table style="width: 90%;margin-top: 10px;" align="center" id="tab" class="table-print">
		<thead>
			<tr>
				<th >���</th>
				<th >�ļ�����</th>
				<th >����</th>
			</tr>
		</thead>
		<%
		if("10".equals(CHILD_IDENTITY)){
		%>
		<tr>
			<td class="center">1</td>
			<td>����������֪ͨ���������� </td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE1_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">2</td>
			<td>������������Ů֪ͨ�顷��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE2_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">3</td>
			<td>��������������顷</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE3_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">4</td>
			<td>����������������顷</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE4_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">5</td>
			<td>������������������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE5_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">6</td>
			<td>�����˾������֤��ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE6_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">7</td>
			<td>�������˻���֤����ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE7_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">8</td>
			<td>����ʰ��Ӥ�ǼǱ���ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE8_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">9</td>
			<td>����ḣ������������Ӥ��Ժ�ǼǱ���ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE9_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">10</td>
			<td>������Ӥ��ͯ����ĸ���渴ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE10_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">11</td>
			<td>����������ͯ�������������鱨�浥��ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE11_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">12</td>
			<td>��������ͯ�ɳ�������渴ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE12_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">13</td>
			<td>����������ͯ�ɳ�״������ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE13_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">14</td>
			<td>�����˻��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE14_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">15</td>
			<td>�������������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE15_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">16</td>
			<td>����֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE16_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">17</td>
			<td>����״��֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE17_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">18</td>
			<td>ְҵ֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE18_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">19</td>
			<td>��������ͲƲ�״��֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE19_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">20</td>
			<td>���彡�����֤��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE20_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">21</td>
			<td>�����ܹ����´�����֤��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE21_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">22</td>
			<td>���������ڹ����ܻ���ͬ������������Ů��֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE22_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">23</td>
			<td>��ͥ������漰����</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE23_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">24</td>
			<td>�����˻��ո�ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE24_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">25</td>
			<td>�����������ļ�ԭ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE25_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">26</td>
			<td>��Ƭ</td>
			<td class="center">&nbsp;&nbsp;&nbsp;<BZ:input prefix="AI_" field="CATALOGUE1_FILE26_NUM" defaultValue="" restriction="plusInt" style="width:25px;"/>��</td>
		</tr>
		<tr>
			<td class="center">27</td>
			<td>����</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE27_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">28</td>
			<td>�ļ�����</td>
			<td class="center">
				<span id="total"></span>
			</td>
		</tr>
		<%
		}
		if("201".equals(CHILD_IDENTITY) || "202".equals(CHILD_IDENTITY) || "20".equals(CHILD_IDENTITY)){
		%>
		<tr>
			<td class="center">1</td>
			<td>����������֪ͨ���������� </td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE1_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">2</td>
			<td>������������Ů֪ͨ�顷��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE2_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">3</td>
			<td>��������������顷</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE3_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">4</td>
			<td>����������������顷</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE4_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">5</td>
			<td>������������������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE5_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">6</td>
			<td>�����˾������֤��ӡ���������˻���֤����ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE6_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">7</td>
			<td>�������˻���֤����ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE7_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">8</td>
			<td>����ḣ���������չ¶���Ժ�ǼǱ���ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE8_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">9</td>
			<td>�����и����¶�������˷����໤Ȩ��ͬ���������������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE9_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">10</td>
			<td>��������ͯ����ĸ��������������֤����ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE10_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">11</td>
			<td>�¶�ԭ��ͥסַ���ڵش���ίԱ������ίԱ�����</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE11_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">12</td>
			<td>����������ͯ�������������鱨�浥��ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE12_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">13</td>
			<td>��������ͯ�ɳ�������渴ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE13_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">14</td>
			<td>����������ͯ�ɳ�״������ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE14_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">15</td>
			<td>��������ͬ�ⱻ��������������֤</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE15_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">16</td>
			<td>�����˻��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE16_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">17</td>
			<td>�������������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE17_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">18</td>
			<td>����֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE18_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">19</td>
			<td>����״��֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE19_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">20</td>
			<td>ְҵ֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE20_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">21</td>
			<td>��������ͲƲ�״��֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE21_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">22</td>
			<td>���彡�����֤��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE22_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">23</td>
			<td>�����ܹ����´�����֤��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE23_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">24</td>
			<td>���������ڹ����ܻ���ͬ������������Ů��֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE24_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">25</td>
			<td>��ͥ������漰����</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE25_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">26</td>
			<td>�����˻��ո�ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE26_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">27</td>
			<td>�����������ļ�ԭ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE27_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">28</td>
			<td>��Ƭ</td>
			<td class="center">&nbsp;&nbsp;&nbsp;<BZ:input prefix="AI_" field="CATALOGUE1_FILE28_NUM" defaultValue="" restriction="plusInt" style="width:25px;"/>��</td>
		</tr>
		<tr>
			<td class="center">29</td>
			<td>�ļ�����</td>
			<td class="center">
				<span id="total"></span>
			</td>
		</tr>
		<%
		}
		if("301".equals(CHILD_IDENTITY) || "302".equals(CHILD_IDENTITY) || "30".equals(CHILD_IDENTITY)){
		%>
		<tr>
			<td class="center">1</td>
			<td>����������֪ͨ���������� </td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE1_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">2</td>
			<td>������������Ů֪ͨ�顷��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE2_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">3</td>
			<td>��������������顷</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE3_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">4</td>
			<td>����������������顷</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE4_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">5</td>
			<td>������������������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE5_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">6</td>
			<td>�����˾������֤��ӡ���������˻���֤����ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE6_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">7</td>
			<td>ת�Ƽ໤ȨЭ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE7_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">8</td>
			<td>����ĸ�������໤��ͬ���������������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE8_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">9</td>
			<td>���������䲻��һ������ĸ�ĸ�ĸ����ʹ���ȸ���Ȩ������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE9_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">10</td>
			<td>�����и����������ͬ���������������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE10_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">11</td>
			<td>����������������ĸ��������������֤����ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE11_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">12</td>
			<td>������������ĸ��������������������֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE12_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">13</td>
			<td>��������ͬ�ⱻ��������������֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE13_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">14</td>
			<td>����������ͯ�������������鱨�浥��ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE14_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">15</td>
			<td>��������ͯ�ɳ�������渴ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE15_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">16</td>
			<td>����������ͯ�ɳ�״������ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE16_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">17</td>
			<td>�����˻��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE17_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">18</td>
			<td>�������������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE18_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">19</td>
			<td>����֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE19_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">20</td>
			<td>����״��֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE20_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">21</td>
			<td>ְҵ֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE21_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">22</td>
			<td>��������ͲƲ�״��֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE22_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">23</td>
			<td>���彡�����֤��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE23_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">24</td>
			<td>�����ܹ����´�����֤��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE24_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">25</td>
			<td>���������ڹ����ܻ���ͬ������������Ů��֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE25_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">26</td>
			<td>��ͥ������漰����</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE26_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">27</td>
			<td>�����˻��ո�ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE27_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">28</td>
			<td>�����������ļ�ԭ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE28_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">29</td>
			<td>��Ƭ</td>
			<td class="center">&nbsp;&nbsp;&nbsp;<BZ:input prefix="AI_" field="CATALOGUE1_FILE29_NUM" defaultValue="" restriction="plusInt" style="width:25px;"/>��</td>
		</tr>
		<tr>
			<td class="center">30</td>
			<td>�ļ�����</td>
			<td class="center">
				<span id="total"></span>
			</td>
		</tr>
		<%
		}
		if("40".equals(CHILD_IDENTITY) || "50".equals(CHILD_IDENTITY)){
		%>
		<tr>
			<td class="center">1</td>
			<td>����������֪ͨ���������� </td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE1_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">2</td>
			<td>������������Ů֪ͨ�顷��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE2_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">3</td>
			<td>��������������顷</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE3_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">4</td>
			<td>����������������顷</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE4_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">5</td>
			<td>������������������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE5_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">6</td>
			<td>�����˾������֤��ӡ���������˻���֤����ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE6_NUM" defaultValue="3" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">7</td>
			<td>�����������������������鱨�浥��ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE7_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">8</td>
			<td>�������뵱�ؼƻ���������ǩ���Ĳ�Υ���ƻ������涨��Э��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE8_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">9</td>
			<td>�������뱻�����˵�������ϵ֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE9_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">10</td>
			<td>�������������˵�������ϵ֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE10_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">11</td>
			<td>��������������������������ϵѪ�׵���Ů������ϵ֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE11_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">12</td>
			<td>������ͬ����������������֤</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE12_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">13</td>
			<td>�����˽��֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE13_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">14</td>
			<td>�������뱻��������������ĸ����֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE14_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">15</td>
			<td>����������Ը����������������֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE15_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">16</td>
			<td>����ĸ����֤�����໤��ͬ����������������֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE16_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">17</td>
			<td>�����˻��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE17_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">18</td>
			<td>�������������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE18_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">19</td>
			<td>����֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE19_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">20</td>
			<td>����״��֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE20_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">21</td>
			<td>ְҵ֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE21_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">22</td>
			<td>��������ͲƲ�״��֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE22_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">23</td>
			<td>���彡�����֤��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE23_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">24</td>
			<td>�����ܹ����´�����֤��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE24_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">25</td>
			<td>���������ڹ����ܻ���ͬ������������Ů��֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE25_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">26</td>
			<td>��ͥ������漰����</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE26_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">27</td>
			<td>�����˻��ո�ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE27_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">28</td>
			<td>�����������ļ�ԭ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE28_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">29</td>
			<td>��Ƭ</td>
			<td class="center">&nbsp;&nbsp;&nbsp;<BZ:input prefix="AI_" field="CATALOGUE1_FILE29_NUM" defaultValue="" restriction="plusInt" style="width:25px;"/>��</td>
		</tr>
		<tr>
			<td class="center">30</td>
			<td>�ļ�����</td>
			<td class="center">
				<span id="total"></span>
			</td>
		</tr>
		<%
		}
		if("60".equals(CHILD_IDENTITY)){
		%>
		<tr>
			<td class="center">1</td>
			<td>����������֪ͨ���������� </td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE1_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">2</td>
			<td>������������Ů֪ͨ�顷��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE2_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">3</td>
			<td>��������������顷</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE3_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">4</td>
			<td>����������������顷</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE4_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">5</td>
			<td>������������������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE5_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">6</td>
			<td>�����˾������֤��ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE6_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">7</td>
			<td>�������˻���֤����ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE7_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">8</td>
			<td>������������ͯ����ĸ�໤�ʸ��о���</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE8_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">9</td>
			<td>����ḣ������������Ӥ��Ժ�ǼǱ���ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE9_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">10</td>
			<td>�����и���������˷����໤Ȩ��ͬ���������������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE10_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">11</td>
			<td>����������ͯ�������������鱨�浥��ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE11_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">12</td>
			<td>��������ͯ�ɳ�������渴ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE12_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">13</td>
			<td>����������ͯ�ɳ�״������ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE13_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">14</td>
			<td>��������ͯͬ�ⱻ��������������֤</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE14_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">15</td>
			<td>�����˻��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE15_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">16</td>
			<td>�������������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE16_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">17</td>
			<td>����֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE17_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">18</td>
			<td>����״��֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE18_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">19</td>
			<td>ְҵ֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE19_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">20</td>
			<td>��������ͲƲ�״��֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE20_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">21</td>
			<td>���彡�����֤��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE21_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">22</td>
			<td>�����ܹ����´�����֤��������</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE22_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">23</td>
			<td>���������ڹ����ܻ���ͬ������������Ů��֤��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE23_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">24</td>
			<td>��ͥ������漰����</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE24_NUM" defaultValue="1" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">25</td>
			<td>�����������ļ�ԭ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE25_NUM" defaultValue="2" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">26</td>
			<td>�����˻��ո�ӡ��</td>
			<td class="center"><BZ:input prefix="AI_" field="CATALOGUE1_FILE26_NUM" defaultValue="" restriction="plusInt" className="fileNum" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">27</td>
			<td>��Ƭ</td>
			<td class="center">&nbsp;&nbsp;&nbsp;<BZ:input prefix="AI_" field="CATALOGUE1_FILE27_NUM" defaultValue="" restriction="plusInt" style="width:25px;"/>��</td>
		</tr>
		<tr>
			<td class="center">28</td>
			<td>�ļ�����</td>
			<td class="center">
				<span id="total"></span>
			</td>
		</tr>
		<%
		}
		%>
	</table>
	<table style="width: 90%;" align="center">
		<tr>
			<td>�������ڣ�<BZ:input prefix="AI_" field="FILING_DATE" defaultValue="" type="date" /></td>
			<td style="text-align: right;">�����ˣ�<BZ:input prefix="AI_" field="FILING_USERNAME" defaultValue="" /></td>
		</tr>
	</table>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;&nbsp;ӡ" class="btn btn-sm btn-primary" onclick="_print()" />
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_save()" />
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
