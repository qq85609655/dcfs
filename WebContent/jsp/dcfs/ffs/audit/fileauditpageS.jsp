<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
%>
<BZ:html>
<BZ:head>
	<title>家庭文件（单亲）经办人审核</title>
	<BZ:webScript edit="true"/>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"/>
</BZ:head>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
	});
</script>
<BZ:body property="filedata">
	<script type="text/javascript">
	    $(document).ready( function() {
	      $('#tab-container').easytabs();
	    });
	</script>
	<BZ:form name="srcForm" method="post">
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action" desc="按钮区">
			<a href="reporter_files_list.html" >
				<input type="button" value="保存" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="附件预览" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="打印" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="window.location.href='reporter_files_list.html'"/>
			</a>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<!-- 编辑区域 开始 -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">收养组织(CN)：</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">收养组织(EN)：</td>
						<td class="bz-edit-data-value" colspan="5"> 
							<BZ:dataValue field="NAME_EN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">收文日期：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REGISTER_DATE" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">收文编号：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_NO" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">文件类型：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue=""/>
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">收养类型：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_CONVENTION_ADOPT" checkValue="0=否;1=是" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">是否公约收养：</td>
						<td class="bz-edit-data-value"><BZ:dataValue field="IS_CONVENTION_ADOPT" checkValue="0=否;1=是" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title poptitle">之前收文编号：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">是否预警名单：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_ALERT" checkValue="0=否;1=是" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">是否转组织：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_CHANGE_ORG" checkValue="0=否;1=是" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">原收养组织：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORIGINAL_ORG_NAME_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">暂停状态：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_PAUSE" checkValue="0=未暂停;1=已暂停" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">暂停原因：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PAUSE_REASON" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">末次文件补充状态：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SUPPLY_STATE" checkValue="0=未补充;1=已补充" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">退文状态：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_STATE" checkValue="0=待确认;1=已确认;2=待处置;3=已处置" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">退文原因：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_REASON" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">文件补充次数：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_REASON" defaultValue=""/>
						</td>
					</tr>
				</table>
				<!-- 编辑区域 结束 -->
			</div>
		</div>
	</div>
	<div id="tab-container" class='tab-container'>
		<ul class='etabs'>
			<li class='tab'><a href="#tab1">基本信息(中文)</a></li>
			<li class='tab'><a href="#tab2">基本信息(英文)</a></li>
			<li class='tab'><a href="<%=path%>/ffs/jbraudit/ajaxaction.action #ajaxtab" data-target="#tab3">审核记录</a></li>
			<li class='tab'><a href="<%=path%>/ffs/jbraudit/ajaxaction.action #ajaxtab" data-target="#tab4">补充记录</a></li>
			<li class='tab'><a href="<%=path%>/ffs/jbraudit/ajaxaction.action #ajaxtab" data-target="#tab5">修改记录</a></li>
			<li class='tab'><a href="<%=path%>/ffs/jbraudit/ajaxaction.action #ajaxtab" data-target="#tab6">翻译记录</a></li>
		</ul>
		<div class='panel-container'>
			<div id="tab1">
				<table width="100%" border="1">
				  <tr>
				    <td colspan="7" align="center">收养人基本信息</td>
				  </tr>
				  <tr>
				    <td width="12%">外文姓名</td>
				    <td width="20%">&nbsp;</td>
				    <td width="15%">性别</td>
				    <td width="14%">&nbsp;</td>
				    <td width="13%">出生日期</td>
				    <td width="15%">&nbsp;</td>
				    <td width="11%" rowspan="5">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>年龄</td>
				    <td>&nbsp;</td>
				    <td>国籍</td>
				    <td>&nbsp;</td>
				    <td>护照号码</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td>受教育程度</td>
				    <td>&nbsp;</td>
				    <td>职业</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>健康状况</td>
				    <td colspan="2">&nbsp;</td>
				    <td>健康情况描述</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>身高</td>
				    <td colspan="2">&nbsp;</td>
				    <td>体重</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>体重指数</td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				    <td>违法行为及刑事处罚</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>有无不良嗜好</td>
				    <td colspan="2">&nbsp;</td>
				    <td>宗教信仰</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>婚姻状况</td>
				    <td colspan="2">&nbsp;</td>
				    <td>同居伙伴</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>同居时长</td>
				    <td colspan="2">&nbsp;</td>
				    <td>非同性恋声明</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>年收入</td>
				    <td colspan="2">&nbsp;</td>
				    <td>家庭总资产</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>家庭总债务</td>
				    <td colspan="2">&nbsp;</td>
				    <td>家庭净资产</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>子女数量及情况</td>
				    <td colspan="6">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>未成年子女数量</td>
				    <td colspan="6">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>家庭住址</td>
				    <td colspan="6">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>收养要求</td>
				    <td colspan="6">&nbsp;</td>
				  </tr>
				  <tr>
				    <td colspan="7" align="center">家庭调查及组织意见信息</td>
				  </tr>
				  <tr>
				    <td>完成家调组织名称</td>
				    <td>&nbsp;</td>
				    <td>家庭调查报告完成日期</td>
				    <td>&nbsp;</td>
				    <td>会见次数</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>推荐信</td>
				    <td>&nbsp;</td>
				    <td>心理评估报告</td>
				    <td>&nbsp;</td>
				    <td>收养动机</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>家中10周岁及以上孩子对收养的意见</td>
				    <td>&nbsp;</td>
				    <td>抚育计划</td>
				    <td>&nbsp;</td>
				    <td>有无监护人声明</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>收养前准备</td>
				    <td>&nbsp;</td>
				    <td>风险意识</td>
				    <td>&nbsp;</td>
				    <td>不遗弃不虐待 <br />
				声明</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>同意递交安置 <br />
				后报告声明</td>
				    <td>&nbsp;</td>
				    <td>家中有无其他人同住</td>
				    <td>&nbsp;</td>
				    <td>家中其他人同住说明</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>育儿经验</td>
				    <td>&nbsp;</td>
				    <td>社工意见</td>
				    <td colspan="4">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>家庭需说明的其它事项</td>
				    <td colspan="6">&nbsp;</td>
				  </tr>
				  <tr>
				    <td colspan="7" align="center">政府批准信息</td>
				  </tr>
				  <tr>
				    <td>批准日期</td>
				    <td>&nbsp;</td>
				    <td>有效期限</td>
				    <td>&nbsp;</td>
				    <td>批准儿童数量</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>收养儿童年龄</td>
				    <td>&nbsp;</td>
				    <td>收养儿童性别</td>
				    <td>&nbsp;</td>
				    <td>收养儿童健康状况</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td colspan="7" align="center">附件信息</td>
				  </tr>
				  <tr>
				    <td>跨国收养申请书</td>
				    <td colspan="2">&nbsp;</td>
				    <td>出生证明</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>婚姻状况证明</td>
				    <td colspan="2">&nbsp;</td>
				    <td>职业证明</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>经济收入及财政状况证明</td>
				    <td colspan="2">&nbsp;</td>
				    <td>身体健康检查证明</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>有无受过刑事处罚证明</td>
				    <td colspan="2">&nbsp;</td>
				    <td>家庭调查报告</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>心理评估报告</td>
				    <td colspan="2">&nbsp;</td>
				    <td>收养申请人所在国主管机关同意其跨国收养子女的证明</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>家庭生活照片</td>
				    <td colspan="2">&nbsp;</td>
				    <td>推荐信</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				</table>
				
				<!-- 如果有预批信息 -->
				
				<table width="100%" border="1">
				  <tr>
				    <td colspan="6" align="center">预批锁定儿童基本信息</td>
				  </tr>
				  <tr>
				    <td width="19%">省份</td>
				    <td width="26%">&nbsp;</td>
				    <td width="14%">福利院</td>
				    <td colspan="2">&nbsp;</td>
				    <td rowspan="5">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>姓名</td>
				    <td>&nbsp;</td>
				    <td>性别</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>出生日期</td>
				    <td>&nbsp;</td>
				    <td>特别关注</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>病残种类</td>
				    <td>&nbsp;</td>
				    <td>病残程度</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>文件递交期限</td>
				    <td>&nbsp;</td>
				    <td>有无同胞</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>病残诊断</td>
				    <td colspan="5">&nbsp;</td>
				  </tr>
				  <tr>
				    <td colspan="6" align="center">预批审核信息</td>
				  </tr>
				  <tr>
				    <td>审核级别</td>
				    <td>&nbsp;</td>
				    <td>审核时间</td>
				    <td width="15%">&nbsp;</td>
				    <td width="14%">审核人</td>
				    <td width="12%">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>审核结果</td>
				    <td>&nbsp;</td>
				    <td>审核意见</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>审核级别</td>
				    <td>&nbsp;</td>
				    <td>审核时间</td>
				    <td>&nbsp;</td>
				    <td>审核人</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td>审核结果</td>
				    <td>&nbsp;</td>
				    <td>审核意见</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td>审核级别</td>
				    <td>&nbsp;</td>
				    <td>审核时间</td>
				    <td>&nbsp;</td>
				    <td>审核人</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td>审核结果</td>
				    <td>&nbsp;</td>
				    <td>审核意见</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				</table>
			</div>
			<div id="tab2">
				<h2>JS for these tabs</h2>
			</div>
			<div id="tab3">
				<h2>CSS Styles for these tabs</h2>
			</div>
			<div id="tab4">
				<h2>CSS Styles for these tabs</h2>
			</div>
			<div id="tab5">
				<h2>CSS Styles for these tabs</h2>
			</div>
			<div id="tab6">
				
			</div>
		</div>
	</div>
	<!-- 审核信息 -->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					审核情况
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<!-- 编辑区域 开始 -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">公认证情况：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REGISTER_DATE" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">翻译单位：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_NO" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">翻译质量：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue=""/>
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">审核结果：</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_CONVENTION_ADOPT" checkValue="0=否;1=是" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">审核人：</td>
						<td class="bz-edit-data-value"><BZ:dataValue field="IS_CONVENTION_ADOPT" checkValue="0=否;1=是" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">审核日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">审核意见：</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea style="height: 60px;width: 97%;"></textarea>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">备注：</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea style="height: 60px;width: 97%;"></textarea>
						</td>
					</tr>
				</table>
				<!-- 编辑区域 结束 -->
			</div>
		</div>
	</div>
	</BZ:form>
</BZ:body>
</BZ:html>
