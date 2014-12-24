package com.hx.cms.channel;

import hx.common.Constants;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.Map;

import com.hx.cms.channel.vo.ChannelType;
import com.hx.cms.util.CmsAuthConstants;
import com.hx.cms.util.CmsConfigUtil;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.common.ClientIPGetter;
import com.hx.framework.organ.vo.Organ;
import com.hx.framework.sdk.AuditAppHelper;
import com.hx.framework.sdk.AuditConstants;

/**
 * 
 * @Title: ChannelTypeAction.java
 * @Description: 栏目类别<br>
 *               <br>
 * @Company: 21softech
 * @Created on Dec 10, 2010 11:19:42 AM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ChannelTypeAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(ChannelTypeAction.class);

	private ChannelTypeHandler handler;

	/**
	 * 初始化
	 */
	public ChannelTypeAction() {
		handler = new ChannelTypeHandler();
	}

	/**
	 * 分页查询
	 * @return
	 */
	public String query() {
		/*****排序及分页设置**********************/
		String compositor = getParameter("compositor");
		if (compositor == null || compositor.equals("")) {
			compositor = ChannelType.SEQ_NUM;
		}
		String ordertype = getParameter("ordertype");
		if (ordertype == null) {
			ordertype = "asc";
		}
		int pagesize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		/******逻辑编写部分***********************/
		Connection conn = null;
		DataList dataList = new DataList();
		UserInfo user = SessionInfo.getCurUser();
		try {
			conn = ConnectionManager.getConnection();
			
			if(CmsConfigUtil.is1nMode()){
            	//获取本单位
            	Organ organ = user.getCurOrgan0();
            	String orgLevelCode = null;
            	if(organ != null){
            		orgLevelCode = organ.getOrgLevelCode();
            	}
            	if(orgLevelCode != null && !"".equals(orgLevelCode)){
            		dataList = handler.findPageFor1nMode(conn, orgLevelCode, pagesize, page,compositor, ordertype);
            	}
            }else{
            	dataList = handler.findPage(conn, pagesize, page,compositor, ordertype);
            }
		} catch (Exception e) {
			log.logError("查询栏目类别时出错!", e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("查询栏目类别时关闭Connection出错!", e);
			}
		}
		// 存储
		setAttribute("dataList", dataList);
		setAttribute("compositor", compositor);
        setAttribute("ordertype", ordertype);
		return SUCCESS;
	}
	
	/**
     * 查询明细
     * 
     * @return
     */
    public String queryDetail() {

        // 编号ID
        String id = getParameter(ChannelType.ID);

        Connection conn = null;
        try {
            // 保存
            conn = ConnectionManager.getConnection();
            Data data = new Data();
            if (id != null && !"".equals(id.trim())) {
                // 账号
                data.setEntityName(ChannelType.CHANNEL_TYPE_ENTITY);
                data.setPrimaryKey(ChannelType.ID);
                data.add(ChannelType.ID, id);
                data = handler.findDataByKey(conn, data);
            }
            setAttribute("data", data);
        } catch (Exception e) {
            log.logError("查询栏目类别明细时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("查询栏目类别明细时出错!", e);
            }
        }

        // 跳转
        return getParameter("flag");
    }

    /**
     * 添加
     * 
     * @return 跳转页面
     */
    @SuppressWarnings("null")
	public String add() {

        // 获取表单数据
        Data data = fillData();

        Connection conn = null;
        DBTransaction db = null;
        UserInfo user = SessionInfo.getCurUser();
        try {
            // 保存
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            //加入组织ID
            Organ organ = user.getCurOrgan();
            String createDeptId = null;
            if(organ != null){
            	createDeptId = organ.getId();
            }
            data.add(ChannelType.CREATE_DEPT_ID, createDeptId);
            
            Data data1 = handler.add(conn, data);
            
            if(data1 != null){
                AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                        "",
                        AuditConstants.ACT_ADD,
                        CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL_TYPE,
                        data1.getString(ChannelType.NAME),
                        AuditConstants.ACT_RESULT_OK,
                        AuditConstants.AUDIT_LEVEL_5,"");
            }else{
                AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                        "",
                        AuditConstants.ACT_ADD,
                        CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL_TYPE,
                        data1.getString(ChannelType.NAME),
                        AuditConstants.ACT_RESULT_FAIL,
                        AuditConstants.AUDIT_LEVEL_5,"");
            }
            // 提交
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("添加栏目类别时出错!", e);
            }
            log.logError("添加栏目类别时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("添加栏目类别时出错!", e);
            }
        }

        // 跳转
        return "query";
    }

    /**
     * 删除
     * 
     * @return
     */
    @SuppressWarnings("null")
	public String delete() {

        // 获取数据值
        String id = getParameter(ChannelType.ID);

        Data data = new Data();
        data.setEntityName(ChannelType.CHANNEL_TYPE_ENTITY);
        data.setPrimaryKey(ChannelType.ID);
        data.add(ChannelType.ID, id);

        Connection conn = null;
        DBTransaction db = null;
        Data data1 = null;
        try {
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            data1 = handler.findDataByKey(conn, data);
            if(data1 != null){
                AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                        "",
                        AuditConstants.ACT_DELETE,
                        CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL_TYPE,
                        data1.getString(ChannelType.NAME),
                        AuditConstants.ACT_RESULT_OK,
                        AuditConstants.AUDIT_LEVEL_5,"");
            }else{
                AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                        "",
                        AuditConstants.ACT_DELETE,
                        CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL_TYPE,
                        data1.getString(ChannelType.NAME),
                        AuditConstants.ACT_RESULT_FAIL,
                        AuditConstants.AUDIT_LEVEL_5,"");
            }
            handler.delete(conn, data);
            db.commit();
        } catch (Exception e) {
            data1 = new Data();
            AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                    "",
                    AuditConstants.ACT_DELETE,
                    CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL_TYPE,
                    data1.getString(ChannelType.NAME),
                    AuditConstants.ACT_RESULT_FAIL,
                    AuditConstants.AUDIT_LEVEL_5,"");
            
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("删除栏目类别时出错!", e);
            }
            log.logError("删除栏目类别时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("删除栏目类别时出错!", e);
            }
        }

        return "query";
    }

    /**
     * 批量删除,参数名用IDS
     * 
     * @return
     */
    @SuppressWarnings("null")
	public String deleteBatch() {

        String idString = getParameter(ChannelType.IDS); 
        String[] ids = null;
        if (idString != null && !"".equals(idString.trim())) {
            ids = idString.split("#");
        }

        // 批量删除
        Connection conn = null;
        DBTransaction db = null;
        Data data1 = null;
        try {
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            // 构建批量删除对象集合
            if (ids != null) {
                for (String id : ids) {
                    Data data = new Data();
                    data.setEntityName(ChannelType.CHANNEL_TYPE_ENTITY);
                    data.setPrimaryKey(ChannelType.ID);
                    data.add(ChannelType.ID, id);
                    
                    data1 = handler.findDataByKey(conn, data);
                    if(data1 != null){
                        AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                                "",
                                AuditConstants.ACT_DELETE,
                                CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL_TYPE,
                                data1.getString(ChannelType.NAME),
                                AuditConstants.ACT_RESULT_OK,
                                AuditConstants.AUDIT_LEVEL_5,"");
                    }else{
                        AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                                "",
                                AuditConstants.ACT_DELETE,
                                CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL_TYPE,
                                data1.getString(ChannelType.NAME),
                                AuditConstants.ACT_RESULT_FAIL,
                                AuditConstants.AUDIT_LEVEL_5,"");
                    }
                    handler.delete(conn, data);
                }
            }
            db.commit();
        } catch (Exception e) {
            data1 = new Data();
            AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                    "",
                    AuditConstants.ACT_DELETE,
                    CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL_TYPE,
                    data1.getString(ChannelType.NAME),
                    AuditConstants.ACT_RESULT_FAIL,
                    AuditConstants.AUDIT_LEVEL_5,"");
            
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("批量删除栏目类别时出错!", e);
            }
            log.logError("批量删除栏目类别时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("批量删除栏目类别时出错!", e);
            }
        }

        return "query";
    }

    /**
     * 修改
     * 
     * @return
     */
    @SuppressWarnings("null")
	public String modify() {

        // 获取表单数据
        Data data = fillData();

        Connection conn = null;
        DBTransaction db = null;
        try {
            // 保存
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            Data data1 = handler.modify(conn, data);
            
            if(data1 != null){
                AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                        "",
                        AuditConstants.ACT_MODIFY,
                        CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL_TYPE,
                        data1.getString(ChannelType.NAME),
                        AuditConstants.ACT_RESULT_OK,
                        AuditConstants.AUDIT_LEVEL_5,"");
            }else{
                AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                        "",
                        AuditConstants.ACT_MODIFY,
                        CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL_TYPE,
                        data1.getString(ChannelType.NAME),
                        AuditConstants.ACT_RESULT_FAIL,
                        AuditConstants.AUDIT_LEVEL_5,"");
            }
            // 提交
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("修改栏目类别时出错!", e);
            }
            log.logError("修改栏目类别时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("修改栏目类别时关闭Connection出错!", e);
            }
        }

        // 跳转
        return "query";
    }

    /**
     * 未实现:默认调用查询(query)方法
     */
    public String execute() throws Exception {
        return query();
    }

    /*---------------------类private内部方法-----------------------*/

    /**
     * 填充表单数据到Data对象
     * 
     * @return
     */
    private Data fillData() {
        // 获取数据
        Data data = new Data();
        data.setEntityName(ChannelType.CHANNEL_TYPE_ENTITY);
        data.setPrimaryKey(ChannelType.ID);

        // 得到所有 栏目类别 参数前缀的键值集合
        Map<String, String> map = getDataWithPrefix(
        		ChannelType.CHANNEL_TYPE_PREFIX, false);
        if (map != null && !map.isEmpty()) {
            Iterator<String> keys = map.keySet().iterator();
            while (keys.hasNext()) {
                String key = (String) keys.next();
                String value = (String) map.get(key);
                data.add(key, value);
            }
        }
        return data;
    }
}
