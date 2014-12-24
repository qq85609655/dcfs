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
		<title>�쵼ǩ���б�</title>
		<BZ:webScript list="true" isAjax="true" edit="true"/>
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
				area: ['1050px','270px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"leaderSing/findSignlist.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_SIGN_SUBMIT_DATE_START").value = "";
			document.getElementById("S_SIGN_SUBMIT_DATE_END").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_SIGN_DATE_START").value = "";
			document.getElementById("S_SIGN_DATE_END").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			//document.getElementById("S_CHILD_TYPE").value = "";
			document.getElementById("S_SIGN_STATE").value = "0";
			
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
		}
		
		//ǩ��
		function _sign(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					if(id.split(",")[1]!=0){
						page.alert('��ѡ��"��ǩ��"״̬������');	
						return
					}else{
						ids = ids + "#" + id.split(",")[0];
						num += 1;
					}
				}
			}
			
			if(num < 1){
				page.alert('��ѡ��ǩ������');
				return;
			}else{
				document.getElementById("ids").value = ids;
				if(num == 1){
					document.srcForm.action=path+"leaderSing/inSignfrom.action";
					document.srcForm.submit();
				}else{
					alert();
					$.layer({
						type : 1,
						title : "ǩ��",
						shade : [0.5 , '#D9D9D9' , true],
						border :[2 , 0.3 , '#000', true],
						page : {dom : '#signDIV'},
						area: ['500px','150px'],
						offset: ['40px' , '0px'],
						closeBtn: [0, true]
					});
				}
			}
		}
		
		function _ok(){
			if (!runFormVerify(document.signForm, false)) {
				return;
			}
			var SIGN_DATE = document.getElementById("F_SIGN_DATE").value;
			var SIGN_STATE = document.getElementById("F_SIGN_STATE").value;
			document.srcForm.action=path+"leaderSing/signConfirmAll.action?SIGN_DATE="+SIGN_DATE+"&SIGN_STATE="+SIGN_STATE;
			document.srcForm.submit();
		}
		
		  
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
	</script>
	<BZ:body property="data" codeNames="WJLX;PROVINCE;ETXB;GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="leaderSing/findSignlist.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="ids" name="ids" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title">���ı��</td>
								<td>
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" maxlength="" />
								</td>
								<td class="bz-search-title">�ļ�����</td>
								<td>
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" width="148px" formTitle="�ļ�����" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
							<td class="bz-search-title">����</td>
								<td>
									<BZ:select prefix="S_" field="COUNTRY_CODE" id="S_COUNTRY_CODE" defaultValue="" isCode="true" codeName="SYS_GJSY_CN" width="148px" formTitle="����" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID')">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">������֯</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" formTitle="������֯" width="148px" onchange="_setOrgID('S_PUB_ORGID',this.value)">
										<option value="">--��ѡ��������֯--</option>
									</BZ:select>
									<input type="hidden" id="S_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'/>
								</td>
								
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="SIGN_SUBMIT_DATE_START" id="S_SIGN_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SIGN_SUBMIT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="SIGN_SUBMIT_DATE_END" id="S_SIGN_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SIGN_SUBMIT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
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
								<td class="bz-search-title">ǩ������</td>
								<td>
									<BZ:input prefix="S_" field="SIGN_DATE_START" id="S_SIGN_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SIGN_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="SIGN_DATE_END" id="S_SIGN_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SIGN_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
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
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">ʡ��</td>
								<td>
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isCode="true" codeName="PROVINCE" onchange="selectWelfare(this)" formTitle="ʡ��" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">����Ժ</td>
								<td>
									<BZ:select prefix="S_" field="WELFARE_ID" id="S_WELFARE_ID" defaultValue="" width="148px" formTitle="����Ժ">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<%-- <td class="bz-search-title">��ͯ����</td>
								<td>
									<BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" formTitle="��ͯ����" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">������ͯ</BZ:option>
										<BZ:option value="2">�����ͯ</BZ:option>
									</BZ:select>
								</td> --%>
								<td class="bz-search-title">ǩ��״̬</td>
								<td>
									<BZ:select prefix="S_" field="SIGN_STATE" id="S_SIGN_STATE" width="148px" formTitle="ǩ��״̬" defaultValue="0">
										<BZ:option value="0">��ǩ��</BZ:option>
										<BZ:option value="1">ͬ��</BZ:option>
										<BZ:option value="2">��ͬ��</BZ:option>
										<BZ:option value="9">ȫ��</BZ:option>
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
					<input type="button" value="ǩ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_sign()"/>&nbsp;
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
								<th style="width: 5%;">
									<div class="sorting" id="REGISTER_DATE">��������</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="COUNTRY_CN">����</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_CN">������֯</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="MALE_NAME">�з�</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="FEMALE_NAME">Ů��</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="FILE_TYPE">�ļ�����</div>
								</th>
								
								<!-- <th style="width: 5%;">
									<div class="sorting" id="CHILD_TYPE">��ͯ����</div>
								</th> -->
								<th style="width: 4%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 11%;">
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
									<div class="sorting" id="SIGN_SUBMIT_DATE">��������</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SIGN_DATE">ǩ������</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="SIGN_STATE">ǩ��״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="SIGN_STATE" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="COUNTRY_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
								<%-- <td><BZ:data field="CHILD_TYPE" defaultValue="" checkValue="1=������ͯ;2=�����ͯ;" onlyValue="true"/></td> --%>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB" onlyValue="true"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="SIGN_SUBMIT_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="SIGN_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="SIGN_STATE" defaultValue="" checkValue="0=��ǩ��;1=ͬ��;2=��ͬ��;" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="֪ͨ��ǩ������" exportCode="FILE_TYPE=CODE,WJLX;PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ADOPTER_CHILDREN_SEX;NOTICE_STATE=FLAG,0:δ֪ͨ&1:��֪ͨ;REGISTER_DATE=DATE;BIRTHDAY=DATE;SIGN_DATE=DATE;NOTICE_SIGN_DATE=DATE;NOTICE_DATE=DATE,yyyy/MM/dd" exportField="FILE_NO=���ı��,15,20;REGISTER_DATE=��������,15;COUNTRY_CN=����,15;NAME_CN=������֯,20;MALE_NAME=�з�,15;FEMALE_NAME=Ů��,15;FILE_TYPE=�ļ�����,10;PROVINCE_ID=ʡ��,10;WELFARE_NAME_CN=����Ժ,20;NAME=����,10;SEX=�Ա�,10;BIRTHDAY=��������,15;SIGN_DATE=ǩ������,15;NOTICE_SIGN_DATE=�������,15;NOTICE_PRINT_NUM=��ӡ����,10;NOTICE_DATE=֪ͨ����,15;NOTICE_STATE=֪ͨ״̬,10;"/></td>
						</tr>
					</table>
				</div>
				<!--��ҳ������End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
		<div id="signDIV" style="display: none;width: 100%;">
			<BZ:form name="signForm" method="post">
				<div class="bz-edit clearfix" desc="�༭����">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<div class="bz-edit-data-content clearfix" desc="������">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="20%"><font color="red">*</font>ǩ������</td>
									<td class="bz-edit-data-value" width="30%">
										<BZ:input prefix="F_" field="SIGN_DATE" id="F_SIGN_DATE" defaultValue="" type="date" formTitle="ǩ������" notnull="ǩ�����ڲ���Ϊ��"/>
									</td>
									<td class="bz-edit-data-title" width="20%">ǩ�����</td>
									<td class="bz-edit-data-value" width="30%">
										<BZ:select prefix="F_" field="SIGN_STATE" id="F_SIGN_STATE" formTitle="ǩ�����">
											<BZ:option value="1" selected="true">ͬ��</BZ:option>
											<BZ:option value="2">��ͬ��</BZ:option>
										</BZ:select>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<div class="bz-action-frame">
					<div class="bz-action-edit" desc="��ť��">
						<input type="button" value="ȷ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_ok()" />
					</div>
				</div>
			</BZ:form>
		</div>
	</BZ:body>
</BZ:html>