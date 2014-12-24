<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.cms.childManager.ChildStateManager"%>
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
	Data da = (Data)request.getAttribute("data");
    String WELFARE_ID=da.getString("WELFARE_ID","");
%>
<BZ:html>
	<BZ:head>
		<title>��ͯ���ϸ���ѡ���б�(����)</title>
		<BZ:webScript list="true" isAjax="true"/>
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
			//�ж�����ĸ��´����Ƿ���Ч
			var updateNum=document.getElementById("S_UPDATE_NUM").value;
			var intNum=parseInt(updateNum);
			if(updateNum!=""){
				var r=/^\+?[1-9][0-9]*$/;
				if(!r.test(updateNum)){
					 alert("���´���������Ч��");
					 return;
					}
				}
			document.srcForm.action=path+"cms/childupdate/updateSelectZX.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_SN_TYPE").value = "";
			document.getElementById("S_SPECIAL_FOCUS").value = "";
			document.getElementById("S_CHECKUP_DATE_START").value = "";
			document.getElementById("S_CHECKUP_DATE_END").value = "";
			document.getElementById("S_UPDATE_NUM").value = "";
			document.getElementById("S_PUB_STATE").value = "";
			document.getElementById("S_ADREG_STATE").value = "";
			document.getElementById("S_RI_STATE").value = "";
		}	
		//���¶�ͯ����
		function _toUpdate(){
			var CI_ID = "";
			var UPDATE_STATE="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					 CI_ID =arrays[i].value.split("#")[0];
					 UPDATE_STATE=arrays[i].value.split("#")[2];
					 break;
				}
			}
			if(CI_ID== ""){
				page.alert("��ѡ��Ҫ���µĲ��ϣ�");
				return;
			}else{
				if(UPDATE_STATE=="<%=ChildStateManager.CHILD_UPDATE_STATE_WTJ%>"||UPDATE_STATE=="<%=ChildStateManager.CHILD_UPDATE_STATE_SDS%>"||UPDATE_STATE=="<%=ChildStateManager.CHILD_UPDATE_STATE_ZXDS%>"){
				  alert("�ö�ͯ�����Ѵ��ڸ�������,������ѡ��");
				  return;
				}
				document.srcForm.action=path+"cms/childupdate/toUpdateFLY.action?CI_ID="+CI_ID+"&UPDATE_TYPE=3";
			    document.srcForm.submit();
			}
		}
		//�б���
		function _exportExcel(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
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
		function showChildInfo(obj){
			url = path+"/cms/childManager/showForAZQ.action?UUID="+obj.name;
			_open(url, "��ͯ������Ϣ", 1000, 600);
			
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;BCZL;FBZT;YPZT">
		<BZ:form name="srcForm" method="post" action="cms/childupdate/updateSelectZX.action">
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
							    <td class="bz-search-title" style="width: 8%">ʡ��</td>
								<td style="width: 16%">
									<BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="95%"  isCode="true"  codeName="PROVINCE" formTitle="ʡ��" defaultValue="">
					 	                <BZ:option value="">--��ѡ��ʡ��--</BZ:option>
					                </BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 8%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td style="width: 10%">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="150" style="width: 85%"/>
								</td>
								
								<td class="bz-search-title" style="width: 8%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td style="width: 8%">
								    <BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="�Ա�" defaultValue="" width="95%">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 8%">��������</td>
								<td style="width: 34%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
							    <td class="bz-search-title" >����Ժ</td>
								<td style="width: 16%">
								    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="����Ժ" defaultValue="">
						              <BZ:option value="">--��ѡ����Ժ--</BZ:option>
					                </BZ:select>
								</td>
								
								<td class="bz-search-title">��������</td>
								<td>
								    <BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" formTitle="��������" defaultValue="" width="95%">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
							    <td class="bz-search-title" >�ر��ע</td>
								<td >
								    <BZ:select prefix="S_" field="SPECIAL_FOCUS" id="S_SPECIAL_FOCUS" formTitle="" defaultValue="" width="95%">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��</BZ:option>
										<BZ:option value="1">��</BZ:option>
									</BZ:select>
								</td>	
								
								<td class="bz-search-title">�������</td>
								<td>
									<BZ:input prefix="S_" field="CHECKUP_DATE_START" id="S_CHECKUP_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ�������" />~
									<BZ:input prefix="S_" field="CHECKUP_DATE_END" id="S_CHECKUP_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ�������" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">���´���</td>
								<td>
									<BZ:input prefix="S_" field="UPDATE_NUM" id="S_UPDATE_NUM" defaultValue="" className="inputOne" formTitle="���´���" />
								</td>
								
								<td class="bz-search-title">����״̬</td>
								<td >
								    <BZ:select prefix="S_" field="PUB_STATE" id="S_PUB_STATE" isCode="true" codeName="FBZT" formTitle="����״̬" defaultValue="" width="95%" >
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">�Ǽ�״̬</td>
								<td >
								    <BZ:select prefix="S_" field="ADREG_STATE" id="S_ADREG_STATE"  formTitle="�Ǽ�״̬" defaultValue="" width="95%">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">δ�Ǽ�</BZ:option>
										<BZ:option value="1">�ѵǼ�</BZ:option>
										<BZ:option value="2">��Ч�Ǽ�</BZ:option>
									</BZ:select>
								</td>
								
							    <td class="bz-search-title">����״̬</td>
								<td >
								    <BZ:select prefix="S_" field="RI_STATE" id="S_RI_STATE" isCode="true" codeName="YPZT" formTitle="����״̬" defaultValue="" width="40%">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
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
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_toUpdate();"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive" style="overflow-x:auto;">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table" >
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">�Ա�</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">��������</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="CHECKUP_DATE">�������</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="SN_TYPE">��������</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SPECIAL_FOCUS">�ر��ע</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="UPDATE_NUM">���´���</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="LAST_UPDATE_DATE">ĩ�θ�������</div>
								</th>
								<th  style="width: 7%;">
									<div class="sorting" id="PUB_STATE">����״̬</div>
								</th>
								<th  style="width: 7%;">
									<div class="sorting" id="RI_STATE">����״̬</div>
								</th>
								<th  style="width: 7%;">
									<div class="sorting" id="ADREG_STATE">�Ǽ�״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input type="radio" name="xuanze" value='<BZ:data field="CI_ID" onlyValue="true"/>#<BZ:data field="CHILD_TYPE" onlyValue="true"/>#<BZ:data field="UPDATE_STATE" onlyValue="true"/>' />
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><a onclick="showChildInfo(this);" name='<BZ:data field="CI_ID" onlyValue="true"/>'><BZ:data field="NAME" defaultValue="" onlyValue="true"/></a></td>
								<td class="center"><BZ:data field="SEX" defaultValue="" codeName="ETXB" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="CHECKUP_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SPECIAL_FOCUS" defaultValue="" checkValue="0=��;1=��;" onlyValue="true"/></td>
								<td class="center"><BZ:data field="UPDATE_NUM" defaultValue=""  onlyValue="true"/></td>
								<td class="center"><BZ:data field="LAST_UPDATE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="PUB_STATE" defaultValue="" codeName="FBZT" onlyValue="true"/></td>
							    <td class="center"><BZ:data field="RI_STATE" defaultValue="" codeName="YPZT" onlyValue="true"/></td>
							    <td class="center"><BZ:data field="ADREG_STATE" defaultValue="" checkValue="0=δ�Ǽ�;1=�ѵǼ�;2=��Ч�Ǽ�" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List"  exportXls="true" exportTitle="���ڲ�ѯ" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;CHECKUP_DATE=DATE;SN_TYPE=CODE,BCZL;SPECIAL_FOCUS=FLAG,0:��&1:��;LAST_UPDATE_DATE=DATE;PUB_STATE=CODE,FBZT;RI_STATE=CODE,YPZT;ADREG_STATE=FLAG,0:δ�Ǽ�&1:�ѵǼ�&2:��Ч�Ǽ�;" exportField="PROVINCE_ID=ʡ��,15,20;WELFARE_NAME_CN=����Ժ,18;NAME=����,15;SEX=�Ա�,15;BIRTHDAY=��������,15;CHECKUP_DATE=�������,15;SN_TYPE=��������,20;SPECIAL_FOCUS=�ر��ע,10;UPDATE_NUM=���´���,10;LAST_UPDATE_DATE=ĩ�θ�������,15;PUB_STATE=����״̬,15;RI_STATE=����״̬,15;ADREG_STATE=�Ǽ�״̬,15;"/></td>
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