<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
  /**   
 * @Description: ��ͯ�����ֹ��ƽ��б�
 * @author wty 
 * @date 2014-7-30 21:14:53
 * @version V1.0   
 * @ modify by wangzheng
 * @ date 2014-10-22
 * @version V1.1
 */
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
  String TRANSFER_CODE=(String)request.getAttribute("TRANSFER_CODE");  
  //String TI_ID = (String)request.getAttribute("TI_ID");
  String mannualDeluuid = (String)request.getAttribute("mannualDeluuid");
  if("null".equals(mannualDeluuid) || mannualDeluuid == null){
      mannualDeluuid = "";
  }

%>
<BZ:html>
<BZ:head>
	<title>��ѯ�б�</title>
	<BZ:webScript list="true" isAjax="true" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/child.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>	
</BZ:head>
<script type="text/javascript">
	$(document).ready(function() {
		initProvOrg("<%=WELFARE_ID%>");
	});
	
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

  /**
  *��ѯ
  */
  function search(){
     document.srcForm.action=path+"transferManager/MannualChildinfo.action";
	 document.srcForm.submit();
  }

  /**
  *ѡ���ƽ��ļ�
  */
  function _choice(){  	
	var num = 0;
	var chioceuuid = [];
	var arrays = document.getElementsByName("abc");
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			chioceuuid[num] = arrays[i].value;
			num += 1;
		}
	}
	if(num < 1){
		page.alert('��ѡ��Ҫ����ƽ��Ķ�ͯ���ϣ�');
		return;
	}else{
		if (confirm("ȷ���ƽ���Щ��ͯ���ϣ�")){
			var uuid = chioceuuid.join("#");
			opener.refreshLocalList(uuid);
			window.close();
			
			
			/*var TI_ID = document.getElementById("TI_ID").value;
			
			var rv = getStr("com.dcfs.ffs.transferManager.TransferManagerAjax", "uuid="+uuid+"&TI_ID="+TI_ID);
			
			if(rv == "1"){
				opener.refreshLocalList();
				window.close();
			}else{
				alert("�������ʧ�ܣ�");
			}*/
		}
	}
  }

  //��ѯ��������
  function _reset(){
	  $("#S_CHILD_NO").val("");
	  $("#S_PROVINCE_ID").val("");
	  $("#S_WELFARE_ID").val("");
	  $("#S_NAME").val("");
	  $("#S_SEX").val("");
	  $("#S_BIRTHDAY_START").val("");
	  $("#S_BIRTHDAY_END").val("");
	  $("#S_CHILD_TYPE").val("");
	  $("#S_SPECIAL_FOCUS").val("");
	}
  
</script>

<BZ:body property="data" codeNames="ETXB;PROVINCE;CHILD_TYPE">
	<BZ:form name="srcForm" method="post" action="/transferManager/MannualChildinfo.action">
	 <input type="hidden" name="mannualDeluuid" id="mannualDeluuid" value="<%=mannualDeluuid %>"/>
		<input type="hidden" name="chioceuuid" id="chioceuuid" value="" />
		<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
	 <input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	 <input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	 <input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=TRANSFER_CODE%>"/>
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
			<tr>
				<td style="width: 100%;">
				<table>
					<tr>
						<td class="bz-search-title" style="width: 8%">ʡ��</td>
						<td style="width: 15%">
							<BZ:select prefix="S_" id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="95%"  isCode="true"  codeName="PROVINCE" formTitle="ʡ��" defaultValue="">
			 	                <BZ:option value="">--��ѡ��ʡ��--</BZ:option>
			                </BZ:select>
						</td>
						<td class="bz-search-title" style="width: 8%">����Ժ</td>
						<td style="width: 15%">
						    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="����Ժ" defaultValue="" width="200px">
				              <BZ:option value="">--��ѡ����Ժ--</BZ:option>
			                </BZ:select>
						</td>
						<td class="bz-search-title" style="width: 8%">��ͯ���</td>
						<td style="width: 40%">
							<BZ:input prefix="S_" field="CHILD_NO" id="S_CHILD_NO" defaultValue="" restriction="hasSpecialChar" maxlength="50" />
						</td>
					</tr> 
					<tr>						
						<td class="bz-search-title">����</td>
						<td>
							<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" restriction="hasSpecialChar" maxlength="50" />
						</td>
						<td class="bz-search-title">�Ա�</td>
						<td>
							<BZ:select prefix="S_" id="S_SEX" field="SEX" isCode="true" codeName="ETXB" formTitle="�Ա�" defaultValue="">
				              <BZ:option value="">--��ѡ��--</BZ:option>
			                </BZ:select>
						</td>
						<td class="bz-search-title">��������</td>
						<td>
							<BZ:input prefix="S_" field="BIRTHDAY_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" id="S_BIRTHDAY_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" formTitle="��ʼ�ύ����" />~ 
							<BZ:input prefix="S_" field="BIRTHDAY_END" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" id="S_BIRTHDAY_END" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" formTitle="��ֹ�ύ����" />
						</td>
					</tr>
					<tr>
						<td class="bz-search-title">��ͯ����</td>
						<td>
							<BZ:select prefix="S_" id="S_CHILD_TYPE" field="CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="��ͯ����" defaultValue="">
				              <BZ:option value="">--��ѡ��--</BZ:option>
			                </BZ:select>
						</td>
						<td class="bz-search-title">�ر��ע</td>
						<td>
							<BZ:select prefix="S_" id="S_SPECIAL_FOCUS" field="SPECIAL_FOCUS" formTitle="�ر��ע" defaultValue="">
				              <BZ:option value="">--��ѡ��--</BZ:option>
				              <BZ:option value="0">��</BZ:option>
				              <BZ:option value="1">��</BZ:option>				              
			                </BZ:select>
						</td>
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
		<div class="wrapper"><!-- ���ܰ�ť������Start -->
		<div class="table-row table-btns" style="text-align: left"><input
			type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary"
			onclick="_showSearch()" />&nbsp; <input type="button"
			value="ѡ&nbsp;&nbsp;��" class="btn btn-sm btn-primary"
			onclick="_choice()" /></div>
		<div class="blue-hr"></div>
		<!-- ���ܰ�ť������End --> <!--��ѯ����б���Start -->
		<div class="table-responsive">
		<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
			<thead>
				<tr>
					<th class="center" style="width: 2%;">
					<div class="sorting_disabled"><input name="abcd"
						type="checkbox" class="ace"></div>
					</th>
					<th style="width: 5%;">
					<div class="sorting_disabled">���</div>
					</th>
					<th style="width: 10%;">
					<div class="sorting" id="CHILD_NO">��ͯ���</div>
					</th>
					<th style="width: 10%;">
					<div class="sorting" id="PROVINCE_ID">ʡ��</div>
					</th>
					<th style="width: 20%;">
					<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
					</th>
					<th style="width: 10%;">
					<div class="sorting" id="NAME">����</div>
					</th>
					<th style="width: 10%;">
					<div class="sorting" id="SEX">�Ա�</div>
					</th>
					<th style="width: 10%;">
					<div class="sorting" id="BIRTHDAY">��������</div>
					</th>
					<th style="width: 10%;">
					<div class="sorting" id="CHILD_TYPE">��������</div>
					</th>
					<th style="width: 10%;">
					<div class="sorting" id="SPECIAL_FOCUS">�ر��ע</div>
					</th>
				</tr>
			</thead>
			<tbody>
				<BZ:for property="List">
					<tr class="emptyData">
						<td class="center"><input name="abc" type="checkbox" value="<BZ:data field="TID_ID" onlyValue="true"/>" class="ace">
						</td>
						<td class="center"><BZ:i /></td>
						<td><BZ:data field="CHILD_NO" defaultValue="" onlyValue="true" /></td>
						<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true" /></td>
						<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true" /></td>
						<td><BZ:data field="NAME" defaultValue="" onlyValue="true" /></td>
						<td style="text-align:center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true" /></td>
						<td style="text-align:center"><BZ:data type="date" field="BIRTHDAY" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" /></td>
						<td style="text-align:center"><BZ:data field="CHILD_TYPE" codeName="CHILD_TYPE" defaultValue="" onlyValue="true" /></td>
						<td style="text-align:center"><BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=��;1=��" /></td>
					</tr>
				</BZ:for>
			</tbody>
		</table>
		</div>
		<!--��ѯ����б���End --> <!--��ҳ������Start -->
		<div class="footer-frame">
		<table border="0" cellpadding="0" cellspacing="0" class="operation">
			<tr>
				<td><BZ:page form="srcForm" property="List" /></td>
			</tr>
		</table>
		</div>
		<!--��ҳ������End --></div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>
