<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: billregistration_selectfile.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-11-14 ����10:23:12 
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
  String CHEQUE_ID=(String)request.getAttribute("CHEQUE_ID");
  if(CHEQUE_ID==null){
	  CHEQUE_ID="";
  }
  String PAID_NO=(String)request.getAttribute("PAID_NO");
  if(PAID_NO==null){
	  PAID_NO="";
  }
  String country_code=(String)request.getAttribute("country_code");
  if(country_code==null){
	  country_code="";
  }
  String adopt_org_id=(String)request.getAttribute("adopt_org_id");
  if(adopt_org_id==null){
	  adopt_org_id="";
  }
  String name_cn=(String)request.getAttribute("name_cn");
  if(name_cn==null){
	  name_cn="";
  }
  String PAID_WAY=(String)request.getAttribute("PAID_WAY");
  if(PAID_WAY==null){
	  PAID_WAY="";
  }
  String PAR_VALUE=(String)request.getAttribute("PAR_VALUE");
  if(PAR_VALUE==null){
	  PAR_VALUE="";
  }
  String BILL_NO=(String)request.getAttribute("BILL_NO");
  if(BILL_NO==null){
	  BILL_NO="";
  }
  String REMARKS=(String)request.getAttribute("REMARKS");
  if(REMARKS==null){
	  REMARKS="";
  }
%>
<BZ:html>
	<BZ:head>
		<title>��ѯ�б�</title>
        <BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	</BZ:head>
  <script type="text/javascript">
  
  $(document).ready(function() {
  	var NAME_CN=$("#S_NAME_CN").val();
  	if(NAME_CN==null||NAME_CN=="null"){
  		NAME_CN="";
  	}
  	$("#S_ADOPT_ORG_NAME").val(NAME_CN);
  	
  });
 
 //��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['900px','170px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
 
  function search(){
     document.srcForm.action=path+"fam/billRegistration/selectFileList.action";
	 document.srcForm.submit();
  }
  
  function _choice(){
	  	var num = 0;
		var chioceuuid = [];
		var CHEQUE_ID = document.getElementById("CHEQUE_ID").value;
		var PAID_NO = document.getElementById("PAID_NO").value;
		var COUNTRY_CODE = document.getElementById("country_code").value;
		var ADOPT_ORG_ID = document.getElementById("adopt_org_id").value;
		var NAME_CN = document.getElementById("name_cn").value;
		var PAID_WAY = document.getElementById("PAID_WAY").value;
		var PAR_VALUE = document.getElementById("PAR_VALUE").value;
		var BILL_NO = document.getElementById("BILL_NO").value;
		var REMARKS = document.getElementById("REMARKS").value;
		var arrays = document.getElementsByName("abc");
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				chioceuuid[num++] = arrays[i].value;
				num += 1;
			}
		}
		if(num < 1){
			page.alert('��ѡ��Ҫ��ӵ��ļ���');
			return;
		}else{
	  		var uuid = chioceuuid.join("#");
	  		if (confirm("ȷ�������Щ�ļ���")){
				$.ajax({
					url: path+'AjaxExecute?className=com.dcfs.fam.billRegistration.BillRegistrationAjax',
					type: 'POST',
					data: {'uuid':uuid,'date':new Date().valueOf()},
					dataType: 'json',
					error:function(XMLHttpRequest, textStatus, errorThrown){
						alert("������Ϣ��"+XMLHttpRequest+":"+textStatus+":"+errorThrown);
					},
					success: function(data){
						opener.refreshLocalList(CHEQUE_ID,PAID_NO,COUNTRY_CODE,ADOPT_ORG_ID,NAME_CN,PAID_WAY,PAR_VALUE,BILL_NO,REMARKS);
						window.close();
					}
			  	});
			}
	  	}
	}
  
  
  //���÷������ɶ���
  function _reset(){
  	$("#S_FILE_NO").val("");
  	$("#S_REGISTER_DATE_START").val("");
  	$("#S_REGISTER_DATE_END").val("");
  	$("#S_FILE_TYPE").val("");
  	$("#S_AF_COST").val("");
  	$("#S_MALE_NAME").val("");
  	$("#S_FEMALE_NAME").val("");
  	$("#S_AF_COST_PAID").val("");
  }
  

  </script>
<BZ:body property="data"  codeNames="WJLX;GJSY;SYZZ;TWCZFS_ALL">
     <BZ:form name="srcForm" method="post" action="fam/billRegistration/selectFileList.action">
     <input type="hidden" name="chioceuuid" id="chioceuuid" value="" />
     <input type="hidden" name="CHEQUE_ID" id="CHEQUE_ID" value="<%=CHEQUE_ID%>" />
     <input type="hidden" name="PAID_NO" id="CHEQUE_ID" value="<%=PAID_NO%>" />
     <input type="hidden" name="country_code" id="country_code" value="<%=country_code%>" />
     <input type="hidden" name="adopt_org_id" id="adopt_org_id" value="<%=adopt_org_id%>" />
     <input type="hidden" name="name_cn" id="name_cn" value="<%=name_cn%>" />
     <input type="hidden" name="PAID_WAY" id="PAID_WAY" value="<%=PAID_WAY%>" />
     <input type="hidden" name="PAR_VALUE" id="PAR_VALUE" value="<%=PAR_VALUE%>" />
     <input type="hidden" name="BILL_NO" id="BILL_NO" value="<%=BILL_NO%>" />
     <input type="hidden" name="REMARKS" id="REMARKS" value="<%=REMARKS%>" />
     <!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
	 <input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	 <input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	 <div class="page-content">
	 <BZ:frameDiv property="clueTo" className="kuangjia">
	 </BZ:frameDiv>
	 <!-- ��ѯ������Start -->
	<div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
			<tr>
				<td style="width: 100%;">
					<table>
							<tr>
								<td class="bz-search-title" style="width: 10%">�ļ�����</td>
								<td style="width: 18%">
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" formTitle="�ļ�����" defaultValue="" width="78%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 10%">��������</td>
								<td style="width: 34%">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">���ı��</td>
								<td>
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" maxlength="50" style="width:165px;"/>
								</td>
								
								<td class="bz-search-title"><span title="��������">��������</span></td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="150" style="width:270px;"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">Ӧ�ɽ��</td>
								<td>
									<BZ:input prefix="S_" field="AF_COST" id="S_AF_COST" defaultValue="" formTitle="Ӧ�ɽ��" restriction="int" maxlength="4" style="width:165px;"/>
								</td>
								
								<td class="bz-search-title">Ů������</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������" maxlength="150" style="width:270px;"/>
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
     <div class="wrapper">
	 <!-- ���ܰ�ť������Start -->
	 <div class="table-row table-btns" style="text-align: left">
		<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
		<input type="button" value="ѡ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_choice()"/>	
	</div>
	<div class="blue-hr"></div>
	<!-- ���ܰ�ť������End -->
	
		
		<!--��ѯ����б���Start -->
		<div class="table-responsive">
			<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
				<thead>
					<tr>
						<th class="center" style="width:3%;">
							<div class="sorting_disabled"><input name="abcd" type="checkbox" class="ace"></div>
						</th>
						<th style="width:5%;">
							<div class="sorting_disabled">���</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="FILE_NO">���ı��</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="REGISTER_DATE">��������</div>
						</th>
						<th style="width:7%;">
							<div class="sorting" id="COUNTRY_CODE">����</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="NAME_CN">������֯</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="FILE_TYPE">�ļ�����</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="AF_COST">Ӧ�ɽ��</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="MALE_NAME">��������</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="FEMALE_NAME">Ů������</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="PAID_NO">�ɷѱ��</div>
						</th>
						<th style="width:7%;">
							<div class="sorting" id="AF_COST_PAID">�ɷ�״̬</div>
						</th>
					</tr>
					</thead>
					<tbody>	
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="abc" type="checkbox" value="<BZ:data field="AF_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="FILE_NO"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AF_COST"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PAID_NO"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AF_COST_PAID"  defaultValue="" onlyValue="true" checkValue="0=δ�ɷ�;1=�ѽɷ�;"/></td>
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
		</BZ:form>
	</BZ:body>
</BZ:html>
