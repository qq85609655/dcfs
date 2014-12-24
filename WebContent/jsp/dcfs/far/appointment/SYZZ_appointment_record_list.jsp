<%
/**   
 * @Title: SYZZ_appointment_record_list.jsp
 * @Description: ������֯ԤԼ�����б�
 * @author xugy
 * @date 2014-9-29����5:31:34
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
	<BZ:head language="EN">
		<title>ԤԼ�����б�</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_scroll(1700,1700);
			var str = document.getElementById("S_PROVINCE_ID");
			selectWelfare(str);
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����(Query condition)",
				moveOut :true,
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','240px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"appointment/SYZZAppointmentRecordList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_SIGN_NO").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME_PINYIN").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_ORDER_DATE_START").value = "";
			document.getElementById("S_ORDER_DATE_END").value = "";
			document.getElementById("S_SUGGEST_DATE_START").value = "";
			document.getElementById("S_SUGGEST_DATE_END").value = "";
			document.getElementById("S_ORDER_STATE").value = "";
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
				document.getElementById("S_WELFARE_ID").options.add(new Option("--Please select--",""));
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
				document.getElementById("S_WELFARE_ID").options.add(new Option("--Please select--",""));
			}
		}
		//ԤԼ����
		function _appointment(){
			/* var w = document.body.clientWidth-20+'px';
			var h = window.screen.availHeight-160+'px';
			$.layer({
				type : 2,
				title : "ԤԼ����(Making appointments)",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				//page : {dom : '#planList'},
				moveOut: true,
				iframe: {src: '<BZ:url/>/appointment/SYZZAppointmentSelectList.action'},
				area: [w,h],
				offset: ['0px' , '0px']
			}); */
			
			window.open(path + "appointment/SYZZAppointmentSelectList.action","","height=600,width=1100,top=50,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no");
		}
		//
		function _appointmentAdd(id){
			//layer.closeAll();
			document.srcForm.action=path+"appointment/toSYZZAppointmentAdd.action?id="+id;
			document.srcForm.submit();
		}
		//
		function _appointmentMod(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var ORDER_STATE = id.split(",")[1];
					if(ORDER_STATE != "0"){
						alert("Please select a data hasn't been submitted.");
						return;
					}
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				alert('Please select one data');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"appointment/toSYZZAppointmentMod.action";
				document.srcForm.submit();
			}
		}
		
		
		//�鿴ԤԼ
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
				alert('Please select one data');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"appointment/SYZZAppointmentDetail.action";
				document.srcForm.submit();
			}
		}
		//�������ӡ
		/* function _appPrint(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					ids=id.split(",")[2];
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('Please select one data ');
				return;
			}else{
				window.open(path+"appointment/toApplicationPrint.action?MI_ID="+ids);
				
				document.srcForm.action=path+"appointment/toApplicationPrint.action?MI_ID="+ids;
				document.srcForm.submit();
			}
		} */
	</script>
	<BZ:body property="data" codeNames="ETXB;PROVINCE;">
		<BZ:form name="srcForm" method="post" action="appointment/SYZZAppointmentRecordList.action">
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
								<td class="bz-search-title">֪ͨ���<br>No. of travel notice</td>
								<td>
									<BZ:input prefix="S_" field="SIGN_NO" id="S_SIGN_NO" defaultValue="" formTitle="֪ͨ���" maxlength="" />
								</td>
								
								<td class="bz-search-title">�з�<br>Adoptive father</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="��������" maxlength="" />
								</td>
								
								<td class="bz-search-title">Ů��<br>Adoptive mother</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������" maxlength="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">ʡ��<br>Province</td>
								<td>
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isCode="true" codeName="PROVINCE" isShowEN="true" width="148px" onchange="selectWelfare(this)" formTitle="ʡ��" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">����Ժ<br>SWI</td>
								<td>
									<BZ:select prefix="S_" field="WELFARE_ID" id="S_WELFARE_ID" defaultValue="" width="148px" formTitle="����Ժ">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
							
								<td class="bz-search-title">����<br>Name</td>
								<td>
									<BZ:input prefix="S_" field="NAME_PINYIN" id="S_NAME_PINYIN" defaultValue="" formTitle="����" maxlength="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�Ա�<br>Sex</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" isShowEN="true" width="148px" formTitle="�Ա�" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">��������<br>D.O.B</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">ԤԼʱ��<br>Date of appointment</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="ORDER_DATE_START" id="S_ORDER_DATE_START" type="DateTime" dateFormat="yyyy-MM-dd HH:mm" dateExtend="maxDate:'#F{$dp.$D(\\'S_ORDER_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼԤԼʱ��" />~
									<BZ:input prefix="S_" field="ORDER_DATE_END" id="S_ORDER_DATE_END" type="DateTime" dateFormat="yyyy-MM-dd HH:mm" dateExtend="minDate:'#F{$dp.$D(\\'S_ORDER_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹԤԼʱ��" />
								</td>
								<td class="bz-search-title">ԤԼ״̬<br>Appointment status</td>
								<td>
									<BZ:select prefix="S_" field="ORDER_STATE" id="S_ORDER_STATE" width="148px" formTitle="ԤԼ״̬" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option> 
										<BZ:option value="0">to be submitted</BZ:option>
										<BZ:option value="1">to be confirmed</BZ:option>
										<BZ:option value="2">approved</BZ:option>
										<BZ:option value="3">rejected</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">����ʱ��<br>Suggested date</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="SUGGEST_DATE_START" id="S_SUGGEST_DATE_START" type="DateTime" dateFormat="yyyy-MM-dd HH:mm" dateExtend="maxDate:'#F{$dp.$D(\\'S_SUGGEST_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ����ʱ��" />~
									<BZ:input prefix="S_" field="SUGGEST_DATE_END" id="S_SUGGEST_DATE_END" type="DateTime" dateFormat="yyyy-MM-dd HH:mm" dateExtend="minDate:'#F{$dp.$D(\\'S_SUGGEST_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ����ʱ��" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="Search" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="Reset" onclick="_reset();" class="btn btn-sm btn-primary">
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
					<input type="button" value="Search" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="Making appointments" class="btn btn-sm btn-primary" onclick="_appointment()"/>&nbsp;
					<input type="button" value="Modify appointment application" class="btn btn-sm btn-primary" onclick="_appointmentMod()"/>&nbsp;
					<!-- <input type="button" value="�������ӡ" class="btn btn-sm btn-primary" onclick="_appPrint()"/>&nbsp; -->
					<input type="button" value="Check" class="btn btn-sm btn-primary" onclick="_detail()"/>
					<input type="button" value="Export" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls')"/>
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
								<th style="width: 4%;">
									<div class="sorting_disabled">���(No.)</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="SIGN_NO">֪ͨ���(No. of travel notice)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="MALE_NAME">�з�(Adoptive father)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FEMALE_NAME">Ů��(Adoptive mother)</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��(Province)</div>
								</th>
								<th style="width: 14%;">
									<div class="sorting" id="WELFARE_NAME_EN">����Ժ(SWI)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_PINYIN">����(Name)</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting" id="SEX">�Ա�(Sex)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="BIRTHDAY">��������(D.O.B)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="ORDER_DATE">ԤԼʱ��(Date of appointment)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="SUGGEST_DATE">����ʱ��(Suggested date)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="ORDER_STATE">ԤԼ״̬(Appointment status)</div>
								</th>
								
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="AR_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="ORDER_STATE" defaultValue="" onlyValue="true"/>,<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="SIGN_NO" defaultValue="" /></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" isShowEN="true"/></td>
								<td><BZ:data field="WELFARE_NAME_EN" defaultValue="" /></td>
								<td><BZ:data field="NAME_PINYIN" defaultValue="" /></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB" isShowEN="true"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date"/></td>
								<td><BZ:data field="ORDER_DATE" defaultValue="" type="DateTime" dateFormat="yyyy-MM-dd HH:mm"/></td>
								<td><BZ:data field="SUGGEST_DATE" defaultValue="" type="DateTime" dateFormat="yyyy-MM-dd HH:mm"/></td>
								<td><BZ:data field="ORDER_STATE" defaultValue="" checkValue="0=to be submitted;1=to be confirmed;2=approved;3=rejected;"/></td>
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
							<td><BZ:page isShowEN="true" form="srcForm" property="List" type="EN" exportXls="true" exportTitle="�Ǽ�ԤԼ����" exportCode="SEX=CODE,ETXB;PROVINCE_ID=CODE,PROVINCE;ORDER_STATE=FLAG,0:to be submitted&1:to be confirmed&2:approved&3:rejected;BIRTHDAY=DATE,yyyy/MM/dd;" exportField="SIGN_NO=֪ͨ���(No. of travel notice),15,20;MALE_NAME=�з�(Adoptive father),15;FEMALE_NAME=Ů��(Adoptive mother),15;PROVINCE_ID=ʡ��(Province),15;WELFARE_NAME_EN=����Ժ(SWI),20;NAME_PINYIN=����(Name),15;SEX=�Ա�(Sex),10;BIRTHDAY=��������(D.O.B),15;ORDER_DATE=ԤԼʱ��(Date of appointment),15;SUGGEST_DATE=����ʱ��(Suggested date),15;ORDER_STATE=ԤԼ״̬(Appointment status),15;"/></td>
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