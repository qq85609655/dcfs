<%
/**   
 * @Title: AZB_advice_list.jsp
 * @Description: ���ò���������б�
 * @author xugy
 * @date 2014-9-11����9:52:40
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%

	 //1 ��ȡ�����ֶΡ���������(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	
	Data data = (Data)request.getAttribute("data");
%>
<BZ:html>
	<BZ:head>
		<title>��������б�</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/dcfs/countryOrg.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>	
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_scroll(2000,2000);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
			var str = document.getElementById("S_PROVINCE_ID");
			selectWelfare(str);
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				moveOut : true,
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','260px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"advice/AZBAdviceList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_MATCH_PASSDATE_START").value = "";
			document.getElementById("S_MATCH_PASSDATE_END").value = "";
			document.getElementById("S_ADVICE_NOTICE_DATE_START").value = "";
			document.getElementById("S_ADVICE_NOTICE_DATE_END").value = "";
			document.getElementById("S_ADVICE_PRINT_NUM").value = "";
			document.getElementById("S_ADVICE_STATE").value = "";
			document.getElementById("S_ADVICE_REMINDER_STATE").value = "";
			document.getElementById("S_AF_COST_CLEAR").value = "";
			document.getElementById("S_ADVICE_FEEDBACK_RESULT").value = "";
			
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
		}
		//
		function selectWelfare(node){
			var provinceId = node.value;
			//���ڻ��Եø�������ID
			var selectedId = '<%=data.getString("WELFARE_ID") %>';
			
			var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
			if(dataList != null && dataList.size() > 0){
				//���
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--��ѡ��--",""));
				for(var i=0;i<dataList.size();i++){
					var data = dataList.getData(i);
					document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
					if(selectedId==data.getString("ORG_CODE")){
						document.getElementById("S_WELFARE_ID").value = selectedId;
					}
				}
			}else{
				//���
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--��ѡ��--",""));
			}
		}
		//��ӡ���������
		function _print(){//δ��
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					ids= ids + "#" + id.split(",")[0];
					num += 1;
				}
			}
			
			if(num < 1){
				page.alert('��ѡ���ӡ���� ');
				return;
			}else{
				if(num == 1){
					document.getElementById("ids").value = ids;
					document.srcForm.action=path+"advice/toAZBPrintPreview.action";
					document.srcForm.submit();
				}else{
					alert("������ӡ");
				}
			}
		}
		//֪ͨ������֯
		function _notice(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var ADVICE_STATE = id.split(",")[1];
					if(ADVICE_STATE != "1"){
						page.alert('��ѡ��δ֪ͨ������');
						return;
					}
					ids= ids + "#" + id.split(",")[0];
					num += 1;
				}
			}
			
			if(num < 1){
				page.alert('��ѡ��Ҫ֪ͨ������ ');
				return;
			}else{
				if (confirm('ȷ��֪ͨ������֯��')) {
					document.getElementById("ids").value = ids;
					document.srcForm.action=path+"advice/AZBnotice.action";
					document.srcForm.submit();
				}
			}
		}
		//����ȷ��
		function _feedbackConfirm(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var ADVICE_STATE = id.split(",")[1];
					if(ADVICE_STATE != "2"){
						page.alert('��ѡ�������������');
						return;
					}
					var AF_COST_CLEAR = id.split(",")[2];
					if(AF_COST_CLEAR != "1"){
						page.alert('�ļ�δ��ѣ���ֹ������������鷴��');
						return;
					}
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('��ѡ��һ������ ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"advice/feedbackConfirm.action";
				document.srcForm.submit();
			}
		}
		//
		function _detail(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('��ѡ��һ������ ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"advice/feedbackDetail.action";
				document.srcForm.submit();
			}
		}
		//�鿴�߰�֪ͨ
		function _reminderDetail(MI_ID){
			$.layer({
				type : 2,
				title : "�߰�֪ͨ�鿴",
				moveOut : true,
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				//page : {dom : '#planList'},
				iframe: {src: '<BZ:url/>/advice/AZBreminderDetail.action?MI_ID='+MI_ID},
				area: ['1050px','450px'],
				offset: ['40px' , '0px']
			});
		}
		//
		function _pdf(){
			document.srcForm.action=path+"advice/createPDF.action";
			document.srcForm.submit();
		}
	</script>
	<BZ:body property="data" codeNames="WJLX;PROVINCE;ETXB;GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="advice/AZBAdviceList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="ids" name="ids" value=""/>
		<input type="hidden" id="deleteuuid" name="deleteuuid" value=""/>
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" id="printuuid" name="printuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 8%;">���ı��</td>
								<td style="width: 18%;">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" maxlength="" />
								</td>
								
								<td class="bz-search-title" style="width: 9%;">����</td>
								<td style="width: 28%;">
									<BZ:select prefix="S_" field="COUNTRY_CODE" id="S_COUNTRY_CODE" defaultValue="" isCode="true" codeName="SYS_GJSY_CN" width="148px" formTitle="����" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID')">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 9%;">������֯</td>
								<td style="width: 28%;">
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" formTitle="������֯" width="148px" onchange="_setOrgID('S_PUB_ORGID',this.value)">
										<option value="">--��ѡ��������֯--</option>
									</BZ:select>
									<input type="hidden" id="S_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'/>
								</td>
							</tr>
							<tr>	
								
								<td class="bz-search-title">�з�</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="" />
								</td>
							
								<td class="bz-search-title">Ů��</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů��" maxlength="" />
								</td>
								
								<td class="bz-search-title">ʡ��</td>
								<td>
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isCode="true" codeName="PROVINCE" width="148px" onchange="selectWelfare(this)" formTitle="ʡ��" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">����Ժ</td>
								<td>
									<BZ:select prefix="S_" field="WELFARE_ID" id="S_WELFARE_ID" defaultValue="" width="148px;" formTitle="����Ժ">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">����</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="" />
								</td>
								<td class="bz-search-title">�Ա�</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" width="148px" formTitle="�Ա�" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">��������</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
								<td class="bz-search-title">ͨ������</td>
								<td>
									<BZ:input prefix="S_" field="MATCH_PASSDATE_START" id="S_MATCH_PASSDATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_MATCH_PASSDATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼͨ������" />~
									<BZ:input prefix="S_" field="MATCH_PASSDATE_END" id="S_MATCH_PASSDATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_MATCH_PASSDATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹͨ������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">֪ͨ����</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="ADVICE_NOTICE_DATE_START" id="S_ADVICE_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_ADVICE_NOTICE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ֪ͨ����" />~
									<BZ:input prefix="S_" field="ADVICE_NOTICE_DATE_END" id="S_ADVICE_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_ADVICE_NOTICE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ֪ͨ����" />
								</td>
								<td class="bz-search-title">��ӡ����</td>
								<td>
									<BZ:input prefix="S_" field="ADVICE_PRINT_NUM" id="S_ADVICE_PRINT_NUM" defaultValue="" formTitle="��ӡ����" maxlength="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">����״̬</td>
								<td>
									<BZ:select prefix="S_" field="ADVICE_STATE" id="S_ADVICE_STATE" width="148px" formTitle="����״̬" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">δ֪ͨ</BZ:option>
										<BZ:option value="2">������</BZ:option>
										<BZ:option value="3">�ѷ���</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">�߰�״̬</td>
								<td>
									<BZ:select prefix="S_" field="ADVICE_REMINDER_STATE" id="S_ADVICE_REMINDER_STATE" width="148px" formTitle="�߰�״̬" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">δ�߰�</BZ:option>
										<BZ:option value="1">�Ѵ߰�</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">���״̬</td>
								<td>
									<BZ:select prefix="S_" field="AF_COST_CLEAR" id="S_AF_COST_CLEAR" width="148px" formTitle="���״̬" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">δ���</BZ:option>
										<BZ:option value="1">�����</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�������</td>
								<td>
									<BZ:select prefix="S_" field="ADVICE_FEEDBACK_RESULT" id="S_ADVICE_FEEDBACK_RESULT" width="148px" formTitle="�������" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">ͬ��</BZ:option>
										<BZ:option value="2">��ͣ</BZ:option>
										<BZ:option value="3">����ƥ��</BZ:option>
										<BZ:option value="4">����</BZ:option>
									</BZ:select>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="��&nbsp;&nbsp;��" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="��&nbsp;&nbsp;��" onclick="_reset();" class="btn btn-sm btn-primary">
						</div>
					</td>
					<td class="bz-search-right"></td>
				</tr>
			</table>
		</div>
		<!-- ��ѯ������End -->
		<div class="page-content">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;ӡ" class="btn btn-sm btn-primary" onclick="_print()"/>&nbsp;
					<input type="button" value="ͨ&nbsp;&nbsp;֪" class="btn btn-sm btn-primary" onclick="_notice()"/>&nbsp;
					<input type="button" value="����ȷ��" class="btn btn-sm btn-primary" onclick="_feedbackConfirm()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
					<input type="button" value="����pdf" class="btn btn-sm btn-primary" onclick="_pdf()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls')"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive" style="overflow-x:scroll;">
				<div id="scrollDiv">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="FILE_NO">���ı��</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="COUNTRY_CN">����</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="NAME_CN">������֯</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="MALE_NAME">�з�</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FEMALE_NAME">Ů��</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="IS_CONVENTION_ADOPT">��Լ����</div>
								</th>
								
								<th style="width: 4%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting" id="SEX">�Ա�</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="BIRTHDAY">��������</div>
								</th>
								
								<th style="width: 5%;">
									<div class="sorting" id="MATCH_PASSDATE">ͨ������</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="ADVICE_PRINT_NUM">��ӡ����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="ADVICE_NOTICE_DATE">֪ͨ����</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="AF_COST_CLEAR">���״̬</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="ADVICE_STATE">����״̬</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="ADVICE_FEEDBACK_RESULT">�������</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="ADVICE_REMINDER_STATE">�߰�״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="mydata">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="ADVICE_STATE" defaultValue="" onlyValue="true"/>,<BZ:data field="AF_COST_CLEAR" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="FILE_NO" defaultValue=""/></td>
								<td><BZ:data field="COUNTRY_CN" defaultValue=""/></td>
								<td><BZ:data field="NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="MALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="IS_CONVENTION_ADOPT" defaultValue="" checkValue="0=��;1=��;"/></td>
								
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="NAME" defaultValue=""/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date"/></td>
								
								<td><BZ:data field="MATCH_PASSDATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="ADVICE_PRINT_NUM" defaultValue=""/></td>
								<td><BZ:data field="ADVICE_NOTICE_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="AF_COST_CLEAR" defaultValue="" checkValue="0=δ���;1=�����;"/></td>
								<td><BZ:data field="ADVICE_STATE" defaultValue="" checkValue="1=δ֪ͨ;2=������;3=�ѷ���;"/></td>
								<td><BZ:data field="ADVICE_FEEDBACK_RESULT" defaultValue="" checkValue="1=ͬ��;2=��ͣ;3=����ƥ��;4=����;"/></td>
								<td>
									<%
									String ADVICE_STATE = ((Data) pageContext.getAttribute("mydata")).getString("ADVICE_STATE");
									String ADVICE_REMINDER_STATE = ((Data) pageContext.getAttribute("mydata")).getString("ADVICE_REMINDER_STATE");
									if("1".equals(ADVICE_REMINDER_STATE)){
									    if("1".equals(ADVICE_STATE)){
									%>
									<a href="javascript:void(0);" onclick="_reminderDetail('<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>')"><font color="red"><BZ:data field="ADVICE_REMINDER_STATE" defaultValue="" checkValue="0=δ�߰�;1=�Ѵ߰�;"/></font></a>
									<%
									    }else{
									%>
									<a href="javascript:void(0);" onclick="_reminderDetail('<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>')"><BZ:data field="ADVICE_REMINDER_STATE" defaultValue="" checkValue="0=δ�߰�;1=�Ѵ߰�;"/></a>
									<%
									    }
									}else{
									%>
									<BZ:data field="ADVICE_REMINDER_STATE" defaultValue="" checkValue="0=δ�߰�;1=�Ѵ߰�;"/>
									<%} %>
								</td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				</div>
				<!--��ѯ����б���End -->
				<!--��ҳ������Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="���ò������������" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;IS_CONVENTION_ADOPT=FLAG,0:��&1:��;ADVICE_STATE=FLAG,1:δ֪ͨ&2:������&3:ͬ��&4:����ƥ��&5:��ͣ&6:����;ADVICE_REMINDER_STATE=FLAG,0:δ�߰�&1:�Ѵ߰�;BIRTHDAY=DATE;MATCH_PASSDATE=DATE;ADVICE_NOTICE_DATE=DATE,yyyy/MM/dd" exportField="FILE_NO=���ı��,15,20;COUNTRY_CN=����,10;NAME_CN=������֯,15;MALE_NAME=�з�,15;FEMALE_NAME=Ů��,15;IS_CONVENTION_ADOPT=��Լ����,15;PROVINCE_ID=ʡ��,10;WELFARE_NAME_CN=����Ժ,20;NAME=����,10;SEX=�Ա�,10;BIRTHDAY=��������,15;MATCH_PASSDATE=ͨ������,15;ADVICE_PRINT_NUM=��ӡ����,15;ADVICE_NOTICE_DATE=֪ͨ����,15;ADVICE_STATE=����״̬,15;ADVICE_REMINDER_STATE=�߰�״̬,15;"/></td>
						</tr>
					</table>
				</div>
				<!--��ҳ������End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>