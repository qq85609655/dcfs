<%
/**   
 * @Title: fileremind_list.jsp
 * @Description: �ݽ��ļ��߰��ѯ�б�
 * @author panfeng
 * @date 2014-9-15����5:01:29 
 * @version V1.0   
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
		<title>�ݽ��ļ��߰��ѯ�б�</title>
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
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"sce/fileRemind/findRemindList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_NAME_PINYIN").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_REQ_DATE_START").value = "";
			document.getElementById("S_REQ_DATE_END").value = "";
			document.getElementById("S_PASS_DATE_START").value = "";
			document.getElementById("S_PASS_DATE_END").value = "";
			document.getElementById("S_SUBMIT_DATE_START").value = "";
			document.getElementById("S_SUBMIT_DATE_END").value = "";
			document.getElementById("S_REM_DATE_START").value = "";
			document.getElementById("S_REM_DATE_END").value = "";
		}
		
		//�鿴�߰�֪ͨ
		function _detail(){
			var num = 0;
			var showuuid = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					showuuid = arrays[i].value.split("#")[0];
					num ++;
				}
			}
			if(num != "1"){
				alert("Please select one data!");
				return;
			}else{
				var url = path+"sce/fileRemind/showRemindNotice.action?showuuid=" + showuuid;
				modalDialog(url, this, 650, 350);
			}
		}
		
	</script>
	<BZ:body property="data" codeNames="ETXB;">
		<BZ:form name="srcForm" method="post" action="sce/fileRemind/findRemindList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title">��������<br>Adoptive father</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="" />
								</td>
								<td class="bz-search-title">Ů������<br>Adoptive mother</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů��" maxlength="" />
								</td>
								<td class="bz-search-title">��������<br>Date of application</td>
								<td>
									<BZ:input prefix="S_" field="REQ_DATE_START" id="S_REQ_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REQ_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="REQ_DATE_END" id="S_REQ_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REQ_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ��������" />
								</td>
								
								
							</tr>
							<tr>
								<td class="bz-search-title">����<br>Name</td>
								<td>
									<BZ:input prefix="S_" field="NAME_PINYIN" id="S_NAME_PINYIN" defaultValue="" formTitle="����" maxlength="" />
								</td>
								<td class="bz-search-title">�Ա�<br>Sex</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" isShowEN="true" formTitle="�Ա�" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">��������<br>D.O.B</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">������<br>Response date</td>
								<td>
									<BZ:input prefix="S_" field="PASS_DATE_START" id="S_PASS_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PASS_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ������" />~
									<BZ:input prefix="S_" field="PASS_DATE_END" id="S_PASS_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PASS_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ������" />
								</td>
								<td class="bz-search-title">�ݽ�����<br>Document submission deadline</td>
								<td>
									<BZ:input prefix="S_" field="SUBMIT_DATE_START" id="S_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ�ݽ�����" />~
									<BZ:input prefix="S_" field="SUBMIT_DATE_END" id="S_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ�ݽ�����" />
								</td>
								<td class="bz-search-title">�߰�����<br>Reminder date</td>
								<td>
									<BZ:input prefix="S_" field="REM_DATE_START" id="S_REM_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REM_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ�߰�����" />~
									<BZ:input prefix="S_" field="REM_DATE_END" id="S_REM_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REM_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ�߰�����" />
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
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
								&nbsp;
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">���(No.)</div>
								</th>
								<th style="width: 13%;">
									<div class="sorting" id="MALE_NAME">��������(Adoptive father)</div>
								</th>
								<th style="width: 13%;">
									<div class="sorting" id="FEMALE_NAME">Ů������(Adoptive mother)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_PINYIN">����(Name)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">�Ա�(Sex)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="BIRTHDAY">��������(D.O.B)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="REQ_DATE">��������(Date of application)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="PASS_DATE">������(Response date )</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="SUBMIT_DATE">��ǰ�ļ��ݽ�����(Document submission deadline)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="REM_DATE">�߰�����(Reminder date)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="REM_ID" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME_PINYIN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB" isShowEN="true" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" defaultValue="" type="date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REQ_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="PASS_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SUBMIT_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REM_DATE" defaultValue="" type="date" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List" type="EN" /></td>
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