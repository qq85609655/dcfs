<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
  /**   
 * @Description: ����
 * @author wangzheng 
 * @date 2014-10-27 9:38:04
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
	<BZ:head>
		<title>��ѯ�б�</title>
        <BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
  <script type="text/javascript">
  
  //iFrame�߶��Զ�����
  //$(document).ready(function() {
  //			dyniframesize(['mainFrame']);
  //		});
 
 //��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['900px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
 
  function search(){
     document.srcForm.action=path+"attsmalltype/findList.action";
	 document.srcForm.submit();
  }
  
  function add(){
     document.srcForm.action=path+"attsmalltype/add.action";
	 document.srcForm.submit();
  }

  function _update(){
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
	 document.srcForm.action=path+"attsmalltype/show.action?type=mod&UUID="+showuuid;
	 document.srcForm.submit();
	 }
  }
  
  function chakan(){
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
		 document.srcForm.action=path+"attsmalltype/show.action?type=show&UUID="+showuuid;
		 document.srcForm.submit();
    }
  }

  function _delete(){
   var sfdj=0;
	var uuid="";
	   for(var i=0;i<document.getElementsByName('abc').length;i++){
	   if(document.getElementsByName('abc')[i].checked){
	   uuid=uuid+"#"+document.getElementsByName('abc')[i].value;
	   sfdj++;
	   }
	}
	  if(sfdj=="0"){
	   alert('��ѡ��Ҫɾ��������');
	   return;
	  }else{
	  if(confirm('ȷ��Ҫɾ��ѡ����Ϣ��?')){
		 document.getElementById("deleteuuid").value=uuid;
		 document.srcForm.action=path+"attsmalltype/delete.action";
		 document.srcForm.submit();
	  }else{
	  return;
	  }
	}
  }
  //����
  function _reset(){
	document.getElementById("S_BIG_TYPE").value = "";
	document.getElementById("S_CNAME").value = "";
    page.alert("���÷���δ����");
  }
  

  </script>
<BZ:body property="data"  >
     <BZ:form name="srcForm" method="post" action="attsmalltype/findList.action">
     <input type="hidden" name="deleteuuid" id="deleteuuid" value="" />
     <!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
	 <input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	 <input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	 <BZ:frameDiv property="clueTo" className="kuangjia">
	<!-- ��ѯ������Start -->
	<div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
			<tr>
				<td style="width: 100%;">
					<table>
						  <tr>
						  	<td class="bz-search-title" style="width: 20%">ҵ�����</td>
							<td style="width: 30%">
								<BZ:select prefix="S_" field="BIG_TYPE" formTitle="ҵ�����">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="AF">��ͥ�ļ�</BZ:option>
									<BZ:option value="CI">��ͯ����</BZ:option>
									<BZ:option value="AR">��������</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-search-title" style="width: 20%"><span title="��������">��������</span></td>
							<td style="width:30%">
							<BZ:input prefix="S_" field="CNAME" id="S_CNAME" defaultValue=""/>
							</td>
						  </tr>
						  <tr>
						  </tr>
						  <tr>
						  </tr>
						  <tr>
						  </tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="��&nbsp;&nbsp;��" onclick="search();" class="btn btn-sm btn-primary">
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
				<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="add()"/>&nbsp;
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="chakan()"/>&nbsp;
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_update()"/>&nbsp;
				<!--  input type="button" value="ɾ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_delete()"/>	-->
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
						<th style="width:10%;">
							<div class="sorting" id="BIG_TYPE">ҵ�����</div>
						</th>
						<th style="width:5%;">
							<div class="sorting" id="CODE">����</div>
						</th>
						<th style="width:15%;">
							<div class="sorting" id="CNAME">��������</div>
						</th>
						<th style="width:15%;">
							<div class="sorting" id="ENAME">Ӣ������</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="ATT_MORE">�Ƿ�฽��</div>
						</th>
						<th style="width:6%;">
							<div class="sorting" id="ATT_SIZE">������С</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="ATT_FORMAT">������ʽ</div>
						</th>
						<!--th style="width:10%;">
							<div class="sorting" id="IS_NAILS">�Ƿ�ת������ͼ</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="REMARKS">����˵��</div>
						</th-->
						<th style="width:6%;">
							<div class="sorting" id="SEQ_NO">��ʾ˳��</div>
						</th>
						<th style="width:6%;">
							<div class="sorting" id="IS_VALID">��Ч��ʶ</div>
						</th>
						
					</tr>
					</thead>
					<tbody>	
						<BZ:for property="List">
							<tr class="odd">
								<td class="center">
									<input name="abc" type="checkbox" value="<BZ:data field="ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="BIG_TYPE"  defaultValue="" onlyValue="true" checkValue="CI=��ͯ����;AF=��ͥ�ļ�;AR=��������;OTHER=����"/></td>
								<td><BZ:data field="CODE"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="CNAME"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ENAME"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ATT_MORE"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ATT_SIZE"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="ATT_FORMAT"  defaultValue="" onlyValue="true"/></td>
								<!--td><BZ:data field="IS_NAILS"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REMARKS"  defaultValue="" onlyValue="true"/></td-->
								<td><BZ:data field="SEQ_NO"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="IS_VALID"  defaultValue="" onlyValue="true" checkValue="0=��Ч;1=��Ч"/></td>
								
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
						<td><BZ:page form="srcForm" property="List"/></td>
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