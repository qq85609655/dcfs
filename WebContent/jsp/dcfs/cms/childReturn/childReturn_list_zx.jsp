<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
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
	Data da = (Data)request.getAttribute("data");
	String WELFARE_ID=da.getString("WELFARE_ID","");
%>
<BZ:html>
	<BZ:head>
		<title>��ͯ�����˲����б�(����)</title>
		<BZ:webScript list="true" isAjax="true" />
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			initProvOrg();
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
			document.srcForm.action=path+"cms/childreturn/returnListZX.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_RETURN_REASON").value = "";
			document.getElementById("S_BACK_TYPE").value = "";
			document.getElementById("S_BACK_RESULT").value = "";
			document.getElementById("S_APPLE_DATE_START").value = "";
			document.getElementById("S_APPLE_DATE_END").value = "";
		}	
		//����Ժ��ͯ���ϲ����б�����
		function _exportExcel(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		//�����ͯ�����˲���ѡ���б�ҳ��
		function _childReturn(){
			var url = path + "cms/childreturn/returnSelectZX.action";
			//var returnVal=window.open(url,"window",'height=700,width=1000,top=50,left=160,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no');
			//alert("����ֵ:"+returnVal);
			_open(url, "window", 1050, 680);
			}
		//�����ͯ�����˲�������ҳ��
		function _toReturn(CI_ID){
			document.srcForm.action=path+"cms/childreturn/toReturnAdd.action?CI_ID="+CI_ID+"&RETURN_LEVEL=3";
			document.srcForm.submit();
		}
		//�����˲���ȷ��ҳ��
		function _confirm(){
			var num = 0;
			var AR_ID = "";
			var RETURN_STATE="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					AR_ID =arrays[i].value.split("#")[0];
					RETURN_STATE=arrays[i].value.split("#")[1];
					 num++;
				}
			}
			if(num != "1"){
				page.alert("��ѡ��һ��Ҫȷ�ϵ��˲�����Ϣ��");
				return;
			}else{
				if(RETURN_STATE!="2"){
				   page.alert("ֻ��ȷ���˲���״̬Ϊ������ȷ�ϵ��˲�����Ϣ��������ѡ��");
				   return;
			    }
				document.srcForm.action=path+"cms/childreturn/toConfirm.action?AR_ID="+AR_ID+"&CONFIRM_LEVEL=3";
				document.srcForm.submit();
			}
		}
		//ʡ������Ժ��ѯ�����������跽��
		function selectWelfare(node){
			var provinceId = node.value;
			//���ڻ��Եø�������ID
			var selectedId = '<%=WELFARE_ID%>';
			var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
			if(dataList != null && dataList.size() > 0){
				//���
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--��ѡ����Ժ--",""));
				for(var i=0;i<dataList.size();i++){
					var data = dataList.getData(i);
					if(selectedId==data.getString("ORG_CODE")){
						document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
						var option = document.getElementById("S_WELFARE_ID");
						document.getElementById("S_WELFARE_ID").value = selectedId;
					}else{					
						document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
					}
				}
			}else{
				//���
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--��ѡ����Ժ--",""));
			}
		}
		//ʡ������Ժ��ѯ�����������跽��
		function initProvOrg(){
			var str = document.getElementById("S_PROVINCE_ID");
		     selectWelfare(str);
		}
	</script>
	<BZ:body property="data" codeNames="ETXB;TCLFLZX;PROVINCE;">
		<BZ:form name="srcForm" method="post" action="cms/childreturn/returnListZX.action">
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
								<td class="bz-search-title" style="width: 10%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td style="width: 16%">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="150" style="width: 65%"/>
								</td>
								
								<td class="bz-search-title" style="width: 12%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td style="width: 16%">
								    <BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="�Ա�" defaultValue="" width="70%">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
	                            <td class="bz-search-title" style="width: 10%">��������</td>
								<td style="width: 36%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
							    <td class="bz-search-title" >ʡ��</td>
								<td >
								    <BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"    isCode="true"  codeName="PROVINCE" formTitle="ʡ��" defaultValue="">
					 	                <BZ:option value="">--��ѡ��ʡ��--</BZ:option>
					                </BZ:select>
								</td>
								<td class="bz-search-title">����Ժ</td>
								<td colspan="3">
								    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="����Ժ" defaultValue="" width="40%">
						              <BZ:option value="">--��ѡ����Ժ--</BZ:option>
					                </BZ:select>
								</td>
							</tr>
							<tr>
							    <td class="bz-search-title" >��������</td>
								<td >
									<BZ:select prefix="S_" field="BACK_TYPE" id="S_BACK_TYPE" isCode="true" codeName="TCLFLZX" formTitle="��������" defaultValue="" width="70%">
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
								    <BZ:input prefix="S_" field="RETURN_REASON" id="S_RETURN_REASON" defaultValue="" formTitle="�˲���ԭ��"  maxlength="1000" style="width: 70%"/>
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
			<div class="wrapper" >
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch();"/>&nbsp;
					<input type="button" value="ȷ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_confirm();"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;¼" class="btn btn-sm btn-primary" onclick="_childReturn();"/>
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace"/>
									</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 4%;">
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
								<th style="width: 17%;">
									<div class="sorting" id="RETURN_REASON">�˲���ԭ��</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BACK_DATE">�˲�������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="BACK_RESULT">״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value='<BZ:data field="AR_ID" onlyValue="true"/>#<BZ:data field="RETURN_STATE" onlyValue="true"/>' class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SEX" defaultValue="" codeName="ETXB" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="APPLE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BACK_TYPE" defaultValue=""  codeName="TCLFLZX"  onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List"  exportXls="true" exportTitle="��ͯ�����˲���" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;APPLE_DATE=DATE;BACK_TYPE=CODE,TCLFLZX;BACK_DATE=DATE;BACK_RESULT=FLAG,0:δȷ��&1:��ȷ��;" exportField="PROVINCE_ID=ʡ��,10,20;WELFARE_NAME_CN=����Ժ,20;NAME=����,10;SEX=�Ա�,8;BIRTHDAY=��������,10;APPLE_DATE=��������,10;BACK_TYPE=��������,15;RETURN_REASON=�˲���ԭ��,50;BACK_DATE=�˲�������,15;BACK_RESULT=״̬,15;"/></td>
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