<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: specialFile_selectlist.jsp
	 * @Description:  Ԥ��ͨ����������Ϣ�б�
	 * @author yangrt   
	 * @date 2014-7-21 ����6:33:34 
	 * @version V1.0   
	 */
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
		<title>Ԥ��ͨ����������Ϣ�б�</title>
		<BZ:webScript edit="true" list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/resource1/js/page.js"></script>
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
				area: ['1080px','280px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"ffs/filemanager/SpecialFileSelectList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_REQ_NO").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_NAME_PINYIN").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_REQ_DATE_START").value = "";
			document.getElementById("S_REQ_DATE_END").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_PASS_DATE_START").value = "";
			document.getElementById("S_PASS_DATE_END").value = "";
			document.getElementById("S_SUBMIT_DATE_START").value = "";
			document.getElementById("S_SUBMIT_DATE_END").value = "";
			document.getElementById("S_REMINDERS_STATE").value = "";
		}
		
		//�ݽ������ļ����
		function _fileAdd(ri_id,req_no,file_type){
			if(confirm('Are you sure to submit this special needs file?')){
				var isSubmit = "true";
				if(file_type == "23"){
					isSubmit = getStr("com.dcfs.sce.preApproveApply.PreApproveApplyAjax","type=file&REQ_NO=" + req_no);
				}
				if(isSubmit == "true"){
					document.srcForm.action=path+"ffs/filemanager/SpecialFileAdd.action?RI_ID=" + ri_id;
					document.srcForm.submit();
				}else{
					alert("��ȴ���һ����˫Ԥ��ͨ��֮���ٵݽ��ļ���");
					return;
				}
			}else{
				return;
			}
		}
		
	</script>
	<BZ:body property="data" codeNames="ETXB;">
		<BZ:form name="srcForm" method="post" action="ffs/filemanager/SpecialFileSelectList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!-- ������begin -->
		<div class="bz-edit-data-content clearfix" desc="������" style="width: 98%;margin-left:auto;margin-right:auto;">
			<div class="stepflex" style="margin-right: 30px;">
		        <dl id="payStepFrist" class="first doing">
		            <dt class="s-num">1</dt>
		            <dd class="s-text" style="margin-left: 3px;">��һ����ѡ��Ԥ���ļ�<br>Step 1: Choose an application for pre-approval</dd>
		        </dl>
		        <dl id="payStepNormal" class="last">
		            <dt class="s-num">2</dt>
		            <dd class="s-text" style="margin-left: 3px;">�ڶ�����¼����ϸ��Ϣ<br>Step 2: Input detailed information<s></s>
		                <b></b>
		            </dd>
		        </dl>
			</div>
		</div>
		<!-- ������end -->
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 12%"><span title="������">������<br>APPLICATION<br>NUMBER</span></td>
								<td style="width: 8%">
									<BZ:input prefix="S_" field="REQ_NO" id="S_REQ_NO" defaultValue="" formTitle="������" maxlength="50"/>
								</td>
								
								<td class="bz-search-title" style="width: 12%"><span title="Adoptive father">��������<br>Adoptive father</span></td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="Adoptive father" maxlength="150" style="width:270px;"/>
								</td>
								
								<td class="bz-search-title" style="width: 12%">Ů������<br>Adoptive mother</td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Adoptive mother" maxlength="150" style="width:270px;"/>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">��ͯ����<br>Child name</td>
								<td>
									<BZ:input prefix="S_" field="NAME_PINYIN" id="S_NAME_PINYIN" defaultValue="" formTitle="Child name" maxlength="200"/>
								</td>
							
								<td class="bz-search-title">��������<br>D.O.B</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue=""/>~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue=""/>
								</td>
								
								<td class="bz-search-title">��������<br>Application date</td>
								<td>
									<BZ:input prefix="S_" field="REQ_DATE_START" id="S_REQ_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REQ_DATE_END\\')}',readonly:true" defaultValue=""/>~
									<BZ:input prefix="S_" field="REQ_DATE_END" id="S_REQ_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REQ_DATE_START\\')}',readonly:true" defaultValue=""/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�Ա�<br>Sex</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" formTitle="" defaultValue="" isCode="true" codeName="ETXB" isShowEN="true" width="95%">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>	
								
								<td class="bz-search-title">ͨ������<br>Approval date</td>
								<td>
									<BZ:input prefix="S_" field="PASS_DATE_START" id="S_PASS_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PASS_DATE_END\\')}',readonly:true" defaultValue=""/>~
									<BZ:input prefix="S_" field="PASS_DATE_END" id="S_PASS_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PASS_DATE_START\\')}',readonly:true" defaultValue=""/>
								</td>
								
								<td class="bz-search-title">�ļ��ݽ�����<br>Document submission deadline</td>
								<td>
									<BZ:input prefix="S_" field="SUBMIT_DATE_START" id="S_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_END\\')}',readonly:true" defaultValue=""/>~
									<BZ:input prefix="S_" field="SUBMIT_DATE_END" id="S_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_START\\')}',readonly:true" defaultValue=""/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�߰�״̬<br>Reminder status</td>
								<td>
									<BZ:select prefix="S_" field="REMINDERS_STATE" id="S_REMINDERS_STATE" formTitle="" defaultValue="" width="95%;">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">un-reminded</BZ:option>
										<BZ:option value="1">reminded</BZ:option>
									</BZ:select>
								</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
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
					<input type="button" value="Search" class="btn btn-sm btn-primary" onclick="_showSearch()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--�б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 4%;">
									<div class="sorting_disabled">���(No.)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting_disabled" id="REQ_NO">������(APPLICATION NUMBER)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="MALE_NAME">��������(Adoptive father)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="FEMALE_NAME">Ů������(Adoptive mother)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="NAME_PINYIN">��ͯ����(Child name)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting_disabled" id="SEX">�Ա�(Sex)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting_disabled" id="BIRTHDAY">��������(D.O.B)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="REQ_DATE">��������(Application date)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="PASS_DATE">ͨ������(Approval date)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="SUBMIT_DATE">�ļ��ݽ�����(Document submission deadline)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting_disabled" id="REMINDERS_STATE">�߰�״̬(Reminder status)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting_disabled">����(Operation)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="REQ_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME_PINYIN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB" isShowEN="true" onlyValue="true"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="REQ_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="PASS_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="SUBMIT_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="REMINDERS_STATE" defaultValue="" checkValue="0=un-reminded;1=reminded;" onlyValue="true"/></td>
								<td class="center">
									<input type="button" value="Submit application" class="btn btn-sm btn-primary" onclick="_fileAdd('<BZ:data field="RI_ID" defaultValue="" onlyValue="true"/>','<BZ:data field="PRE_REQ_NO" defaultValue="" onlyValue="true"/>','<BZ:data field="FILE_TYPE" defaultValue="" onlyValue="true"/>')"/>
								</td>
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