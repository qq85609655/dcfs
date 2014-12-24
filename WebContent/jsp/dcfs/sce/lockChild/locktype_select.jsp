<%
/**   
 * @Title: locktype_select.jsp
 * @Description:  ��ͯ������ʽѡ��ҳ��
 * @author yangrt   
 * @date 2014-09-16 20:01:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	Data childdata = (Data)request.getAttribute("childdata");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>��ͯ������ʽѡ��ҳ��</title>
		<BZ:webScript edit="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);
			});
			
			function _goNext(){
				var flag = false;
				var lock_type = "";
				var focus = $("#R_SPECIAL_FOCUS").val();
				var arrays = document.getElementsByName("xuanze");
				for(var i=0; i<arrays.length; i++){
					if(arrays[i].checked){
						$("#R_FILE_TYPE").val(arrays[i].getAttribute("file_type"));
						$("#R_LOCK_MODE").val(arrays[i].value);
						lock_type = arrays[i].getAttribute("lock_type");
						if(focus == "0" && lock_type != "A"){
							alert("This method is only for locking Special focus children. Please select another method!");
							return;
						}
						flag = true;
					}
				}
				if(flag){
					if(lock_type == "D"){
						document.srcForm.action=path+"sce/lockchild/ChildInfoLock.action?type=add";
						document.srcForm.submit();
					}else{
						document.srcForm.action=path+"sce/lockchild/FileInfoSelect.action?type=" + lock_type;
						document.srcForm.submit();
					}
				}else{
					alert('Please select one locking method!');
					return;
				}
			}
			
			function _goBack(){
				document.srcForm.action = path + "sce/lockchild/LockChildList.action";
				document.srcForm.submit();
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="SDFS;">
		<BZ:form name="srcForm" method="post">
		<!-- ��������begin -->
		<BZ:input type="hidden" field="CI_ID" prefix="R_" id="R_CI_ID" defaultValue=""/>
		<BZ:input type="hidden" field="PUB_ID" prefix="R_" id="R_PUB_ID" defaultValue=""/>		
		<BZ:input type="hidden" field="FILE_TYPE" prefix="R_" id="R_FILE_TYPE" defaultValue=""/>
		<BZ:input type="hidden" field="LOCK_MODE" prefix="R_" id="R_LOCK_MODE" defaultValue=""/>
		<BZ:input type="hidden" field="SPECIAL_FOCUS" prefix="R_" id="R_SPECIAL_FOCUS" property="childdata" defaultValue=""/>
		<!-- ��������end -->
		<!-- ������begin -->
		<div class="stepflex" style="margin-right: 30px;">
	        <dl id="payStepFrist" class="first doing">
	            <dt class="s-num">1</dt>
	            <dd class="s-text" style="margin-left: -8px;">
					Step one: Choose a locking method
	            </dd>
	        </dl>
	        <dl id="payStepNormal" class="normal do">
	            <dt class="s-num">2</dt>
	            <dd class="s-text" style="margin-left: -8px;">
	            	Step two: Choose the family file or fill in the applicant name
	            </dd>
	        </dl>
	        <dl id="payStepLast" class="last">
	            <dt class="s-num">3</dt>
	            <dd class="s-text" style="margin-left: -8px;">
	            	Step three: lock SN child file
	            </dd>
	        </dl>
		</div>
		<!-- ������end -->
		<!-- �����Ķ�ͯ��Ϣbegin -->
		<div class="bz-edit-data-content clearfix" desc="������" style="width: 98%;margin-left:auto;margin-right:auto;">
			<table class="bz-edit-data-table" border="0">
				<tr>
					<td class="bz-edit-data-title" width="10%" rowspan="<%=(String)request.getAttribute("NUM") %>" style="background-color: rgb(245, 245, 245);text-align: left;line-height: 20px;">1.��ͯ��Ϣ<br>Child basic Inf.</td>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">����<br>Name(EN)</td>
					<td class="bz-edit-data-value" width="12%">
						<%=(String)childdata.getString("NAME_PINYIN","") %>
					</td>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">�Ա�<br>Sex</td>
					<td class="bz-edit-data-value" width="13%">
						<BZ:dataValue field="" checkValue="1=Male;2=Female;3=N/A;" defaultValue='<%=(String)childdata.getString("SEX","") %>' onlyValue="true"/>
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
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">�Ա�<br>Sex</td>
					<td class="bz-edit-data-value" width="13%">
						<BZ:dataValue field="SEX" checkValue="1=Male;2=Femae;3=N/A;" property="attachData" defaultValue="" onlyValue="true"/>
					</td>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">��������<br>D.O.B</td>
					<td class="bz-edit-data-value" width="12%">
						<BZ:dataValue field="BIRTHDAY" type="Date" property="attachData" defaultValue="" onlyValue="true"/>
					</td>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">�ر��ע<br>Special focus</td>
					<td class="bz-edit-data-value" width="13%">
						<BZ:dataValue field="SPECIAL_FOCUS" checkValue="0=No;1=Yes;" property="attachData" defaultValue="" onlyValue="true"/>
					</td>
				</tr>
				</BZ:for>
			</table>
		</div>
		<!-- �����Ķ�ͯ��Ϣend -->
		<!-- ������ʽѡ��begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;width: 5%;">ѡ��<br>Select</td>
							<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;width: 10%;">��������<br>Locking code</td>
							<td class="bz-edit-data-title" style="text-align: center;width: 45%;line-height: 20px;">��������<br>Locking type</td>
							<td class="bz-edit-data-title" style="text-align: center;width: 40%;line-height: 20px;">�ļ��ݽ���ʽҪ��<br>Requirement of document submission</td>
						</tr>
						<tr>
							<td class="bz-edit-data-value" style="text-align: center;width: 5%;">
								<input name="xuanze" type="radio" value="1" lock_type="A" file_type="21" class="ace">
							</td>
							<td class="bz-edit-data-value" style="text-align: center;width: 5%;">A</td>
							<td class="bz-edit-data-value" width="45%">
								�ѵݽ����������ļ�������������һ�������ͯ<br>Apply to lock a special needs (SN) child with adoption application files already registered.
							</td>
							<td class="bz-edit-data-value" width="5%">
								��<br>None
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-value" style="text-align: center;">
								<input name="xuanze" type="radio" value="3" lock_type="B" file_type="22" class="ace">
							</td>
							<td class="bz-edit-data-value" style="text-align: center;">B</td>
							<td class="bz-edit-data-value">
								�ѵݽ����������ļ�����������һ�������ͯ�������Ԥ��ͨ��������δ��������Ǽǣ����ٴ���������һ��<font color="red"><b>�ر��ע</b></font>��ͯ<br>
								Apply to lock a <font color="red"><b>SF</b></font> child when an adoptive family has locked a SN child with adoption application files already registered and pre-approved by CCCWA, but without finalizing adoption registration.
							</td>
							<td class="bz-edit-data-value">
								����Ԥ��ͨ�����������ڵݽ������������顱������ͥ���鱨����¡�����������׼�顱�������ļ���<br>
								Please submit "Adoption application", "Updated home study report" and "Government approval certificate" within three months after being pre-approved.
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-value" style="text-align: center;">
								<input name="xuanze" type="radio" value="4" lock_type="C" file_type="22" class="ace">
							</td>
							<td class="bz-edit-data-value" style="text-align: center;">C</td>
							<td class="bz-edit-data-value">
								�ѵݽ����������ļ������ͨ����ϣ��ԭ�ļ������Ŷ�������������������һ��<font color="red"><b>�ر��ע</b></font>��ͯ<br>
								Apply to lock a <font color="red"><b>SF</b></font> child with adoption application files already registered and reviewed while keeping original files waiting to be placed with a normal program child.
							</td>
							<td class="bz-edit-data-value">
								����Ԥ��ͨ�����������ڵݽ������������顱������ͥ���鱨����¡�����������׼�顱�������ļ���<br>
								Please submit "Adoption application", "Updated home study report" and "Government approval certificate" within three months after being pre-approved. 
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-value" style="text-align: center;">
								<input name="xuanze" type="radio" value="2" lock_type="D" file_type="20" class="ace">
							</td>
							<td class="bz-edit-data-value" style="text-align: center;">D</td>
							<td class="bz-edit-data-value">
								��δ�ݽ����������ļ�������������һ��<font color="red"><b>�ر��ע</b></font>��ͯ<br>
								Apply to lock a <font color= "red" ><b>Special focus(SF)</b></font> child without having submitted adoption application files to CCCWA.
							</td>
							<td class="bz-edit-data-value">
								����Ԥ��ͨ�����������ڵݽ�ȫ�����������ļ���<br>
								Please submit all adoption application documents within six months after being pre-approved.  
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-value" style="text-align: center;">
								<input name="xuanze" type="radio" value="5" lock_type="E" file_type="23" class="ace">
							</td>
							<td class="bz-edit-data-value" style="text-align: center;">E</td>
							<td class="bz-edit-data-value">
								��δ�ݽ����������ļ�����������һ�������ͯ�������Ԥ��ͨ�������ٴ�����ͬʱ������һ��<font color="red"><b>�ر��ע</b></font>��ͯ<br>
								Apply to adopt another <font color= "red" ><b>SF</b></font> child when an adoptive family has locked a SF child and been pre-approved without having submitted adoption application files to CCCWA.
							</td>
							<td class="bz-edit-data-value">
								�����״�Ԥ��ͨ�����������ڵݽ�ȫ�����������ļ���<br>
								Please submit all adoption application documents within six months after getting the first pre-approval. 
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-value" style="text-align: center;">
								<input name="xuanze" type="radio" value="6" lock_type="F" file_type="22" class="ace">
							</td>
							<td class="bz-edit-data-value" style="text-align: center;">F</td>
							<td class="bz-edit-data-value">
								�������Ǽ����һ���ڣ������ٴ�����һ��<font color="red"><b>�ر��ע</b></font>��ͯ<br>
								Apply to lock a <font color= "red" ><b>SF</b></font> child within one year after finalizing the previous adoption registration.
							</td>
							<td class="bz-edit-data-value">
								����Ԥ��ͨ�����������ڵݽ������������顱������ͥ���鱨����¡�����������׼�顱�������ļ���<br>
								Please submit "Adoption application", "Updated home study report" and "Government approval certificate" within three months after being pre-approved.
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- ������ʽѡ��end -->
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="Next step" class="btn btn-sm btn-primary" onclick="_goNext();"/>
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goBack();"/>
			</div>
		</div>
		<!-- ��ť����end -->
		</BZ:form>
	</BZ:body>
</BZ:html>