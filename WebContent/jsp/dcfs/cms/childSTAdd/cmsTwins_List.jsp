<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
  /**   
 * @Description: ͬ������
 * @author wangzheng   
 * @date 2014-9-11
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
  String CI_ID = (String)request.getAttribute("CI_ID");
  String CHILD_NO = (String)request.getAttribute("CHILD_NO");
  String WELFARE_ID = (String)request.getAttribute("WELFARE_ID");

%>
<BZ:html>
	<BZ:head>
		<title>ͬ������</title>
        <BZ:webScript edit="true" list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	</BZ:head>
	
<script type="text/javascript">
	//ͬ��CI_ID
	var twins_ci_id="<%=CI_ID%>";
	//ͬ��CHILD_NO
	var twins_child_no="<%=CHILD_NO%>";

  	//iFrame�߶��Զ�����
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
			area: ['600px','180px'],
			offset: ['40px' , '0px'],
			closeBtn: [0, true]
		});
	}
	
	//����
	function _search(){
		document.srcForm.action=path+"/cms/childstadd/twinslist.action";
		document.srcForm.submit();
	}

	//������������
	function _reset(){
		document.getElementById("S_NAME").value = "";
		document.getElementById("S_SEX").value = "";
		document.getElementById("S_BIRTHDAY_START").value = "";
		document.getElementById("S_BIRTHDAY_END").value = "";
	}

	//����ͬ����¼
	function _add(){
		var sfdj=0;
		var uuid=twins_ci_id;
		var cno=twins_child_no;

		for(var i=0;i<document.getElementsByName('abc').length;i++){
		   if(document.getElementsByName('abc')[i].checked){
			uuid=uuid+"#"+document.getElementsByName('abc')[i].value;
			if(document.getElementsByName('abc')[i].value=="<%=CI_ID%>")
			{
				alert("ͬ�����ò���ѡ���Լ���");
				return;
			}
			cno=cno+"#"+document.getElementsByName('abc')[i].getAttribute("CHILD_NO");
			sfdj++;
		   }
		}
		
		if(sfdj=="0"){
			alert('δѡ����ͯ��¼��');
			return;
		}

		if(confirm('ȷ�Ͻ�ѡ�еĶ�ͯ��Ϊͬ����¼��?')){
			 document.getElementById("cid").value=uuid;
			 document.getElementById("cno").value=cno;
			 document.srcForm.action=path+"/cms/childstadd/twinsadd.action";
			 document.srcForm.submit();
			 document.srcForm.action=path+"/cms/childstadd/twinslist.action";
		}else{
			return;
		}
	}

	function _delete(cid,cno){
		document.getElementById("cid").value=cid;
		document.getElementById("cno").value=cno;
		document.srcForm.action=path+"/cms/childstadd/twinsdelete.action";
		document.srcForm.submit();
		document.srcForm.action=path+"/cms/childstadd/twinslist.action";
	}


</script>
<BZ:body property="data" codeNames="ETXB">
	<!--��ʾͬ����Ϣ:start-->
	<BZ:form name="twinsForm" method="post">
	<table class="specialtable" align="center" style='width:100%;text-align:center'>
		<tr>
			<td class="edit-data-title" colspan="8"><b>ͬ����Ϣ<b></td>
		</tr>
		<BZ:for property="twinsList">
		<tr>
			<td align="center" class="edit-data-value">
				<BZ:i/>
				<input name="aaa" type="hidden" value="<BZ:data field="CI_ID" onlyValue="true"/>" CHILD_NO="<BZ:data field="CHILD_NO" onlyValue="true"/>">
			</td>
			<td class="edit-data-title">����</td>
			<td class="edit-data-value"> <BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
			<td class="edit-data-title">�Ա�</td>
			<td align="center" class="edit-data-value"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/></td>
			<td class="edit-data-title">��������</td>
			<td align="center" class="edit-data-value"><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
			<td align="center" class="edit-data-value"><a href="javascript:_delete('<BZ:data field="CI_ID" onlyValue="true"/>','<BZ:data field="CHILD_NO" onlyValue="true"/>')">ɾ��</a></td>
		</tr>
		</BZ:for>
	</table>
	</BZ:form>
	<br>
	<!--��ʾͬ����Ϣ:end-->
    <BZ:form name="srcForm" method="post" action="/cms/childstadd/twinslist.action">
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0" adsorb="both" init="true">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%"><span title="����">����</span></td>
								<td style="width:10%">
								<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue=""/>
								</td>
								<td class="bz-search-title" style="width: 15%"><span title="�Ա�">�Ա�</span></td>
								<td style="width: 15%">
									<BZ:select prefix="S_"  field="SEX" isCode="true" codeName="ETXB" formTitle="�Ա�">
										<option value="">--��ѡ��--</option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title"><span title="��������">��������</span></td>
								<td colspan="3">
									<BZ:input prefix="S_" field="BIRTHDAY_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_BIRTHDAY_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="BIRTHDAY_END" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_BIRTHDAY_END" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true"/>
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
    <input type="hidden" name="dispatchuuid" id="dispatchuuid" value="" />	     
	<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
	<input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	<input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	<input type="hidden" name="cid" id="cid" value=""/>
	<input type="hidden" name="cno" id="cno" value=""/>
	<input type="hidden" name="CI_ID" id="CI_ID" value="<%=CI_ID%>"/>
	<input type="hidden" name="CHILD_NO" id="CHILD_NO" value="<%=CHILD_NO%>"/>
	<input type="hidden" name="WELFARE_ID" id="WELFARE_ID" value="<%=WELFARE_ID%>"/>
	
	<div class="page-content">
		<div class="wrapper">
		<!-- ���ܰ�ť������Start -->
		<div class="table-row table-btns" style="text-align: left">
			<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;		
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_add()"/>&nbsp;
		</div>
		<div class="blue-hr"></div>
		<!-- ���ܰ�ť������End -->		
		<!--��ѯ����б���Start -->
		<div class="table-responsive">
		<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
			<thead>
				<tr class="emptyData">
					<th class="center" style="width:2%;">
						&nbsp;
					</th>
					<th style="width:4%;">
						<div class="sorting_disabled">���</div>
					</th>
					<th style="width:20%;">
						<div class="sorting" id="NAME">����</div>
					</th>
					<th style="width:5%;">
						<div class="sorting" id="SEX">�Ա�</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="BIRTHDAY">��������</div>
					</th>					
				</tr>
				</thead>
				<tbody>
					<BZ:for property="dataList">
						<tr>
							<td class="center">
								<input name="abc" type="checkbox" value="<BZ:data field="CI_ID" onlyValue="true"/>" CHILD_NO="<BZ:data field="CHILD_NO" onlyValue="true"/>" >
							</td>
							<td class="center">
								<BZ:i/>
							</td>
							<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
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
					<td><BZ:page form="srcForm" property="dataList"/></td>
				</tr>
			</table>
		</div>
		<!--��ҳ������End -->
	</div>
</div>

</BZ:form>
</BZ:body>
</BZ:html>
<script type="text/javascript">
<!--
	for(var i=0;i<document.getElementsByName('aaa').length;i++){
		twins_ci_id=twins_ci_id+"#"+document.getElementsByName('aaa')[i].value;
		twins_child_no=twins_child_no+"#"+document.getElementsByName('aaa')[i].getAttribute("CHILD_NO");				
	}
//-->
</script>