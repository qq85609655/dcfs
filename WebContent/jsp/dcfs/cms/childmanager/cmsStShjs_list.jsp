<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@page import="com.dcfs.cms.childManager.ChildStateManager"%>
<%
  /**   
 * @Description: ʡ��������˼����б�
 * @author wangzheng   
 * @date 2014-9-15
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
  String listType=(String)request.getAttribute("listType");
  Data da = (Data)request.getAttribute("data");
  String WELFARE_ID=da.getString("WELFARE_ID","");
  String provinceId=da.getString("PROVINCE_ID","");
String path = request.getContextPath();

%>

<BZ:html>
	<BZ:head>
		<title>������˼����б�ʡ����</title>
        <BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	</BZ:head>
	
<script type="text/javascript">
  	//iFrame�߶��Զ�����
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
		selectWelfare(<%=provinceId %>);
	});
 
	//��ʾ��ѯ����
	function _showSearch(){
		$.layer({
			type : 1,
			title : "��ѯ����",
			shade : [0.5 , '#D9D9D9' , true],
			border :[2 , 0.3 , '#000', true],
			page : {dom : '#searchDiv'},
			area: ['950px','260px'],
			offset: ['40px' , '0px'],
			closeBtn: [0, true]
		});
	}
	
	//����
	function _search(){
		document.srcForm.action=path+"/cms/childManager/STAuditList.action";
		if(document.getElementById("S_IS_HOPE").checked)
			document.getElementById("S_IS_HOPE").value = "1";
		if(document.getElementById("S_IS_PLAN").checked)
			document.getElementById("S_IS_PLAN").value = "1";
		document.srcForm.submit();
	}

	//������������
	function _reset(){
		document.getElementById("S_WELFARE_ID").value = "";
		document.getElementById("S_NAME").value = "";
		document.getElementById("S_SEX").value = "";
		document.getElementById("S_CHILD_TYPE").value = "";
		document.getElementById("S_SN_TYPE").value = "";
		document.getElementById("S_CHILD_STATE").value = "";
		document.getElementById("S_BIRTHDAY_START").value = "";
		document.getElementById("S_BIRTHDAY_END").value = "";
		document.getElementById("S_CHECKUP_DATE_START").value = "";
		document.getElementById("S_CHECKUP_DATE_END").value = "";
		document.getElementById("S_IS_HOPE").checked = false;
		document.getElementById("S_IS_HOPE").value = "";
		document.getElementById("S_IS_PLAN").checked = false;
		document.getElementById("S_IS_PLAN").value = "";
		document.getElementById("S_SEND_DATE_START").value = "";
		document.getElementById("S_SEND_DATE_END").value = "";
		document.getElementById("S_AUDIT_DATE_START").value = "";
		document.getElementById("S_AUDIT_DATE_END").value = "";
		document.getElementById("S_POST_DATE_START").value = "";
		document.getElementById("S_POST_DATE_END").value = "";
		document.getElementById("S_RECEIVE_DATE_START").value = "";
		document.getElementById("S_RECEIVE_DATE_END").value = "";
	}
  
	//�鿴��Ϣ
	function _view(){
		var arrays = document.getElementsByName("abc");
		var num = 0;
		var showuuid="";
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				showuuid=document.getElementsByName('abc')[i].value;
				num += 1;
			}
		}
		if(num != "1"){
			page.alert('��ѡ��һ��Ҫ�鿴������');
			return;
		}else{	 
			url = path+"/cms/childManager/show.action?type=show&UUID="+showuuid;
			_open(url, "��ͯ������Ϣ", 1000, 600);
		}
	}

    //����
	function _export(){
		if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
			_exportFile(document.srcForm,'xls');
		}else{
			return;
		}
	}

//���
  function _audit(){
	var arrays = document.getElementsByName("abc");
	var num = 0;
	var uuid="";
	var isaudit = "true";
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			uuid=document.getElementsByName('abc')[i].getAttribute("CA_ID");
			if("<%=ChildStateManager.CHILD_AUD_STATE_SDS%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE") && "<%=ChildStateManager.CHILD_AUD_STATE_SSHZ%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE")){
				isaudit = "false";
			}
			num += 1;
		}
	}
	if(num != "1"){
		page.alert('��ѡ��һ�����״̬Ϊ����˻�����еļ�¼');
		return;
	}else{
	 if(isaudit == "false"){
		page.alert('��ѡ��һ�����״̬Ϊ����˻�����еļ�¼');
		return;
	 }
	 document.srcForm.action=path+"/cms/childManager/childInfoAudit.action?level=<%=ChildInfoConstants.LEVEL_PROVINCE%>&UUID="+uuid;
	 document.srcForm.submit();
	 document.srcForm.action=path+"/cms/childManager/STAuditList.action";
	 }
  }
	
	//�޸�
  function _revise(){
	var arrays = document.getElementsByName("abc");
	var num = 0;
	var showuuid="";
	var ismod = "true";
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			showuuid=document.getElementsByName('abc')[i].value;
			
			if("<%=ChildStateManager.CHILD_AUD_STATE_SDS%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE") && "<%=ChildStateManager.CHILD_AUD_STATE_SSHZ%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE") ){
				ismod = "false";
			}
			num += 1;
		}
	}
	if(num != "1"){
		page.alert('��ѡ��һ��Ҫ�޸ĵļ�¼��');
		return;
	}else{
	 if(ismod == "false"){
		page.alert('�Ѽ��͵ļ�¼�޷��޸ģ�');
		return;
	 }
	 
	// document.srcForm.action=path+"/cms/childManager/show.action?type=mod&UUID="+showuuid;
	 document.srcForm.action=path+"/cms/childManager/toBasicInfoMod.action?UUID="+showuuid+"&listType=CMS_ST_SHJS_LIST";
	 document.srcForm.submit();
	 document.srcForm.action=path+"/cms/childManager/STAuditList.action";
	 }
  }

  //����
  function _post(){
	var sfdj=0;
	var uuid="";
	var ispost = "true"
	   for(var i=0;i<document.getElementsByName('abc').length;i++){
	   if(document.getElementsByName('abc')[i].checked){
		   if("<%=ChildStateManager.CHILD_AUD_STATE_STG%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE")){
				ispost = "false";
			}
	   uuid=uuid+"#"+document.getElementsByName('abc')[i].value;
	   sfdj++;
	   }
	}
	  if(sfdj=="0"){
	   alert('��ѡ��Ҫ���͵Ĳ��ϣ�');
	   return;
	  }else{
		  if(ispost == "false"){
			page.alert('��ѡ�����ͨ���Ĳ��ϼ��ͣ�');
			return;
		 }
	  if(confirm('ȷ��Ҫ����ѡ�в�����?')){
		  
		 document.getElementById("uuid").value=uuid;
		 document.srcForm.action=path+"/cms/childManager/stBatchPost.action";
		 document.srcForm.submit();
		 document.srcForm.action=path+"/cms/childManager/STAuditList.action";
	  }else{
	  return;
	  }
	}
  }

  //��ӡ
  function _print(){
   var sfdj=0;
	var uuid="";
	var isprint = "true"
	   for(var i=0;i<document.getElementsByName('abc').length;i++){
	   if(document.getElementsByName('abc')[i].checked){
		uuid=uuid+"#"+document.getElementsByName('abc')[i].value;	   
		sfdj++;
	   }
	}
	  if(sfdj=="0"){
	   alert('��ѡ��Ҫ��ӡ�Ĳ���');
	   return;
	  }else{
		  //_open("<BZ:url/>/cms/childManager/postPrint.action", "���ϼ��ʹ�ӡ", 1000, 600); 
		  
		  openPostWindow("<BZ:url/>/cms/childManager/postPrint.action",uuid,"���ϼ��ʹ�ӡ");		  
		  //document.getElementById("printid").value=uuid;
		  //_open("<BZ:url/>/cms/childManager/postPrint.action", "���ϼ��ʹ�ӡ", 1000, 600); 
		  
		  //document.frmprint.fireEvent("onsubmit");
		  //document.frmprint.submit();
		  /*
			$.layer({
			type : 2,
			title : "���͵���ӡ",
			shade : [0.5 , '#D9D9D9' , true],
			border :[2 , 0.3 , '#000', true],
			//page : {dom : '#planList'},
			iframe: {src: '<BZ:url/>/cms/childManager/postPrint.action'},
			area: ['800px','400px'],
			offset: ['0px' , '0px']
		});*/

		 //
		 //document.srcForm.action=path+"/cms/childManager/postPrint.action";
		 //document.srcForm.submit();	  
	}
  }

  function openPostWindow(url,data,name){
	var tempForm = document.createElement("form");    
	tempForm.id="tempForm1";    
	tempForm.method="post";    
	tempForm.action=url;    
	tempForm.target=name;

	var hideInput = document.createElement("input");    
	hideInput.type="hidden";    
	hideInput.name= "printid"  
    hideInput.value= data;
	tempForm.appendChild(hideInput);
	addEvent(tempForm,"onsubmit",function(){ 
		_open("<BZ:url/>/cms/childManager/postPrint.action", "���ϼ��ʹ�ӡ", 1000, 600); 
	}); 
	document.body.appendChild(tempForm); 
	//tempForm.fireEvent("onsubmit");  
	tempForm.submit();  
	document.body.removeChild(tempForm);  
}  

function addEvent(element,type,handler){
	if(element.attachEvent){
		element.attachEvent("on"+type,handler);
	}else if(element.addEventListener){
		element.addEventListener(type,handler,false);
	
	}
}
//����ʡ��province_id��ʼ������Ժ������ѡ���б���Ҫ��ʾ������
function selectWelfare(provinceId){
	//���ڻ��Եĸ�������code
	var selectedId = '<%=WELFARE_ID%>';
	if(provinceId!=null&&provinceId!=""){
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
		}
	}
}

</script>
	<BZ:body property="data" codeNames="ETSFLX;BCZL;ETXB;CHILD_TYPE;CHILD_STATE">
    <BZ:form name="srcForm" method="post" action="/cms/childManager/STAuditList.action">
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%"><span title="����Ժ">����Ժ</span></td>
								<td colspan="3">
								    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="����Ժ" defaultValue="" width="80%">
					                   <BZ:option value="">--��ѡ����Ժ--</BZ:option>
				                    </BZ:select>
								</td>								
								<td class="bz-search-title"  style="width: 10%"><span title="��������">��������</span></td>
								<td style="width: 40%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_BIRTHDAY_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="BIRTHDAY_END" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_BIRTHDAY_END" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title" style="width: 10%"><span title="����">����</span></td>
								<td style="width:15%">
								<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue=""/>
								</td>
								<td class="bz-search-title" style="width: 10%"><span title="�Ա�">�Ա�</span></td>
								<td style="width: 15%">
									<BZ:select prefix="S_"  field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="�Ա�">
										<option value="">--��ѡ��--</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title"><span title="�������">�������</span></td>
								<td colspan="5">
									<BZ:input prefix="S_" field="CHECKUP_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_CHECKUP_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="CHECKUP_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_CHECKUP_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_START\\')}',readonly:true"/>
								</td>	
							</tr>
							<tr>
								<td class="bz-search-title"><span title="��ͯ����">��ͯ����</span></td>
								<td>
									<BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="��ͯ����" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title"><span title="��������">��������</span></td>
								<td>
									<BZ:select prefix="S_" field="SN_TYPE"  id="S_SN_TYPE" isCode="true" codeName="BCZL"  defaultValue="" formTitle="��������">
										<option value="">--��ѡ��--</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title"><span title="��������">��������</span></td>
								<td>
									<BZ:input prefix="S_" field="SEND_DATE_START" id="S_SEND_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" dateExtend="maxDate:'#F{$dp.$D(\\'S_SEND_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="SEND_DATE_END" id="S_SEND_DATE_END"  type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  dateExtend="minDate:'#F{$dp.$D(\\'S_SEND_DATE_START\\')}',readonly:true"/>
								</td>																				
							</tr>
							<tr>
								<td class="bz-search-title"><span title="����">����</span></td>
								<td class="bz-search-value">
									<input type="checkbox" name="S_IS_PLAN" id="S_IS_PLAN" value="" <BZ:dataValue field="IS_PLAN" defaultValue="0" onlyValue="true" checkValue="0= ;1=checked"/>>����ƻ�&nbsp;&nbsp;
									<input type="checkbox" name="S_IS_HOPE" id="S_IS_HOPE" value="" <BZ:dataValue field="IS_HOPE" defaultValue="0" onlyValue="true" checkValue="0= ;1=checked"/>>ϣ��֮��
								</td>
								<td class="bz-search-title"><span title="���״̬">���״̬</span></td>
								<td>
									<BZ:select prefix="S_" field="CHILD_STATE" id="S_CHILD_STATE" isCode="false" defaultValue="" formTitle="���״̬">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">ʡ����</BZ:option>
										<BZ:option value="2">ʡ�����</BZ:option>
										<BZ:option value="3">ʡ��ͨ��</BZ:option>
										<BZ:option value="4">ʡͨ��</BZ:option>
										<BZ:option value="5">�Ѽ���</BZ:option>
										<BZ:option value="6">�ѽ���</BZ:option>
									</BZ:select>
								</td>	
								<td class="bz-search-title"><span title="�������">�������</span></td>
								<td>
									<BZ:input prefix="S_" field="AUDIT_DATE_START" id="S_AUDIT_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" dateExtend="maxDate:'#F{$dp.$D(\\'S_AUDIT_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="AUDIT_DATE_END" id="S_AUDIT_DATE_END"  type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  dateExtend="minDate:'#F{$dp.$D(\\'S_AUDIT_DATE_START\\')}',readonly:true"/>
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title"><span title="��������">��������</span></td>
								<td colspan="3">
									<BZ:input prefix="S_" field="POST_DATE_START" id="S_POST_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" dateExtend="maxDate:'#F{$dp.$D(\\'S_POST_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="POST_DATE_END" id="S_POST_DATE_END"  type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  dateExtend="minDate:'#F{$dp.$D(\\'S_POST_DATE_START\\')}',readonly:true"/>
								</td>		
								<td class="bz-search-title"><span title="��������">��������</span></td>
								<td>
									<BZ:input prefix="S_" field="RECEIVE_DATE_START" id="S_RECEIVE_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVE_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="RECEIVE_DATE_END" id="S_RECEIVE_DATE_END"  type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVE_DATE_START\\')}',readonly:true"/>
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
    <input type="hidden" name="uuid" id="uuid" value="" />	     
	<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
	<input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	<input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	<div class="page-content">
	<BZ:frameDiv property="clueTo" className="kuangjia">	 
    <div class="wrapper">
		
		<!-- ���ܰ�ť������Start -->
		<div class="table-row table-btns" style="text-align: left">
			<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;		
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_audit()"/>&nbsp;
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_post()"/>&nbsp;
			<input type="button" value="���͵���ӡ" class="btn btn-sm btn-primary" onclick="_print()"/>&nbsp;
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_revise()"/>&nbsp
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;
		</div>
		<div class="blue-hr"></div>
		<!-- ���ܰ�ť������End -->		
		<!--��ѯ����б���Start -->
		<div class="table-responsive">
		<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
			<thead>
				<tr class="emptyData">
					<th class="center" style="width:2%;">
						<div class="sorting_disabled"><input name="abcd" type="checkbox" class="ace"></div>
					</th>
					<th style="width:3%;">
						<div class="sorting_disabled">���</div>
					</th>
					<th style="width:13%;">
						<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
					</th>
					<th style="width:5%;">
						<div class="sorting" id="NAME">����</div>
					</th>
					<th style="width:4%;">
						<div class="sorting" id="SEX">�Ա�</div>
					</th>
					<th style="width:6%;">
						<div class="sorting" id="BIRTHDAY">��������</div>
					</th>
					<th style="width:5%;">
						<div class="sorting" id="CHILD_TYPE">��ͯ����</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="SN_TYPE">��������</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="CHECKUP_DATE">�������</div>
					</th>
					<th style="width:8%;">
						<div  class="sorting_disabled" id="TCHD">����</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="SEND_DATE">��������������</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="AUDIT_DATE">�������</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="POST_DATE">��ʡ����������</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="RECEIVE_DATE">���У���������</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="AUD_STATE">���״̬</div>
					</th>
				</tr>
				</thead>
				<tbody>	
					<BZ:for property="List">
						<tr>
							<td class="center">
								<input name="abc" type="checkbox" value="<BZ:data field="CI_ID" onlyValue="true"/>" class="ace" AUD_STATE="<BZ:data field="AUD_STATE" onlyValue="true"/>" RETURN_STATE="<BZ:data field="RETURN_STATE" onlyValue="true"/>" CA_ID="<BZ:data field="CA_ID" onlyValue="true"/>">
							</td>
							<td class="center">
								<BZ:i/>
							</td>
							<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="CHILD_TYPE" codeName="CHILD_TYPE" onlyValue="true"/></td>
							<td><BZ:data field="SN_TYPE"  codeName="BCZL" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="CHECKUP_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td>
							<BZ:data field="IS_HOPE" onlyValue="true" defaultValue="" checkValue="0= ;1=ϣ��֮��"/>
							<BZ:data field="IS_PLAN" onlyValue="true" defaultValue="" checkValue="0= ;1=����ƻ�"/>
							</td>
							<td align="center"><BZ:data field="SEND_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="AUDIT_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="POST_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="RECEIVE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="AUD_STATE"  codeName="CHILD_STATE" defaultValue="" onlyValue="true"/></td>
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
					<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="��ͯ������˼�������" exportCode="SEX=CODE,ETXB;BIRTHDAY=DATE;CHILD_TYPE=CODE,CHILD_TYPE;SN_TYPE=CODE,BCZL;CHECKUP_DATE=DATE;IS_HOPE=FLAG,0:��&1:��;IS_PLAN=FLAG,0:��&1:��;SEND_DATE=DATE;AUDIT_DATE=DATE;POST_DATE=DATE;RECEIVE_DATE=DATE;AUD_STATE=CODE,CHILD_STATE;" exportField="WELFARE_NAME_CN=����Ժ,30,20;NAME=����,15;SEX=�Ա�,10;BIRTHDAY=��������,15;CHILD_TYPE=��ͯ����,10;SN_TYPE=��������,25;CHECKUP_DATE=�������,15;IS_PLAN=����ƻ�,10;IS_HOPE=ϣ��֮��,10;SEND_DATE=��������������,20;AUDIT_DATE=�������,15;POST_DATE=��ʡ����������,20;RECEIVE_DATE=���У���������,20;AUD_STATE=���״̬,15;"/></td>				
				</tr>
			</table>
		</div>
		<!--��ҳ������End -->
	</div>
</div>
<form name="frmprint" method="post" action="<%=path%>/cms/childManager/postPrint.action" target="<%=path%>/cms/childManager/postPrint.action">
	<input type="hidden" id="printid" name="printid">
</form>
<br><br><br><br><br>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>
