<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: extensionapply_list.jsp
 * @Description: �������������б�
 * @author yangrt
 * @date 2014-9-28
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
		<title>�������������б�</title>
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
				area: ['1000px','250px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"sce/extensionapply/ExtensionApplyList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_AUDIT_STATE").value = "";
			document.getElementById("S_NAME_PINYIN").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_SUBMIT_DATE_START").value = "";
			document.getElementById("S_SUBMIT_DATE_END").value = "";
			document.getElementById("S_REQ_SUBMIT_DATE_START").value = "";
			document.getElementById("S_REQ_SUBMIT_DATE_END").value = "";
		}
		
		function _preApproveSelect(){
			var url = path + "sce/extensionapply/PreApproveApplySelect.action";
			_open(url,"window",1200,600);
		}
		
		function _applyAdd(ri_id){
			document.srcForm.action= path +"sce/extensionapply/ExtensionApplyAdd.action?RI_ID=" + ri_id;
			document.srcForm.submit();
		}
		
		//�޸�ҳ����ת
		function _show(){
			var num = 0;
			var def_id = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					def_id = arrays[i].value;
					num += 1;
				}
			}
			if(num != "1"){
				alert('Please select one data!');
				return;
			}else{
				document.srcForm.action=path+"sce/extensionapply/ExtensionApplyShow.action?type=apply&DEF_ID=" + def_id;
				document.srcForm.submit();
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
	<BZ:body property="data" codeNames="ETXB;">
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
								<td class="bz-search-title" style="width: 10%">��������<br>Adoptive father</td>
								<td style="width: 30%">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="" maxlength="150" style="width:270px;"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">Ů������<br>Adoptive mother</td>
								<td style="width: 30%">
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="" maxlength="150" style="width:270px;"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">����״̬<br>Extension application status </td>
								<td style="width: 10%">
									<BZ:select prefix="S_" field="AUDIT_STATE" id="S_AUDIT_STATE" formTitle="" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">to be reviewed</BZ:option>
										<BZ:option value="1">approved</BZ:option>
										<BZ:option value="2">rejected</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">��ͯ����<br>Child name</td>
								<td class="bz-search-value">
									<BZ:input prefix="S_" field="NAME_PINYIN" id="S_NAME_PINYIN" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								
								<td class="bz-search-title">��������<br>D.O.B</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ��������" />
								</td>
								
								<td class="bz-search-title">�Ա�<br>Sex</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" formTitle="�Ա�" defaultValue="" codeName="ETXB" isCode="true" isShowEN="true">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�ļ��ݽ�����<br>Application submission date</td>
								<td>
									<BZ:input prefix="S_" field="SUBMIT_DATE_START" id="S_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="SUBMIT_DATE_END" id="S_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SUBMIT_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
								</td>
								
								<td class="bz-search-title">�ļ���ʱ����<br>Date of extension application</td>
								<td>
									<BZ:input prefix="S_" field="REQ_SUBMIT_DATE_START" id="S_REQ_SUBMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REQ_SUBMIT_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="REQ_SUBMIT_DATE_END" id="S_REQ_SUBMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REQ_SUBMIT_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
								</td>
								
								<td class="bz-search-title">&nbsp;</td>
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
					<input type="button" value="Search" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="Apply to extend deadline" class="btn btn-sm btn-primary" onclick="_preApproveSelect()"/>&nbsp;
					<input type="button" value="View" class="btn btn-sm btn-primary" onclick="_show()"/>&nbsp;
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
								<th style="width: 4%;">
									<div class="sorting_disabled">���<br>No.</div>
								</th>
								<th style="width: 16%;">
									<div class="sorting" id="MALE_NAME">��������<br>Adoptive father</div>
								</th>
								<th style="width: 16%;">
									<div class="sorting" id="FEMALE_NAME">Ů������<br>Adoptive mother</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_PINYIN">��ͯ����<br>Child name</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="SEX">�Ա�<br>Sex</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="BIRTHDAY">��������<br>D.O.B</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="SUBMIT_DATE">�ļ��ݽ�����<br>Application submission date</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="REQ_SUBMIT_DATE">�ļ���ʱ����<br>Date of extension application</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="AUDIT_STATE">����״̬<br>Extension application status</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="DEF_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME_PINYIN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" onlyValue="true"  codeName="ETXB" isShowEN="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SUBMIT_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REQ_SUBMIT_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_STATE" defaultValue="" onlyValue="true" checkValue="0=to be reviewed;1=approved;2=rejected;"/></td>
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