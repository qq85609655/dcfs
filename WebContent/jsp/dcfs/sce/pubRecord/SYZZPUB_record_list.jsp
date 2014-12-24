<%
/**   
 * @Title: AZB_record_list.jsp
 * @Description: ������֯�㷢�˻ز鿴�б�
 * @author lihf 
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
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
%>
<BZ:html>
	<BZ:head language="EN">
		<title>�㷢�˻��б�</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����(Query condition)",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','260px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//����
		function _export(){
			if(confirm('Are you sure you want to export to an Excel document?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		//�鿴
		function _detail(){
			var num = 0;
			var ids="";
			var id = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids = document.getElementsByName('xuanze')[i].value;
					id=ids.split(",")[0];
					num += 1;
				}
			}
			if(num != 1){
				alert('Please select one data ');
				return;
			}else{
				$.layer({
					type: 2,
					closeBtn: [0, true],
					shade : [0.5 , '#D9D9D9' , true],
					border :[2 , 0.3 , '#000', true],
					iframe: {
						src: path+'record/SYZZPUBRecordDetail.action?PUB_ID='+id+'&type=show'
					},
					title: "�㷢�˻ز鿴(Check agency-specific files returned )",
					area: ['1000px','400px'],
					offset: ['50px' , '50px']
				});
			}
		}


		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"record/SYZZPUBRecordList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("C_PROVINCE_ID").value = "";
			document.getElementById("C_NAME_PINYIN").value = "";
			document.getElementById("C_SEX").value = "";
			document.getElementById("C_SN_TYPE").value = "";
			document.getElementById("C_BIRTHDAY_START").value = "";
			document.getElementById("C_BIRTHDAY_END").value = "";
			document.getElementById("C_RETURN_STATE").value = "";
			document.getElementById("C_RETURN_DATE_START").value = "";
			document.getElementById("C_RETURN_DATE_END").value = "";
			document.getElementById("C_PUB_DATE_START").value = "";
			document.getElementById("C_PUB_DATE_END").value = "";
			document.getElementById("C_SETTLE_DATE_START").value = "";
			document.getElementById("C_SETTLE_DATE_END").value = "";
			document.getElementById("C_RETURN_CFM_DATE_START").value = "";
			document.getElementById("C_RETURN_CFM_DATE_END").value = "";
		}
		//ί���˻�
		function _syzzReturn(){
			var num = 0;
			var ids="";
			var id = "";
			var state = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids = document.getElementsByName('xuanze')[i].value;
					id=ids.split(",")[0];
					state = ids.split(",")[1];
					num += 1;
				}
			}
			if(num != 1){
				alert('Please select one data ');
				return;
			}else{
				if(state!=0){
					alert('��ѡ����δ�˻صĶ�ͯ��¼');
					return ;
				}else{					
					document.srcForm.action=path+"record/SYZZPUBRecordDetail.action?PUB_ID="+id+"&type=revise";
					document.srcForm.submit();
				}
			}
		}
	</script>
	<BZ:body property="data" codeNames="ETXB;BCZL;PROVINCE;">
		<BZ:form name="srcForm"  method="post" action="record/SYZZPUBRecordList.action">
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
								<td class="bz-search-title">ʡ��<br>Province</td>
								<td>
									<BZ:select prefix="C_" field="PROVINCE_ID" id="C_PROVINCE_ID" isCode="true" codeName="PROVINCE" isShowEN="true" formTitle="ʡ��" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">����<br>Child name</td>
								<td>
									<BZ:input prefix="C_" field="NAME_PINYIN" id="C_NAME_PINYIN" defaultValue="" formTitle="����" maxlength="" />
								</td>
								<td class="bz-search-title">�Ա�<br>Sex</td>
								<td>
									<BZ:select prefix="C_" field="SEX" id="C_SEX" isCode="true" codeName="ETXB" isShowEN="true" formTitle="�Ա�" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">��������<br>SN type</td>
								<td>
									<BZ:select prefix="C_" field="SN_TYPE" id="C_SN_TYPE" isCode="true" codeName="BCZL" isShowEN="true" formTitle="��������" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">��������<br>D.O.B</td>
								<td colspan="3">
									<BZ:input prefix="C_" field="BIRTHDAY_START" id="C_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_BIRTHDAY_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="C_" field="BIRTHDAY_END" id="C_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_BIRTHDAY_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">��������<br>Released date</td>
								<td>
									<BZ:input prefix="C_" field="PUB_DATE_START" id="C_PUB_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_PUB_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="C_" field="PUB_DATE_END" id="C_PUB_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_PUB_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ��������" />
								</td>
								<td class="bz-search-title">��������<br>Deadline of placement</td>
								<td>
									<BZ:input prefix="C_" field="SETTLE_DATE_START" id="C_SETTLE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_SETTLE_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="C_" field="SETTLE_DATE_END" id="C_SETTLE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_SETTLE_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ��������" />
								</td>
								<td class="bz-search-title">�˻�����<br>Return date</td>
								<td>
									<BZ:input prefix="C_" field="RETURN_DATE_START" id="C_RETURN_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_RETURN_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ�˻�����" />~
									<BZ:input prefix="C_" field="RETURN_DATE_END" id="C_RETURN_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_RETURN_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ�˻�����" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">ȷ������<br>Confirmation date</td>
								<td>
									<BZ:input prefix="C_" field="RETURN_CFM_DATE_START" id="C_RETURN_CFM_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'C_RETURN_CFM_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ��ȷ�ϻ�����" />~
									<BZ:input prefix="C_" field="RETURN_CFM_DATE_END" id="C_RETURN_CFM_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'C_RETURN_CFM_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ�˻�ȷ������" />
								</td>
								<td class="bz-search-title">�˻�״̬<br>Return status</td>
								<td>
									<BZ:select prefix="C_" field="RETURN_STATE" id="C_RETURN_STATE" formTitle="�˻�״̬" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">to be confirmed</BZ:option>
										<BZ:option value="1">confirmed</BZ:option>
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
					<input type="button" value="Check" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
					<input type="button" value="Export" class="btn btn-sm btn-primary" onclick="_export()"/>
					<input type="button" value="Return entrusted file" class="btn btn-sm btn-primary" onclick="_syzzReturn()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 3%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">���(No.)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��(Province)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NAME_PINYIN">����(Child name)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">�Ա�(Sex)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">��������(D.O.B)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="SN_TYPE">��������(SN type)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="PUB_DATE">��������(Released date)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="SETTLE_DATE">��������(Deadline of placement)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="RETURN_DATE">�˻�����(Return date)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="RETURN_CFM_DATE">ȷ������(Confirmation date)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="RETURN_STATE">�˻�״̬(Return status)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="PUB_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="RETURN_STATE" defaultValue="" checkValue="0=��ȷ��;1=��ȷ��;" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" isShowEN="true" onlyValue="true"/></td>
								<td><BZ:data field="NAME_PINYIN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB" isShowEN="true" onlyValue="true"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" isShowEN="true" onlyValue="true"/></td>
								<td><BZ:data field="PUB_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="SETTLE_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_CFM_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_STATE" defaultValue="" checkValue="0=to be confirmed;1=confirmed;" onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--��ѯ����б���End -->
				<!--��ҳ������Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td>	
								<BZ:page isShowEN="true" form="srcForm" property="List" type="EN" exportXls="true" exportTitle="������֯�㷢�˻ؼ�¼" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ADOPTER_CHILDREN_SEX;BIRTHDAY=DATE;SN_TYPE=CODE,BCZL;PUB_DATE=DATE;SETTLE_DATE=DATE;RETURN_DATE=DATE;RETURN_CFM_DATE=DATE;RETURN_STATE=FLAG,0:to be confirmed&1:confirmed;" exportField="PROVINCE_ID=ʡ��(Province),15,20;NAME=����(Child name),15;SEX=�Ա�(Sex),15;BIRTHDAY=��������(D.O.B),15;SN_TYPE=��������(SN type),15;PUB_DATE=��������(Released date),15;SETTLE_DATE=��������(Deadline of placement),15;RETURN_DATE=�˻�����(Return date),15;RETURN_CFM_DATE=ȷ������(Confirmation date),15;RETURN_STATE=�˻�״̬(Return status),15;"/>
							</td>
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