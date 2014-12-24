<%
/**   
 * @Title: adoptionassociation_confirm.jsp
 * @Description:  收养协议确认页面
 * @author yangrt   
 * @date 2014-09-21 10:01:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
	<BZ:head language="EN">
		<title>收养协议确认页面</title>
		<BZ:webScript edit="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//公共功能，框架元素自适应
				$("#tiaozhuan").attr("disabled",true);
				$("#queren").bind("click",function(){
					if(this.checked){ 
					  document.getElementById("tiaozhuan").disabled=false; 
					}else{ 
					  document.getElementById("tiaozhuan").disabled=true; 
					} 
				});
			});
			
			function _confirmSubmit(){
				window.location.href=path+"sce/lockchild/LockChildList.action";
			}
		</script>
	</BZ:head>
	<BZ:body>
		<BZ:form name="srcForm" method="post">
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>收养协议确认(Adoption association confirm)</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td>
								<table style="width: 80%;margin-left: auto;margin-right: auto;" >
									<tr>
										<td style="text-align: center;font-size: 14pt;line-height: 35px;">
											On-line Entrustment System for Special Needs Children<br/>
										</td>
									</tr>
									<tr>
										<td style="font-size: 12pt;line-height: 25px;">
								Our organization applies voluntarily to use the CCCWA’s On-line Entrustment System for Special Needs Children
(hereafter referred to as “on-line operation system”) and promises to strictly obey, without deviation therefore, the following rules and guidelines: <br/><br/>
1．The Adoption Law of the People’s Republic of China and the Hague Convention on Protection of Children and Co-operation in respect of Inter-country Adoption as well as related rules and regulations in the co-operation on inter-country adoption between CCCWA and foreign adoption agencies will be strictly followed. <br/><br/>
2.Our organization promises that the encryption key and all passwords provided will only be used by our staff and the encryption key and passwords will not be disclosed to others. <br/><br/>
3.Our organization promises that we will safeguard children’s privacy; that children’s information will not be disclosed to other units or individuals; and there will be no copying, spreading and republishing of all or part of words, photos and video materials of the on-line operation system. <br/><br/>
4.Our organization promises that authentic and current materials of the applicants will be provided, and that we will not fake application materials. Further, our organization warrants the accuracy of all information published to or uploaded to the on-line operation system. Should any change occur, we will update such information or notify CCCWA in written forms immediately. <br/><br/>
5.Our organization promises that we will take the best interests of the special needs children as the prerequisite. To that end, our organization promises to try our best efforts to introduce to, and educate adoptive families in, the sensitive topic of caring for special needs children, and to provide complete and accurate information. Further, we promise not to use biased or prejudiced language when providing said information.<br/><br/> 
6.Our organization promises that we will submit post-placement reports of the adopted children required by the CCCWA and the submission proportion shall reach 100%. 
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-value" style="text-align: center;font-size: 14pt;line-height:36px;">
								<input name="xuanze" type="checkbox" value="" class="ace" id="queren">
								<a href="javascript.void(0);">我同意并接受收养协议(I agree and accept the adoption agreement)</a>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 编辑区域end -->
		<br/>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="我已阅读该条款" class="btn btn-sm btn-primary" onclick="_confirmSubmit();" id="tiaozhuan"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		</BZ:form>
	</BZ:body>
</BZ:html>