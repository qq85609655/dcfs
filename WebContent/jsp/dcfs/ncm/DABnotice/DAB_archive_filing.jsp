<%
/**   
 * @Title: DAB_archive_filing.jsp
 * @Description: �鵵����
 * @author xugy
 * @date 2014-11-2����11:27:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("data");

String CHILD_IDENTITY = data.getString("CHILD_IDENTITY");
String MALE_NAME = data.getString("MALE_NAME","");
String FEMALE_NAME = data.getString("FEMALE_NAME","");


TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<script type="text/javascript" src="<%=path %>/resource/js/common.js"/>
<BZ:head>
	<title>��ͯ��Ϣ�鿴</title>
	<BZ:webScript edit="true" tree="true"/>
	<up:uploadResource cancelJquerySupport="true"/>
	<link href="<%=path %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=path %>/resource/js/easytabs/jquery.easytabs.js"/>
    <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
</BZ:head>

<BZ:body property="data" codeNames="WJLX;ETSFLX;GJSY;ADOPTER_HEALTH;PROVINCE;BCZL;ETSFLX;ETXB;SYLX;GJ;">
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	$('#tab-container').easytabs();
	
	var spanElement = $(".fileNum");
	var total = 0;
	for(var i=0;i<spanElement.length;i++){
		var num = spanElement[i].innerHTML;
		total = total + Number(num);
	}
	$("#total").text(total);
	
});
var path = "<%=path %>/";
//����
function _saveFiling(){
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	if (confirm('ȷ���鵵��')) {
		document.srcForm.action=path+"notice/saveDABArchiveFiling.action";
		document.srcForm.submit();
	}
}
//�����б�
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
	vertical-align: middle;
}
.center {
	text-align: center;
}
</style>
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input prefix="AI_" field="ARCHIVE_ID" defaultValue="" type="hidden"/>
<BZ:input prefix="AF_" field="AF_ID" defaultValue="" type="hidden"/>
<BZ:input prefix="CI_" field="CI_ID" defaultValue="" type="hidden"/>
	<div id="tab-container" class='tab-container'>
		<ul class="etabs">
			<li class="tab"><a href="#tab1">����������������Ŀ¼��һ��</a></li>
			<li class="tab"><a href="#tab2">�鵵�����</a></li>
		</ul>
		<div class='panel-container'>
			<div id="tab1">
				<div style="text-align: center;"><b><font size="4">����������������Ŀ¼��һ��</font></b></div>
				<table style="width: 50%;margin-top: 10px;" align="center">
					<tr style="height: 30px;">
						<td style="width: 30%;">�����ţ�<BZ:dataValue field="ARCHIVE_NO" defaultValue="" /></td>
						<td style="text-align: right;">��������������<BZ:dataValue field="NAME" defaultValue="" /></td>
					</tr>
					<tr style="height: 30px;">
						<td>�ļ����ͣ�<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX"/></td>
						<td  style="text-align: right;">��ͯ��ݣ�<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" codeName="ETSFLX"/></td>
					</tr>
				</table>
				<table style="width: 50%;margin-top: 10px;" align="center" id="tab">
					<colgroup>
						<col width="10%"/>
						<col width="75%"/>
						<col width="15%"/>
					</colgroup>
					<tr>
						<td class="center">���</td>
						<td class="center">�ļ�����</td>
						<td class="center">����</td>
					</tr>
					<%
					if("10".equals(CHILD_IDENTITY)){
					%>
					<tr>
						<td class="center">1</td>
						<td>����������֪ͨ���������� </td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE1_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">2</td>
						<td>������������Ů֪ͨ�顷��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE2_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">3</td>
						<td>��������������顷</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE3_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">4</td>
						<td>����������������顷</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE4_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">5</td>
						<td>������������������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE5_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">6</td>
						<td>�����˾������֤��ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE6_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">7</td>
						<td>�������˻���֤����ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE7_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">8</td>
						<td>����ʰ��Ӥ�ǼǱ���ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE8_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">9</td>
						<td>����ḣ������������Ӥ��Ժ�ǼǱ���ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE9_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">10</td>
						<td>������Ӥ��ͯ����ĸ���渴ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE10_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">11</td>
						<td>����������ͯ�������������鱨�浥��ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE11_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">12</td>
						<td>��������ͯ�ɳ�������渴ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE12_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">13</td>
						<td>����������ͯ�ɳ�״������ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE13_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">14</td>
						<td>�����˻��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE14_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">15</td>
						<td>�������������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE15_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">16</td>
						<td>����֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE16_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">17</td>
						<td>����״��֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE17_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">18</td>
						<td>ְҵ֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE18_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">19</td>
						<td>��������ͲƲ�״��֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE19_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">20</td>
						<td>���彡�����֤��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE20_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">21</td>
						<td>�����ܹ����´�����֤��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE21_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">22</td>
						<td>���������ڹ����ܻ���ͬ������������Ů��֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE22_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">23</td>
						<td>��ͥ������漰����</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE23_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">24</td>
						<td>�����˻��ո�ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE24_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">25</td>
						<td>�����������ļ�ԭ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE25_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">26</td>
						<td>��Ƭ</td>
						<td class="center">&nbsp;&nbsp;&nbsp;<BZ:dataValue field="CATALOGUE1_FILE26_NUM" defaultValue=""/>��</td>
					</tr>
					<tr>
						<td class="center">27</td>
						<td>����</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE27_NUM" defaultValue="" className="fileNum"/></td>
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
					if("201".equals(CHILD_IDENTITY) || "202".equals(CHILD_IDENTITY)){
					%>
					<tr>
						<td class="center">1</td>
						<td>����������֪ͨ���������� </td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE1_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">2</td>
						<td>������������Ů֪ͨ�顷��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE2_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">3</td>
						<td>��������������顷</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE3_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">4</td>
						<td>����������������顷</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE4_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">5</td>
						<td>������������������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE5_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">6</td>
						<td>�����˾������֤��ӡ���������˻���֤����ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE6_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">7</td>
						<td>�������˻���֤����ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE7_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">8</td>
						<td>����ḣ���������չ¶���Ժ�ǼǱ���ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE8_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">9</td>
						<td>�����и����¶�������˷����໤Ȩ��ͬ���������������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE9_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">10</td>
						<td>��������ͯ����ĸ��������������֤����ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE10_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">11</td>
						<td>�¶�ԭ��ͥסַ���ڵش���ίԱ������ίԱ�����</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE11_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">12</td>
						<td>����������ͯ�������������鱨�浥��ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE12_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">13</td>
						<td>��������ͯ�ɳ�������渴ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE13_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">14</td>
						<td>����������ͯ�ɳ�״������ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE14_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">15</td>
						<td>��������ͬ�ⱻ��������������֤</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE15_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">16</td>
						<td>�����˻��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE16_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">17</td>
						<td>�������������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE17_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">18</td>
						<td>����֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE18_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">19</td>
						<td>����״��֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE19_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">20</td>
						<td>ְҵ֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE20_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">21</td>
						<td>��������ͲƲ�״��֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE21_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">22</td>
						<td>���彡�����֤��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE22_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">23</td>
						<td>�����ܹ����´�����֤��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE23_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">24</td>
						<td>���������ڹ����ܻ���ͬ������������Ů��֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE24_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">25</td>
						<td>��ͥ������漰����</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE25_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">26</td>
						<td>�����˻��ո�ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE26_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">27</td>
						<td>�����������ļ�ԭ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE27_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">28</td>
						<td>��Ƭ</td>
						<td class="center">&nbsp;&nbsp;&nbsp;<BZ:dataValue field="CATALOGUE1_FILE28_NUM" defaultValue=""/>��</td>
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
					if("301".equals(CHILD_IDENTITY) || "302".equals(CHILD_IDENTITY)){
					%>
					<tr>
						<td class="center">1</td>
						<td>����������֪ͨ���������� </td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE1_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">2</td>
						<td>������������Ů֪ͨ�顷��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE2_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">3</td>
						<td>��������������顷</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE3_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">4</td>
						<td>����������������顷</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE4_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">5</td>
						<td>������������������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE5_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">6</td>
						<td>�����˾������֤��ӡ���������˻���֤����ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE6_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">7</td>
						<td>ת�Ƽ໤ȨЭ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE7_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">8</td>
						<td>����ĸ�������໤��ͬ���������������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE8_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">9</td>
						<td>���������䲻��һ������ĸ�ĸ�ĸ����ʹ���ȸ���Ȩ������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE9_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">10</td>
						<td>�����и����������ͬ���������������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE10_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">11</td>
						<td>����������������ĸ��������������֤����ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE11_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">12</td>
						<td>������������ĸ��������������������֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE12_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">13</td>
						<td>��������ͬ�ⱻ��������������֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE13_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">14</td>
						<td>����������ͯ�������������鱨�浥��ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE14_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">15</td>
						<td>��������ͯ�ɳ�������渴ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE15_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">16</td>
						<td>����������ͯ�ɳ�״������ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE16_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">17</td>
						<td>�����˻��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE17_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">18</td>
						<td>�������������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE18_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">19</td>
						<td>����֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE19_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">20</td>
						<td>����״��֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE20_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">21</td>
						<td>ְҵ֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE21_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">22</td>
						<td>��������ͲƲ�״��֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE22_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">23</td>
						<td>���彡�����֤��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE23_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">24</td>
						<td>�����ܹ����´�����֤��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE24_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">25</td>
						<td>���������ڹ����ܻ���ͬ������������Ů��֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE25_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">26</td>
						<td>��ͥ������漰����</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE26_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">27</td>
						<td>�����˻��ո�ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE27_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">28</td>
						<td>�����������ļ�ԭ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE28_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">29</td>
						<td>��Ƭ</td>
						<td class="center">&nbsp;&nbsp;&nbsp;<BZ:dataValue field="CATALOGUE1_FILE29_NUM" defaultValue=""/>��</td>
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
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE1_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">2</td>
						<td>������������Ů֪ͨ�顷��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE2_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">3</td>
						<td>��������������顷</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE3_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">4</td>
						<td>����������������顷</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE4_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">5</td>
						<td>������������������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE5_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">6</td>
						<td>�����˾������֤��ӡ���������˻���֤����ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE6_NUM" defaultValue="3" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">7</td>
						<td>�����������������������鱨�浥��ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE7_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">8</td>
						<td>�������뵱�ؼƻ���������ǩ���Ĳ�Υ���ƻ������涨��Э��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE8_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">9</td>
						<td>�������뱻�����˵�������ϵ֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE9_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">10</td>
						<td>�������������˵�������ϵ֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE10_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">11</td>
						<td>��������������������������ϵѪ�׵���Ů������ϵ֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE11_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">12</td>
						<td>������ͬ����������������֤</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE12_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">13</td>
						<td>�����˽��֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE13_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">14</td>
						<td>�������뱻��������������ĸ����֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE14_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">15</td>
						<td>����������Ը����������������֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE15_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">16</td>
						<td>����ĸ����֤�����໤��ͬ����������������֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE16_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">17</td>
						<td>�����˻��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE17_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">18</td>
						<td>�������������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE18_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">19</td>
						<td>����֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE19_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">20</td>
						<td>����״��֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE20_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">21</td>
						<td>ְҵ֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE21_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">22</td>
						<td>��������ͲƲ�״��֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE22_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">23</td>
						<td>���彡�����֤��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE23_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">24</td>
						<td>�����ܹ����´�����֤��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE24_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">25</td>
						<td>���������ڹ����ܻ���ͬ������������Ů��֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE25_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">26</td>
						<td>��ͥ������漰����</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE26_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">27</td>
						<td>�����˻��ո�ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE27_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">28</td>
						<td>�����������ļ�ԭ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE28_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">29</td>
						<td>��Ƭ</td>
						<td class="center">&nbsp;&nbsp;&nbsp;<BZ:dataValue field="CATALOGUE1_FILE29_NUM" defaultValue=""/>��</td>
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
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE1_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">2</td>
						<td>������������Ů֪ͨ�顷��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE2_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">3</td>
						<td>��������������顷</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE3_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">4</td>
						<td>����������������顷</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE4_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">5</td>
						<td>������������������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE5_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">6</td>
						<td>�����˾������֤��ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE6_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">7</td>
						<td>�������˻���֤����ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE7_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					</tr>
					<tr>
						<td class="center">8</td>
						<td>������������ͯ����ĸ�໤�ʸ��о���</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE8_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">9</td>
						<td>����ḣ������������Ӥ��Ժ�ǼǱ���ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE9_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">10</td>
						<td>�����и���������˷����໤Ȩ��ͬ���������������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE10_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">11</td>
						<td>����������ͯ�������������鱨�浥��ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE11_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">12</td>
						<td>��������ͯ�ɳ�������渴ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE12_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">13</td>
						<td>����������ͯ�ɳ�״������ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE13_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">14</td>
						<td>��������ͯͬ�ⱻ��������������֤</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE14_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">15</td>
						<td>�����˻��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE15_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">16</td>
						<td>�������������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE16_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">17</td>
						<td>����֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE17_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">18</td>
						<td>����״��֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE18_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">19</td>
						<td>ְҵ֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE19_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">20</td>
						<td>��������ͲƲ�״��֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE20_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">21</td>
						<td>���彡�����֤��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE21_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">22</td>
						<td>�����ܹ����´�����֤��������</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE22_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">23</td>
						<td>���������ڹ����ܻ���ͬ������������Ů��֤��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE23_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">24</td>
						<td>��ͥ������漰����</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE24_NUM" defaultValue="1" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">25</td>
						<td>�����������ļ�ԭ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE25_NUM" defaultValue="2" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">26</td>
						<td>�����˻��ո�ӡ��</td>
						<td class="center"><BZ:dataValue field="CATALOGUE1_FILE26_NUM" defaultValue="" className="fileNum"/></td>
					</tr>
					<tr>
						<td class="center">27</td>
						<td>��Ƭ</td>
						<td class="center">&nbsp;&nbsp;&nbsp;<BZ:dataValue field="CATALOGUE1_FILE27_NUM" defaultValue=""/>��</td>
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
				<table style="width: 50%;margin-top: 10px;" align="center">
					<tr>
						<td>�������ڣ�<BZ:dataValue field="FILING_DATE" defaultValue="" type="date"/></td>
						<td style="text-align: right;">�����ˣ�<BZ:dataValue field="FILING_USERNAME" defaultValue="" /></td>
					</tr>
				</table>
			</div>
			<div id="tab2">
				<table class="specialtable">
					<tr>
						<td class="edit-data-title" style="text-align:center"><b>�ļ�������Ϣ</b></td>
					</tr>
					<tr>
						<td>
							<table class="specialtable">
								<tr>
									<td class="edit-data-title" width="15%">����</td>
									<td class="edit-data-value" width="35%">
										<BZ:dataValue field="COUNTRY_CODE" defaultValue="" codeName="GJSY"/>
									</td>
									<td class="edit-data-title" width="15%">������֯</td>
									<td class="edit-data-value" width="35%">
										<BZ:dataValue field="NAME_CN" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">���ı��</td>
									<td class="edit-data-value">
										<BZ:dataValue field="FILE_NO" defaultValue=""/>
									</td>
									<td class="edit-data-title">��������</td>
									<td class="edit-data-value">
										<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">�ļ�����</td>
									<td class="edit-data-value">
										<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX"/>
									</td>
									<td class="edit-data-title">��������</td>
									<td class="edit-data-value">
										<BZ:dataValue field="FAMILY_TYPE" defaultValue="" codeName="SYLX"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��������֪ͨ����</td>
									<td class="edit-data-value">
										<BZ:dataValue field="SIGN_NO" defaultValue=""/>
									</td>
									<td class="edit-data-title">ǩ������</td>
									<td class="edit-data-value">
										<BZ:dataValue field="SIGN_DATE" defaultValue="" type="date"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">�����Ǽ�״̬</td>
									<td class="edit-data-value">
										<BZ:dataValue field="ADREG_STATE" defaultValue="" checkValue="0=δ�Ǽ�;1=�ѵǼ�;2=��Ч�Ǽ�;3=ע��;" />
									</td>
									<td class="edit-data-title">�����Ǽ�����</td>
									<td class="edit-data-value">
										<BZ:dataValue field="ADREG_DATE" defaultValue="" type="date"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">������</td>
									<td class="edit-data-value">
										<BZ:dataValue field="ARCHIVE_NO" defaultValue=""/>
									</td>
									<td class="edit-data-title"></td>
									<td class="edit-data-value">
										<BZ:dataValue field="" defaultValue=""/>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" style="text-align:center"><b>���������</b></td>
					</tr>
					<tr>
						<td>
							<table class="specialtable">
								<tr>
									<td class="edit-data-title" width="15%">��������</td>
									<td class="edit-data-value" width="23%">
										<BZ:dataValue field="MALE_NAME" defaultValue=""/>
									</td>
									<td class="edit-data-value" width="12%" rowspan="4">
										<%
										if(!"".equals(MALE_NAME)){
										%>
										<img style="width: 130px;height: 152px;" src='<up:attDownload attTypeCode="AF" packageId='<BZ:dataValue field="MALE_PHOTO" defaultValue="" onlyValue="true"/>' smallType="<%=AttConstants.AF_MALEPHOTO %>"/>'></img>
										<%} %>
									</td>
									<td class="edit-data-title" width="15%">Ů������</td>
									<td class="edit-data-value" width="23%">
										<BZ:dataValue field="FEMALE_NAME" defaultValue=""/>
									</td>
									<td class="edit-data-value" width="12%" rowspan="4">
										<%
										if(!"".equals(FEMALE_NAME)){
										%>
										<img style="width: 130px;height: 152px;" src='<up:attDownload attTypeCode="AF" packageId='<BZ:dataValue field="FEMALE_PHOTO" defaultValue="" onlyValue="true"/>' smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>'></img>
										<%} %>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">����</td>
									<td class="edit-data-value">
										<%
										if(!"".equals(MALE_NAME)){
										%>
										<BZ:dataValue field="MALE_NATION" defaultValue="" codeName="GJ"/>
										<%} %>
									</td>
									<td class="edit-data-title">����</td>
									<td class="edit-data-value">
										<%
										if(!"".equals(FEMALE_NAME)){
										%>
										<BZ:dataValue field="FEMALE_NATION" defaultValue="" codeName="GJ"/>
										<%} %>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��������</td>
									<td class="edit-data-value">
										<%
										if(!"".equals(MALE_NAME)){
										%>
										<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" type="date"/>
										<%} %>
									</td>
									<td class="edit-data-title">��������</td>
									<td class="edit-data-value">
										<%
										if(!"".equals(FEMALE_NAME)){
										%>
										<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" type="date"/>
										<%} %>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">ְҵ</td>
									<td class="edit-data-value">
										<%
										if(!"".equals(MALE_NAME)){
										%>
										<BZ:dataValue field="MALE_JOB_CN" defaultValue=""/>
										<%} %>
									</td>
									<td class="edit-data-title">ְҵ</td>
									<td class="edit-data-value">
										<%
										if(!"".equals(FEMALE_NAME)){
										%>
										<BZ:dataValue field="FEMALE_JOB_CN" defaultValue=""/>
										<%} %>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">����״��</td>
									<td class="edit-data-value" colspan="2">
										<%
										if(!"".equals(MALE_NAME)){
										%>
										<BZ:dataValue field="MALE_HEALTH" defaultValue="" codeName="ADOPTER_HEALTH"/>
										<%} %>
									</td>
									<td class="edit-data-title">����״��</td>
									<td class="edit-data-value" colspan="2">
										<%
										if(!"".equals(FEMALE_NAME)){
										%>
										<BZ:dataValue field="FEMALE_HEALTH" defaultValue="" codeName="ADOPTER_HEALTH"/>
										<%} %>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="edit-data-title" style="text-align:center"><b>�����������</b></td>
					</tr>
					<tr>
						<td>
							<table class="specialtable">
								<tr>
									<td class="edit-data-title" width="15%">��ͯ����</td>
									<td class="edit-data-value" width="23%">
										<BZ:dataValue field="NAME" defaultValue=""/>
									</td>
									<td class="edit-data-value" width="12%" rowspan="4">
										<img style="width: 130px;height: 152px;" src='<up:attDownload attTypeCode="CI" packageId='<BZ:dataValue field="PHOTO_CARD" defaultValue="" onlyValue="true"/>' smallType="<%=AttConstants.CI_IMAGE %>"/>'></img>
									</td>
									<td class="edit-data-title" width="15%">����ƴ��</td>
									<td class="edit-data-value" width="35%">
										<BZ:dataValue field="NAME_PINYIN" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">�Ա�</td>
									<td class="edit-data-value">
										<BZ:dataValue field="SEX" defaultValue="" codeName="ETXB"/>
									</td>
									<td class="edit-data-title">ʡ��</td>
									<td class="edit-data-value">
										<BZ:dataValue field="PROVINCE_ID" defaultValue="" codeName="PROVINCE"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��������</td>
									<td class="edit-data-value">
										<BZ:dataValue field="BIRTHDAY" defaultValue="" type="date"/>
									</td>
									<td class="edit-data-title">����Ժ</td>
									<td class="edit-data-value">
										<BZ:dataValue field="WELFARE_NAME_CN" defaultValue=""/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��������</td>
									<td class="edit-data-value">
										<BZ:dataValue field="SN_TYPE" defaultValue="" codeName="BCZL"/>
									</td>
									<td class="edit-data-title">��ͯ���</td>
									<td class="edit-data-value">
										<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" codeName="ETSFLX"/>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='panel-container'>
			<table class="specialtable">
				<tr>
					<td class="edit-data-title" style="text-align:center"><b>�鵵����</b></td>
				</tr>
				<tr>
					<td>
						<table class="specialtable">
							<tr>
								<td class="edit-data-title" width="15%">������</td>
								<td class="edit-data-value" width="35%">
									<BZ:input prefix="AI_" field="FILING_USERNAME" defaultValue="" formTitle="������"/>
								</td>
								<td class="edit-data-title" width="15%">��������</td>
								<td class="edit-data-value" width="35%">
									<BZ:input prefix="AI_" field="FILING_DATE" defaultValue="" type="date" formTitle="��������"/>
								</td>
							</tr>
							<tr>
								<td class="edit-data-title">��ע</td>
								<td class="edit-data-value" colspan="3">
									<BZ:input prefix="AI_" field="FILING_REMARKS" defaultValue="" type="textarea" style="width:98%;height:60px;"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<div style="text-align: center;">
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_saveFiling()" />&nbsp;
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
</BZ:form>
</BZ:body>
</BZ:html>