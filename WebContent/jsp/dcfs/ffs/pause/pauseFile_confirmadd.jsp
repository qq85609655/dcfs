<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>文件暂停确认页面</title>
	<BZ:webScript edit="true" tree="false"/>
	<script>
	/*function startCheck(){
		alert("startcheck");
		stopInterv=setInterval(checkFunction, 1000); //每1秒执行一次
	}*/
	//文件暂停确认提交
	function _submit() {
		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			if (confirm("确定提交吗？提交后暂停确认信息不可修改！")) {
				document.srcForm.action = path + "ffs/pause/pauseFileSave.action";
				document.srcForm.submit();
				window.opener.open_tijiao();
			    window.close();
			}
		}
	}
	
/*function checkFunction(){
     try{
    	 alert("1");
	     window.opener.open_tijiao();
	     window.close();	
	     alert("2");
        clearInterval(stopInterv);
      }catch(e){
    	  alert("3");
   }
}*/

	
</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;SYZZ;WJWZ;WJQJZT_ZX" property="confirmData">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<BZ:input prefix="R_" field="AF_ID" type="hidden" defaultValue="" />
	<!-- 进度条begin -->
	<div class="stepflex" style="margin-right: 30px;">
        <dl id="payStepFrist" class="first done">
            <dt class="s-num">1</dt>
            <dd class="s-text" style="margin-left: -8px;">第一步：选择文件暂停</dd>
        </dl>
        <dl id="payStepNormal" class="normal doing">
            <dt class="s-num">2</dt>
            <dd class="s-text" style="margin-left: -8px;">第二步：录入暂停原因<s></s>
                <b></b>
            </dd>
        </dl>
        <dl id="payStepLast" class="last">
            <dt class="s-num">3</dt>
            <dd class="s-text" style="margin-left: -8px;">第三步：提交<s></s>
                <b></b>
            </dd>
        </dl>
	</div>
	<!-- 进度条end -->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>文件基本信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">收文编号</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">收文日期</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">文件类型</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">男收养人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">女收养人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">文件位置</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AF_POSITION" codeName="WJWZ" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">国家</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
						</td>
						<td class="bz-edit-data-title">收养组织</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">文件状态</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AF_GLOBAL_STATE" codeName="WJQJZT_ZX" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
			<!-- 内容区域 end -->
		</div>
	</div>
	<br>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					文件暂停信息
				</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">暂停部门</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAUSE_UNITNAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="PAUSE_UNITID" type="hidden" defaultValue=""/>
							<BZ:input prefix="R_" field="PAUSE_UNITNAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">暂停人</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAUSE_USERNAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="PAUSE_USERID" type="hidden" defaultValue=""/>
							<BZ:input prefix="R_" field="PAUSE_USERNAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">暂停日期</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAUSE_DATE" type="date" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="PAUSE_DATE" type="hidden" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">暂停期限</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:input field="END_DATE" id="R_END_DATE" prefix="R_" type="date"/>
						</td>
						<td class="bz-edit-data-title poptitle"><font color="red">*</font>暂停原因</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:input field="PAUSE_REASON" id="R_PAUSE_REASON" type="textarea" prefix="R_" formTitle="暂停原因" defaultValue="" notnull="请输入暂停原因" style="width:75%" maxlength="1000"/>
						</td>
					</tr>
				</table>
			</div>
			<!-- 内容区域 end -->
		</div>
	</div>
	<br/>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="关闭" class="btn btn-sm btn-primary" onclick="javascript:window.close();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
