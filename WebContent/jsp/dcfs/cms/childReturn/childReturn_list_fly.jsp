<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: childAddition_list_fly.jsp
	 * @Description:  ��ͯ���ϲ����б�(����Ժ)
	 * @author furx   
	 * @date 2014-9-4 ����12:12:34 
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
	<BZ:head>
		<title>��ͯ�����˲����б�(����Ժ)</title>
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
				title : "��ѯ����",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1000px','200px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"cms/childreturn/returnListFLY.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_BACK_TYPE").value = "";
			document.getElementById("S_BACK_RESULT").value = "";
			document.getElementById("S_APPLE_DATE_START").value = "";
			document.getElementById("S_APPLE_DATE_END").value = "";
			document.getElementById("S_RETURN_REASON").value = "";
		}
		//�����ͯ�����˲���ѡ���б�ҳ��
		function _childReturn(){
			var url = path + "cms/childreturn/returnSelectFLY.action";
			//var returnVal=window.open(url,"window",'height=700,width=1000,top=50,left=160,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no');
			//alert("����ֵ:"+returnVal);
			_open(url, "window", 1000, 680);
			}	
		//����Ժ��ͯ���ϲ����б���
		function _exportExcel(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		//�����ͯ�����˲�������ҳ��
		function _toReturn(CI_ID){
			document.srcForm.action=path+"cms/childreturn/toReturnAdd.action?CI_ID="+CI_ID+"&RETURN_LEVEL=1";
			document.srcForm.submit();
		}
	</script>
	<BZ:body property="data" codeNames="ETXB;TCLFLST;">
		<BZ:form name="srcForm" method="post" action="cms/childreturn/returnListFLY.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 12%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td style="width: 16%">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="150" style="width: 65%"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td style="width: 16%">
								    <BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="�Ա�" defaultValue="" width="70%">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
	                            <td class="bz-search-title" style="width: 12%">��������</td>
								<td style="width: 34%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
							    <td class="bz-search-title" >��������</td>
								<td >
								    <BZ:select prefix="S_" field="BACK_TYPE" id="S_BACK_TYPE" isCode="true" codeName="TCLFLST" formTitle="��������" defaultValue="" width="70%">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>	
								
								<td class="bz-search-title">״̬</td>
								<td>
								    <BZ:select prefix="S_" field="BACK_RESULT" id="S_BACK_RESULT"  formTitle="״̬" defaultValue="" width="70%">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">��ȷ��</BZ:option>
										<BZ:option value="0">δȷ��</BZ:option>
									</BZ:select>
								</td>
							
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="APPLE_DATE_START" id="S_APPLE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_APPLE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="APPLE_DATE_END" id="S_APPLE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_APPLE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">�˲���ԭ��</td>
								<td colspan="5">
								    <BZ:input prefix="S_" field="RETURN_REASON" id="S_RETURN_REASON" defaultValue="" formTitle="�˲���ԭ��"  maxlength="1000" style="width: 65%"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
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
					<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch();"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_childReturn();"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
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
										<input type="checkbox" class="ace"/>
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">�Ա�</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">��������</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="APPLE_DATE">��������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="BACK_TYPE">��������</div>
								</th>
								<th style="width: 34%;">
									<div class="sorting" id="RETURN_REASON">�˲���ԭ��</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="BACK_DATE">�˲�������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="BACK_RESULT">״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="AR_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SEX" defaultValue="" codeName="ETXB" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="APPLE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BACK_TYPE" defaultValue=""  codeName="TCLFLST"  onlyValue="true"/></td>
								<td ><BZ:data field="RETURN_REASON" defaultValue="" onlyValue="true"/></td>
								<td class="center" ><BZ:data field="BACK_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BACK_RESULT" defaultValue="" checkValue="0=δȷ��;1=��ȷ��;" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List"  exportXls="true" exportTitle="��ͯ�����˲���" exportCode="SEX=CODE,ETXB;BIRTHDAY=DATE;APPLE_DATE=DATE;BACK_TYPE=CODE,TCLFLST;BACK_DATE=DATE;BACK_RESULT=FLAG,0:δȷ��&1:��ȷ��;" exportField="NAME=����,10,20;SEX=�Ա�,8;BIRTHDAY=��������,10;APPLE_DATE=��������,10;BACK_TYPE=��������,15;RETURN_REASON=�˲���ԭ��,50;BACK_DATE=�˲�������,15;BACK_RESULT=״̬,15;"/></td>
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