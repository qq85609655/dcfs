<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: preapprove_select.jsp
 * @Description: Ԥ������ѡ���б�
 * @author yangrt
 * @date 2014-9-29
 * @version V1.0   
 */
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
		<title>Ԥ������ѡ���б�</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
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
				area: ['1050px','330px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"sce/extensionapply/PreApproveApplySelect.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_NAME_PINYIN").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_RI_STATE").value = "";
			document.getElementById("S_PASS_DATE_START").value = "";
			document.getElementById("S_PASS_DATE_END").value = "";
			document.getElementById("S_REMINDERS_STATE").value = "";
			document.getElementById("S_REM_DATE_START").value = "";
			document.getElementById("S_REM_DATE_END").value = "";
			document.getElementById("S_REQ_DATE_START").value = "";
			document.getElementById("S_REQ_DATE_END").value = "";
			document.getElementById("S_SUBMIT_DATE_START").value = "";
			document.getElementById("S_SUBMIT_DATE_END").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_UPDATE_DATE_START").value = "";
			document.getElementById("S_UPDATE_DATE_END").value = "";
		}
		
		//�޸�ҳ����ת
		function _submit(){
			var num = 0;
			var RI_ID = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					RI_ID = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != "1"){
				alert('Please select one data!');
				return;
			}else{
				window.opener._applyAdd(RI_ID);
				window.close();
			}
		}
		
		//�б���
		function _exportExcel(){
			if(confirm('Are you sure you want to export to an Excel document?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}

	</script>
	<BZ:body property="data" codeNames="">
		<BZ:form name="srcForm" method="post" action="sce/extensionapply/ExtensionApplyList.action">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%">���ı��<br>Log-in No.</td>
								<td style="width: 15%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="" maxlength="50"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">��������<br>Adoptive father</td>
								<td style="width: 27%">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="" maxlength="150" style="width:270px;"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">Ů������<br>Adoptive mother</td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="" maxlength="150" style="width:270px;"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">��ͯ����<br>Child name</td>
								<td class="bz-search-value">
									<BZ:input prefix="S_" field="NAME_PINYIN" id="S_NAME_PINYIN" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								
								<td class="bz-search-title">�Ա�<br>Sex</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" formTitle="�Ա�" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="1">Male</BZ:option>
										<BZ:option value="2">Female</BZ:option>
										<BZ:option value="3">Bisexual</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">��������<br>D.O.B</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">Ԥ��״̬<br>Pre-approval status</td>
								<td>
									<BZ:select prefix="S_" field="RI_STATE" id="S_RI_STATE" formTitle="" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">to be submitted</BZ:option>
										<BZ:option value="1">submitted</BZ:option>
										<BZ:option value="2">in process of review</BZ:option>
										<BZ:option value="3">no pass</BZ:option>
										<BZ:option value="4">pass</BZ:option>
										<BZ:option value="5">unoperated</BZ:option>
										<BZ:option value="6">operated</BZ:option>
										<BZ:option value="7">matched</BZ:option>
										<BZ:option value="9">invalid</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">�ظ�����<br>Date of reply</td>
								<td>
									<BZ:input prefix="S_" field="PASS_DATE_START" id="S_PASS_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PASS_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="PASS_DATE_END" id="S_PASS_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PASS_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
								</td>
								
								<td class="bz-search-title">��������<br>Date of application</td>
								<td>
									<BZ:input prefix="S_" field="REQ_DATE_START" id="S_REQ_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REQ_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="REQ_DATE_END" id="S_REQ_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REQ_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">�߰�״̬<bt>Reminder status</td>
								<td>
									<BZ:select prefix="S_" field="REMINDERS_STATE" id="S_REMINDERS_STATE" formTitle="" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">un-reminded</BZ:option>
										<BZ:option value="1">reminded</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">�߰�����<br>Reminder date</td>
								<td>
									<BZ:input prefix="S_" field="REM_DATE_START" id="S_REM_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REM_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="REM_DATE_END" id="S_REM_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REM_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
								</td>
								
								<td class="bz-search-title">��ǰ�ļ��ݽ�����<br>Document submission deadline</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="SUBMIT_DATE_START" id="S_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="SUBMIT_DATE_END" id="S_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">��������<br>Log-in date</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
								</td>
								<td class="bz-search-title">����������<br>Last updated</td>
								<td>
									<BZ:input prefix="S_" field="UPDATE_DATE_START" id="S_UPDATE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_UPDATE_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="UPDATE_DATE_END" id="S_UPDATE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_UPDATE_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;" colspan="2">
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
					<input type="button" value="Confirm" class="btn btn-sm btn-primary" onclick="_submit()"/>&nbsp;
					<!-- <input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel();"/> -->
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 3%;">
									<div class="sorting_disabled">ѡ��<br>Select</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting_disabled">���<br>No.</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="MALE_NAME">��������<br>Adoptive father</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FEMALE_NAME">Ů������<br>Adoptive mother</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="NAME_PINYIN">��ͯ����<br>Child name</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="SEX">�Ա�<br>Sex</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="BIRTHDAY">��������<br>D.O.B</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="REQ_DATE">��������<br>Date of application</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PASS_DATE">������<br>Response date </div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="RI_STATE">Ԥ��״̬<br>Pre-approval status</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="SUBMIT_DATE">��ǰ�ļ��ݽ�����<br>Document submission deadline</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="REMINDERS_STATE">�߰�״̬<br>Reminder status</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="REM_DATE">�߰�����<br>Reminder date</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="REGISTER_DATE">��������<br>Log-in date</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="FILE_NO">���ı��<br>Log-in No.</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="UPDATE_DATE">����������<br>Last updated</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="RI_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME_PINYIN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" onlyValue="true" checkValue="1=Male;2=Female;3=Bisexual"/></td>
								<td><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REQ_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PASS_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="RI_STATE" defaultValue="" onlyValue="true" checkValue="0=to be submitted;1=submitted;2=in process of review;3=no pass;4=pass;5=unoperated;6=operated;7=matched;9=invalid;"/></td>
								<td><BZ:data field="SUBMIT_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REMINDERS_STATE" defaultValue="" onlyValue="true" checkValue="0=un-reminded;1=reminded;"/></td>
								<td><BZ:data field="REM_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REGISTER_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="UPDATE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" type="EN"/></td>
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