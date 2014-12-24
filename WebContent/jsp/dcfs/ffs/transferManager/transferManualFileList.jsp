<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
    /**
     * @Description: 描述
     * @author xxx
     * @date 2014-7-30 21:14:53
     * @version V1.0
     */
    String compositor = (String) request.getAttribute("compositor");
    if (compositor == null) {
        compositor = "";
    }
    String ordertype = (String) request.getAttribute("ordertype");
    if (ordertype == null) {
        ordertype = "";
    }
    String code = (String) request.getAttribute("TRANSFER_CODE");
    //String TI_ID = (String)request.getAttribute("TI_ID");
    String mannualDeluuid = (String) request.getAttribute("mannualDeluuid");
    if ("null".equals(mannualDeluuid) || mannualDeluuid == null) {
        mannualDeluuid = "";
    }

    String sbcode = code.substring(0, 1);
    boolean tw_flag = false;
    if (sbcode != null && "5".equals(sbcode)) {
        tw_flag = true;
    }
%>
<BZ:html>
    <BZ:head>
        <title>查询列表</title>
        <BZ:webScript list="true" isAjax="true"/>
        <script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
    </BZ:head>
    <script type="text/javascript">

        $(document).ready(function () {
            _findSyzzNameListForNew('S_COUNTRY_CODE', 'S_ADOPT_ORG_ID', 'S_HIDDEN_ADOPT_ORG_ID');

        });

        //显示查询条件
        function _showSearch() {
            $.layer({
                type: 1,
                title: "查询条件",
                shade: [0.5, '#D9D9D9', true],
                border: [2, 0.3, '#000', true],
                page: {dom: '#searchDiv'},
                area: ['900px', '210px'],
                offset: ['40px', '0px'],
                closeBtn: [0, true]
            });
        }

        function search() {
            document.srcForm.action = path + "transferManager/MannualFile.action";
            document.srcForm.submit();
        }

        function _isFilePause() {
            var num = 0;
            var chioceuuid = [];
            var arrays = document.getElementsByName("abc");
            for (var i = 0; i < arrays.length; i++) {
                if (arrays[i].checked) {
                    chioceuuid[num] = arrays[i].value;
                    num += 1;
                }
            }
            if (num < 1) {
                page.alert('请选择要添加移交的文件！');
                return;
            } else {
                var uuid = chioceuuid.join("#");
                var TID_IDS = uuid;
                $.ajax({
                    url: path + 'AjaxExecute?className=com.dcfs.ffs.transferManager.TransferManagerAjax2&method=isFilePause',
                    type: 'POST',
                    data: {'TID_IDS': TID_IDS},
                    dataType: 'json',
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("错误信息：" + XMLHttpRequest + ":" + textStatus + ":" + errorThrown);
                    },
                    success: function (data) {
                        if (data.IS_PAUSE == "1") {
                            alert("文件编号为【" + data.FILE_NO + "】的文件已暂停，无法进行移交操作！");
                            return;
                        } else {
                            _choice(uuid);
                        }
                    }
                });
            }
        }

        function _choice(uuid) {
            if (confirm("确定移交这些文件？")) {
                opener.refreshLocalList(uuid);
                window.close();
            }
        }


        //重置方法自由定义
        function _reset() {
            $("#S_COUNTRY_CODE").val("");
            $("#S_ADOPT_ORG_ID").val("");
            $("#S_REGISTER_DATE_START").val("");
            $("#S_REGISTER_DATE_END").val("");
            $("#S_FILE_NO").val("");
            $("#S_FILE_TYPE").val("");
            $("#S_MALE_NAME").val("");
            $("#S_FEMALE_NAME").val("");
            $("#S_HANDLE_TYPE").val("");
        }


    </script>
    <BZ:body property="data" codeNames="WJLX;GJSY;SYS_GJSY_CN;SYZZ;TWCZFS_ALL;TWLX">
        <BZ:form name="srcForm" method="post" action="transferManager/MannualFile.action">
            <input type="hidden" name="TRANSFER_CODE" id="TRANSFER_CODE" value="<%=code%>"/>
            <input type="hidden" name="chioceuuid" id="chioceuuid" value=""/>
            <input type="hidden" name="mannualDeluuid" id="mannualDeluuid" value="<%=mannualDeluuid %>"/>
            <!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
            <input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
            <input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>

            <div class="page-content">
                <BZ:frameDiv property="clueTo" className="kuangjia">
                </BZ:frameDiv>
                <!-- 查询条件区Start -->
                <div class="table-row" id="searchDiv" style="display: none">
                    <table cellspacing="0" cellpadding="0">
                        <tr>
                            <td style="width: 100%;">
                                <table>
                                    <tr>
                                        <td class="bz-search-title" style="width: 10%"><span title="国家">国家</span></td>
                                        <td style="width: 18%">
                                            <BZ:select field="COUNTRY_CODE" formTitle=""
                                                       prefix="S_" isCode="true" codeName="SYS_GJSY_CN" width="148px"
                                                       onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
                                                <option value="">
                                                    --请选择--
                                                </option>
                                            </BZ:select>
                                        </td>
                                        <td class="bz-search-title" style="width: 10%"><span title="收养组织">收养组织</span>
                                        </td>
                                        <td style="width: 18%">
                                            <BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID"
                                                       notnull="请输入收养组织" formTitle="" width="148px"
                                                       onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
                                                <option value="">--请选择--</option>
                                            </BZ:select>
                                            <input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID"
                                                   value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
                                        </td>
                                        <td class="bz-search-title" style="width: 10%"><span title="收文日期">收文日期</span>
                                        </td>
                                        <td style="width: 18%">
                                            <BZ:input prefix="S_" field="REGISTER_DATE_START" type="Date"
                                                      dateFormat="yyyy-MM-dd" defaultValue="" id="S_REGISTER_DATE_START"
                                                      dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true"
                                                      formTitle="起始提交日期"/>~
                                            <BZ:input prefix="S_" field="REGISTER_DATE_END" type="Date"
                                                      dateFormat="yyyy-MM-dd" defaultValue="" id="S_REGISTER_DATE_END"
                                                      dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true"
                                                      formTitle="截止提交日期"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="bz-search-title" style="width: 10%"><span title="文件编号">文件编号</span>
                                        </td>
                                        <td style="width: 18%">
                                            <BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue=""
                                                      formTitle="文件编号" restriction="hasSpecialChar" maxlength="50"/>
                                        </td>
                                        <td class="bz-search-title" style="width: 10%"><span title="文件类型">文件类型</span>
                                        </td>
                                        <td style="width: 18%">
                                            <BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true"
                                                       codeName="WJLX" formTitle="文件类型" defaultValue=""><BZ:option
                                                    value="">--请选择--</BZ:option></BZ:select>
                                        </td>
                                        <td class="bz-search-title" style="width: 10%"></td>
                                        <td style="width: 18%">

                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="bz-search-title" style="width: 10%"><span title="男收养人">男收养人</span>
                                        </td>
                                        <td style="width: 18%">
                                            <BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue=""
                                                      formTitle="男收养人姓名" restriction="hasSpecialChar" maxlength="150"/>
                                        </td>
                                        <td class="bz-search-title" style="width: 10%"><span title="女收养人">女收养人</span>
                                        </td>
                                        <td style="width: 18%">
                                            <BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue=""
                                                      formTitle="男收养人姓名" restriction="hasSpecialChar" maxlength="150"/>
                                        </td>

                                        <td class="bz-search-title" style="width: 10%"> <%if (tw_flag) {%>退文处置方式<%} %></td>
                                        <td style="width: 18%">
                                            <%if (tw_flag) {%>
                                            <BZ:select prefix="S_" field="HANDLE_TYPE" id="S_HANDLE_TYPE" isCode="true"
                                                       codeName="TWCZFS_ALL" formTitle="退文处置方式"
                                                       defaultValue=""><BZ:option
                                                    value="">--请选择--</BZ:option></BZ:select>
                                            <%} %>
                                        </td>

                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 5px;"></tr>
                        <tr>
                            <td style="text-align: center;">
                                <div class="bz-search-button">
                                    <input type="button" value="搜&nbsp;&nbsp;索" onclick="search();"
                                           class="btn btn-sm btn-primary">
                                    <input type="button" value="重&nbsp;&nbsp;置" onclick="_reset();"
                                           class="btn btn-sm btn-primary">
                                </div>
                            </td>
                            <td class="bz-search-right"></td>
                        </tr>
                    </table>
                </div>
                <!-- 查询条件区End -->
                <div class="wrapper">
                    <!-- 功能按钮操作区Start -->
                    <div class="table-row table-btns" style="text-align: left">
                        <input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary"
                               onclick="_showSearch()"/>&nbsp;
                        <input type="button" value="选&nbsp;&nbsp;择" class="btn btn-sm btn-primary"
                               onclick="_isFilePause()"/>
                    </div>
                    <div class="blue-hr"></div>
                    <!-- 功能按钮操作区End -->


                    <!--查询结果列表区Start -->
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover dataTable" adsorb="both"
                               init="true" id="sample-table">
                            <thead>
                            <tr>
                                <th class="center" style="width:2%;" nowrap>
                                    <div class="sorting_disabled"><input name="abcd" type="checkbox" class="ace"></div>
                                </th>
                                <th style="width:5%;" nowrap>
                                    <div class="sorting_disabled">序号</div>
                                </th>
                                <th style="width:5%;" nowrap>
                                    <div class="sorting" id="COUNTRY_CN">国家</div>
                                </th>
                                <th style="width:10%;" nowrap>
                                    <div class="sorting" id="NAME_CN">收养组织</div>
                                </th>
                                <th style="width:5%;" nowrap>
                                    <div class="sorting" id="REGISTER_DATE">收文日期</div>
                                </th>
                                <th style="width:10%;" nowrap>
                                    <div class="sorting" id="FILE_NO">文件编号</div>
                                </th>
                                <th style="width:5%;" nowrap>
                                    <div class="sorting" id="FILE_TYPE">文件类型</div>
                                </th>
                                <th style="width:10%;" nowrap>
                                    <div class="sorting" id="MALE_NAME">男收养人</div>
                                </th>
                                <th style="width:10%;" nowrap>
                                    <div class="sorting" id="FEMALE_NAME">女收养人</div>
                                </th>
                                <%if ("13".equals(code)) { %>
                                <th style="width:5%;" nowrap>
                                    <div class="sorting" id="NAME">特需儿童姓名</div>
                                </th>
                                <%} %>
                                <%if (tw_flag) { %>
                                <th style="width:5%;" nowrap>
                                    <div class="sorting" id="HANDLE_TYPE">处置方式</div>
                                </th>
                                <th style="width:5%;" nowrap>
                                    <div class="sorting" id="APPLE_TYPE">退文类型</div>
                                </th>
                                <th style="width:5%;" nowrap>
                                    <div class="sorting" id="RETREAT_DATE">确认日期</div>
                                </th>
                                <%} %>
                            </tr>
                            </thead>
                            <tbody>
                            <BZ:for property="List">
                                <tr class="emptyData">
                                    <td class="center">
                                        <input name="abc" type="checkbox"
                                               value="<BZ:data field="TID_ID" onlyValue="true"/>" class="ace">
                                    </td>
                                    <td class="center">
                                        <BZ:i/>
                                    </td>
                                    <td><BZ:data field="COUNTRY_CN" defaultValue="" onlyValue="true"/></td>
                                    <td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
                                    <td><BZ:data field="REGISTER_DATE" dateFormat="yyyy-MM-dd" defaultValue=""
                                                 type="date" onlyValue="true"/></td>
                                    <td><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
                                    <td><BZ:data field="FILE_TYPE" codeName="WJLX" defaultValue=""
                                                 onlyValue="true"/></td>
                                    <td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
                                    <td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
                                    <%if ("13".equals(code)) { %>
                                    <td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
                                    <%} %>
                                    <%if (tw_flag) { %>
                                    <td><BZ:data field="HANDLE_TYPE" codeName="TWCZFS_ALL" defaultValue=""
                                                 onlyValue="true"/></td>
                                    <td><BZ:data field="APPLE_TYPE" codeName="TWLX" defaultValue=""
                                                 onlyValue="true"/></td>
                                    <td><BZ:data field="RETREAT_DATE" dateFormat="yyyy-MM-dd" defaultValue=""
                                                 type="date" onlyValue="true"/></td>
                                    <%} %>
                                </tr>
                            </BZ:for>
                            </tbody>
                        </table>
                    </div>
                    <!--查询结果列表区End -->
                    <!--分页功能区Start -->
                    <div class="footer-frame">
                        <table border="0" cellpadding="0" cellspacing="0" class="operation">
                            <tr>
                                <td><BZ:page form="srcForm" property="List"/></td>
                            </tr>
                        </table>
                    </div>
                    <!--分页功能区End -->
                </div>
            </div>
        </BZ:form>
    </BZ:body>
</BZ:html>
