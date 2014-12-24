<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: fileinfoF_select.jsp
 * @Description: ��������ΪF���ļ���Ϣ�б�
 * @author yangrt   
 * @date 2014-9-21
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
	
	Data data = (Data)request.getAttribute("data");
	Data childdata = (Data)request.getAttribute("childdata");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>��������ΪF���ļ���Ϣ�б�</title>
		<BZ:webScript edit="true" list="true"/>
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
				area: ['800px','200px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"sce/lockchild/FileInfoSelect.action?type=F&page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
		}
		
		
		function _goNext(){
			var num = 0;
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					$("#R_AF_ID").val(arrays[i].value);
					$("#R_MALE_NAME").val(arrays[i].getAttribute("MALE_NAME"));
					$("#R_FEMALE_NAME").val(arrays[i].getAttribute("FEMALE_NAME"));
					num++;
				}
			}
			if(num != "1"){
				alert('Please select one data!');
				return;
			}else{
				document.srcForm.action=path+"sce/lockchild/ChildInfoLock.action?type=show";
				document.srcForm.submit();
			}
		}
		
		function _goBack(){
			document.srcForm.action=path+"sce/lockchild/LockTypeSelect.action";
			document.srcForm.submit();
		}
		
		function _showFileData(af_id){
			var url = path + "sce/lockchild/GetAdoptionPersonInfo.action?Flag=EN&type=F&AF_ID=" + af_id;
			_open(url,"window",950,600);
		}
		
	</script>
	<BZ:body property="searchData" codeNames="WJLX;PROVINCE;SDFS;ADOPTER_CHILDREN_SEX;">
		<BZ:form name="srcForm" method="post" action="sce/lockchild/FileInfoSelect.action?type=F">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		<!-- ��������begin -->
		<BZ:input type="hidden" field="CI_ID" prefix="R_" id="R_CI_ID" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="PUB_ID" prefix="R_" id="R_PUB_ID" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="FILE_TYPE" prefix="R_" id="R_FILE_TYPE" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="LOCK_MODE" prefix="R_" id="R_LOCK_MODE" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="AF_ID" prefix="R_" id="R_AF_ID" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="MALE_NAME" prefix="R_" id="R_MALE_NAME" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="FEMALE_NAME" prefix="R_" id="R_FEMALE_NAME" property="data" defaultValue=""/>
		<!-- ��������end -->
		<!-- ������begin -->
		<div class="stepflex" style="margin-right: 30px;">
	        <dl id="payStepFrist" class="first done">
	            <dt class="s-num">1</dt>
	            <dd class="s-text">
					Step one: Choose a locking method
				</dd>
	        </dl>
	        <dl id="payStepNormal" class="normal doing">
	            <dt class="s-num">2</dt>
	            <dd class="s-text">
	            	Step two: Choose the family file or fill in the applicant name
	            </dd>
	        </dl>
	        <dl id="payStepLast" class="last">
	            <dt class="s-num">3</dt>
	            <dd class="s-text">
	            	Step three: lock SN child file
	            </dd>
	        </dl>
		</div>
		<!-- ������end -->
		<!-- �����Ķ�ͯ��Ϣbegin -->
		<div class="bz-edit-data-content clearfix" desc="������" style="width: 98%;margin-left:auto;margin-right:auto;">
			<table class="bz-edit-data-table" border="0">
				<tr>
					<td class="bz-edit-data-title" width="10%" rowspan="<%=(String)request.getAttribute("NUM") %>" style="background-color: rgb(245, 245, 245);line-height: 20px;text-align: left">1.��ͯ��Ϣ<br>Child basic Inf.</td>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">����<br>Name(EN)</td>
					<td class="bz-edit-data-value" width="12%">
						<%=(String)childdata.getString("NAME_PINYIN","") %>
					</td>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">�Ա�<br>Sex</td>
					<td class="bz-edit-data-value" width="13%">
						<BZ:dataValue field="" codeName="ADOPTER_CHILDREN_SEX" isShowEN="true" defaultValue='<%=(String)childdata.getString("SEX","") %>' onlyValue="true"/>
					</td>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">��������<br>D.O.B</td>
					<td class="bz-edit-data-value" width="12%">
						<%=(String)childdata.getString("BIRTHDAY","").substring(0, 10) %>
					</td>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">�ر��ע<br>Special focus</td>
					<td class="bz-edit-data-value" width="13%">
						<BZ:dataValue field="" checkValue="0=No;1=Yes;" defaultValue='<%=(String)childdata.getString("SPECIAL_FOCUS","") %>' onlyValue="true"/>
					</td>
				</tr>
				<BZ:for property="attachList" fordata="attachData">
				<tr>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">����<br>Name(EN)</td>
					<td class="bz-edit-data-value" width="12%">
						<BZ:dataValue field="NAME_PINYIN" property="attachData" defaultValue="" onlyValue="true"/>
					</td>
					<td class="bz-edit-data-title" style="text-align: center;" width="10%">�Ա�<br>Sex</td>
					<td class="bz-edit-data-value" width="13%">
						<BZ:dataValue field="SEX" codeName="ADOPTER_CHILDREN_SEX" isShowEN="true" property="attachData" defaultValue="" onlyValue="true"/>
					</td>
					<td class="bz-edit-data-title" style="text-align: center;" width="10%">��������<br>D.O.B</td>
					<td class="bz-edit-data-value" width="12%">
						<BZ:dataValue field="BIRTHDAY" type="Date" property="attachData" defaultValue="" onlyValue="true"/>
					</td>
					<td class="bz-edit-data-title" style="text-align: center;" width="10%">�ر��ע<br>Special focus</td>
					<td class="bz-edit-data-value" width="13%">
						<BZ:dataValue field="SPECIAL_FOCUS" checkValue="0=No;1=Yes;" property="attachData" defaultValue="" onlyValue="true"/>
					</td>
				</tr>
				</BZ:for>
			</table>
		</div>
		<!-- �����Ķ�ͯ��Ϣend -->
		<div class="bz-edit-data-content clearfix" desc="������" style="width: 98%;margin-top:8px;margin-left:auto;margin-right:auto;">
			<table class="bz-edit-data-table" border="0">
				<tr>
					<td class="bz-edit-data-title" width="10%" style="background-color: rgb(245, 245, 245);line-height: 20px;text-align: left">2.������ʽ<br>Lock type</td>
					<td class="bz-edit-data-value" width="90%">
						<BZ:dataValue field="" codeName="SDFS" defaultValue='<%=(String)data.getString("LOCK_MODE","") %>' onlyValue="true"/><br>
						<BZ:dataValue field="" codeName="SDFS" defaultValue='<%=(String)data.getString("LOCK_MODE","") %>' isShowEN="true" onlyValue="true"/>
					</td>
				</tr>
			</table>
		</div>
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 12%"><span title="Adoptive father">��������<br>Adoptive father</span></td>
								<td style="width: 38%">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="Adoptive father" maxlength="150" style="width:270px;"/>
								</td>
								
								<td class="bz-search-title" style="width: 12%">Ů������<br>Adoptive mother</td>
								<td style="width: 38%">
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Adoptive mother" maxlength="150" style="width:270px;"/>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title"><span title="Log-in No.">���ı��<br>Log-in No.</span></td>
								<td>
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="Log-in No." maxlength="50"/>
								</td>
							
								<td class="bz-search-title">�Ǽ�����<br>REGIST DATE</td>
								<td>
									<BZ:input prefix="S_" field="REG_DATE_START" id="S_REG_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REG_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="REG_DATE_END" id="S_REG_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REG_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
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
		<!-- ѡ���ͥ�ļ�begin -->
		<div class="page-content" style="width: 98%;margin-top: 8px;margin-left:auto;margin-right:auto;">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="Search" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
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
								<th style="width: 3%;">
									<div class="sorting_disabled">���<br>No.</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FILE_NO">���ı��<br>Log-in No.</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="REGISTER_DATE">��������<br>Log-in date</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="MALE_NAME">��������<br>Adoptive father</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="FEMALE_NAME">Ů������<br>Adoptive mother</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FILE_TYPE">�ļ�����<br>Document type</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��<br>Province</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="NAME_PINYIN">����<br>Name</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="SIGN_DATE">ǩ������<br>Issuing date</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="ADREG_DATE">�Ǽ�����<br>REGIST DATE</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled">����<br>Operation</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="AF_ID" onlyValue="true"/>" MALE_NAME='<BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/>' FEMALE_NAME='<BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/>' class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REGISTER_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="FILE_TYPE" codeName="WJLX" isShowEN="true" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE" isShowEN="true" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME_PINYIN" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SIGN_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="ADREG_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td class="center">
									<a href="#" onclick="_showFileData('<BZ:data field="AF_ID" onlyValue="true"/>');return false;">
										view
									</a>
								</td>
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
		<!-- ѡ���ͥ�ļ�end -->
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="Next step" class="btn btn-sm btn-primary" onclick="_goNext();"/>
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goBack();"/>
			</div>
		</div>
		<!-- ��ť����end -->
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>