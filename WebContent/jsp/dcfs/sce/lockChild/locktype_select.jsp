<%
/**   
 * @Title: locktype_select.jsp
 * @Description:  儿童锁定方式选择页面
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
		<title>儿童锁定方式选择页面</title>
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
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" field="CI_ID" prefix="R_" id="R_CI_ID" defaultValue=""/>
		<BZ:input type="hidden" field="PUB_ID" prefix="R_" id="R_PUB_ID" defaultValue=""/>		
		<BZ:input type="hidden" field="FILE_TYPE" prefix="R_" id="R_FILE_TYPE" defaultValue=""/>
		<BZ:input type="hidden" field="LOCK_MODE" prefix="R_" id="R_LOCK_MODE" defaultValue=""/>
		<BZ:input type="hidden" field="SPECIAL_FOCUS" prefix="R_" id="R_SPECIAL_FOCUS" property="childdata" defaultValue=""/>
		<!-- 隐藏区域end -->
		<!-- 进度条begin -->
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
		<!-- 进度条end -->
		<!-- 锁定的儿童信息begin -->
		<div class="bz-edit-data-content clearfix" desc="内容体" style="width: 98%;margin-left:auto;margin-right:auto;">
			<table class="bz-edit-data-table" border="0">
				<tr>
					<td class="bz-edit-data-title" width="10%" rowspan="<%=(String)request.getAttribute("NUM") %>" style="background-color: rgb(245, 245, 245);text-align: left;line-height: 20px;">1.儿童信息<br>Child basic Inf.</td>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">姓名<br>Name(EN)</td>
					<td class="bz-edit-data-value" width="12%">
						<%=(String)childdata.getString("NAME_PINYIN","") %>
					</td>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">性别<br>Sex</td>
					<td class="bz-edit-data-value" width="13%">
						<BZ:dataValue field="" checkValue="1=Male;2=Female;3=N/A;" defaultValue='<%=(String)childdata.getString("SEX","") %>' onlyValue="true"/>
					</td>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">出生日期<br>D.O.B</td>
					<td class="bz-edit-data-value" width="12%">
						<%=(String)childdata.getString("BIRTHDAY","").substring(0, 10) %>
					</td>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">特别关注<br>Special focus</td>
					<td class="bz-edit-data-value" width="13%">
						<BZ:dataValue field="" checkValue="0=No;1=Yes;" defaultValue='<%=(String)childdata.getString("SPECIAL_FOCUS","") %>' onlyValue="true"/>
					</td>
				</tr>
				<BZ:for property="attachList" fordata="attachData">
				<tr>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">姓名<br>Name(EN)</td>
					<td class="bz-edit-data-value" width="12%">
						<BZ:dataValue field="NAME_PINYIN" property="attachData" defaultValue="" onlyValue="true"/>
					</td>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">性别<br>Sex</td>
					<td class="bz-edit-data-value" width="13%">
						<BZ:dataValue field="SEX" checkValue="1=Male;2=Femae;3=N/A;" property="attachData" defaultValue="" onlyValue="true"/>
					</td>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">出生日期<br>D.O.B</td>
					<td class="bz-edit-data-value" width="12%">
						<BZ:dataValue field="BIRTHDAY" type="Date" property="attachData" defaultValue="" onlyValue="true"/>
					</td>
					<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">特别关注<br>Special focus</td>
					<td class="bz-edit-data-value" width="13%">
						<BZ:dataValue field="SPECIAL_FOCUS" checkValue="0=No;1=Yes;" property="attachData" defaultValue="" onlyValue="true"/>
					</td>
				</tr>
				</BZ:for>
			</table>
		</div>
		<!-- 锁定的儿童信息end -->
		<!-- 锁定方式选择begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;width: 5%;">选择<br>Select</td>
							<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;width: 10%;">锁定代码<br>Locking code</td>
							<td class="bz-edit-data-title" style="text-align: center;width: 45%;line-height: 20px;">锁定类型<br>Locking type</td>
							<td class="bz-edit-data-title" style="text-align: center;width: 40%;line-height: 20px;">文件递交方式要求<br>Requirement of document submission</td>
						</tr>
						<tr>
							<td class="bz-edit-data-value" style="text-align: center;width: 5%;">
								<input name="xuanze" type="radio" value="1" lock_type="A" file_type="21" class="ace">
							</td>
							<td class="bz-edit-data-value" style="text-align: center;width: 5%;">A</td>
							<td class="bz-edit-data-value" width="45%">
								已递交收养申请文件，现申请锁定一名特需儿童<br>Apply to lock a special needs (SN) child with adoption application files already registered.
							</td>
							<td class="bz-edit-data-value" width="5%">
								无<br>None
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-value" style="text-align: center;">
								<input name="xuanze" type="radio" value="3" lock_type="B" file_type="22" class="ace">
							</td>
							<td class="bz-edit-data-value" style="text-align: center;">B</td>
							<td class="bz-edit-data-value">
								已递交收养申请文件，且已锁定一名特需儿童，并获得预批通过，但尚未完成收养登记，现再次申请锁定一名<font color="red"><b>特别关注</b></font>儿童<br>
								Apply to lock a <font color="red"><b>SF</b></font> child when an adoptive family has locked a SN child with adoption application files already registered and pre-approved by CCCWA, but without finalizing adoption registration.
							</td>
							<td class="bz-edit-data-value">
								请在预批通过后三个月内递交“收养申请书”、“家庭调查报告更新”及“政府批准书”等三种文件。<br>
								Please submit "Adoption application", "Updated home study report" and "Government approval certificate" within three months after being pre-approved.
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-value" style="text-align: center;">
								<input name="xuanze" type="radio" value="4" lock_type="C" file_type="22" class="ace">
							</td>
							<td class="bz-edit-data-value" style="text-align: center;">C</td>
							<td class="bz-edit-data-value">
								已递交收养申请文件并审核通过，希望原文件继续排队收养，现又申请锁定一名<font color="red"><b>特别关注</b></font>儿童<br>
								Apply to lock a <font color="red"><b>SF</b></font> child with adoption application files already registered and reviewed while keeping original files waiting to be placed with a normal program child.
							</td>
							<td class="bz-edit-data-value">
								请在预批通过后三个月内递交“收养申请书”、“家庭调查报告更新”及“政府批准书”等三种文件。<br>
								Please submit "Adoption application", "Updated home study report" and "Government approval certificate" within three months after being pre-approved. 
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-value" style="text-align: center;">
								<input name="xuanze" type="radio" value="2" lock_type="D" file_type="20" class="ace">
							</td>
							<td class="bz-edit-data-value" style="text-align: center;">D</td>
							<td class="bz-edit-data-value">
								尚未递交收养申请文件，现申请锁定一名<font color="red"><b>特别关注</b></font>儿童<br>
								Apply to lock a <font color= "red" ><b>Special focus(SF)</b></font> child without having submitted adoption application files to CCCWA.
							</td>
							<td class="bz-edit-data-value">
								请在预批通过后六个月内递交全套收养申请文件。<br>
								Please submit all adoption application documents within six months after being pre-approved.  
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-value" style="text-align: center;">
								<input name="xuanze" type="radio" value="5" lock_type="E" file_type="23" class="ace">
							</td>
							<td class="bz-edit-data-value" style="text-align: center;">E</td>
							<td class="bz-edit-data-value">
								尚未递交收养申请文件，但已锁定一名特需儿童，并获得预批通过，现再次申请同时领养另一名<font color="red"><b>特别关注</b></font>儿童<br>
								Apply to adopt another <font color= "red" ><b>SF</b></font> child when an adoptive family has locked a SF child and been pre-approved without having submitted adoption application files to CCCWA.
							</td>
							<td class="bz-edit-data-value">
								请在首次预批通过后六个月内递交全套收养申请文件。<br>
								Please submit all adoption application documents within six months after getting the first pre-approval. 
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-value" style="text-align: center;">
								<input name="xuanze" type="radio" value="6" lock_type="F" file_type="22" class="ace">
							</td>
							<td class="bz-edit-data-value" style="text-align: center;">F</td>
							<td class="bz-edit-data-value">
								在收养登记完成一年内，申请再次锁定一名<font color="red"><b>特别关注</b></font>儿童<br>
								Apply to lock a <font color= "red" ><b>SF</b></font> child within one year after finalizing the previous adoption registration.
							</td>
							<td class="bz-edit-data-value">
								请在预批通过后三个月内递交“收养申请书”、“家庭调查报告更新”及“政府批准书”等三种文件。<br>
								Please submit "Adoption application", "Updated home study report" and "Government approval certificate" within three months after being pre-approved.
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 锁定方式选择end -->
		<br/>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="Next step" class="btn btn-sm btn-primary" onclick="_goNext();"/>
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goBack();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		</BZ:form>
	</BZ:body>
</BZ:html>