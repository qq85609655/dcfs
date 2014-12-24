package com.hx.cms.channel;

import hx.code.Code;
import hx.code.CodeList;
import hx.code.UtilCode;
import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.hx.cms.channel.vo.Channel;
import com.hx.framework.role.vo.Role;

/**
 * 
 * @Title: ChannelHandler.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on Dec 10, 2010 3:16:45 PM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ChannelHandler extends BaseHandler{
	
	private IDataExecute ide;

	/**
	 * 添加
	 * @param data
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public Data add(Connection conn, Data data) throws Exception{
		ide = DataBaseFactory.getDataBase(conn);
		return ide.create(data);
	}

	/**
	 * 分页查询
	 * @param conn
	 * @param pageSize
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public DataList findPage(Connection conn, int pageSize, int page) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.find(getSql("findChannelTypeSQL"), pageSize, page);
	}
	
	/**
	 * 查找指定父ID的所有子栏目
	 * @param conn
	 * @param data
	 * @return
	 * @throws Exception
	 */
	public DataList findChannelsOfParent(Connection conn, Data data) throws Exception{
	    ide = DataBaseFactory.getDataBase(conn);
        return ide.find("SELECT * FROM CMS_CHANNEL WHERE PARENT_ID = '"+data.getString(Channel.PARENT_ID)+"' ORDER BY SEQ_NUM");
	}

	/**
	 * 根据主键查询
	 * @param conn
	 * @param data
	 * @return
	 * @throws Exception 
	 */
	public Data findDataByKey(Connection conn, Data data) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.findByPrimaryKey(data);
	}
	
	/**
	 * 删除
	 * @param conn
	 * @param data
	 * @throws Exception 
	 */
	public void delete(Connection conn, Data data) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		ide.remove(data);
	}

	/**
	 * 批量删除
	 * @param conn
	 * @param dataList
	 * @throws Exception 
	 */
	public void deleteBatch(Connection conn, DataList dataList) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		ide.remove(dataList);
	}

	/**
	 * 修改
	 * @param conn
	 * @param data
	 * @throws Exception 
	 */
	public Data modify(Connection conn, Data data) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.store(data);
	}
	
	public void modifyPath(Connection conn, Data data) throws Exception {
	    ide = DataBaseFactory.getDataBase(conn);
	    String id = data.getString("ID");//被移动蓝栏目ID
        Data data1 = new Data();
        data1.setEntityName(Channel.CHANNEL_ENTITY);
        data1.setPrimaryKey(Channel.ID);
        data1.add(Channel.ID, id);
        data1 = findDataByKey(conn, data1);
        String oldPath = data1.getString("CHANNEL_PATH");//被移动栏目未移动时的CHANNEL_PATH即移动后需修改为新的CHANNEL_PATH，新的CHANNEL_PATH为目标栏目的CHANNEL_PATH+其本身的ID
        String parentId = data.getString("PARENT_ID");//目标栏目ID即被移动栏目的新PARENT_ID
        String newPath = "";
        if("0".equals(parentId)){
            newPath = id;
        }else{
            Data data2 = new Data();
            data2.setEntityName(Channel.CHANNEL_ENTITY);
            data2.setPrimaryKey(Channel.ID);
            data2.add(Channel.ID, parentId);
            data2 = findDataByKey(conn, data2);
            newPath = data2.getString("CHANNEL_PATH") + "," + id;
        }
        String sql = getSql("updateChannelPath", oldPath,newPath);
        ide.execute(sql);
    }

	/**
	 * 生成栏目树
	 * @param conn
	 * @return
	 */
	public CodeList generateTree(Connection conn) {
		CodeList codeList = new CodeList();
        codeList = UtilCode.getCodeListBySql(conn, getSql("generateChannelTreeSQL"));
        return codeList;
	}

	/**
	 * 查找对应
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public DataList findChannelChildren(Connection conn, Data data,
			int pageSize, int page, String orderString) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.find(getSql("findChannelChildren",data.getString(Channel.PARENT_ID),orderString), pageSize, page);
	}

	/**
	 * 统计子栏目个数
	 * @param conn
	 * @param parentId
	 * @return
	 * @throws Exception 
	 */
	public int statChildren(Connection conn, String parentId) throws Exception {
        int num = 0;
        ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = ide.find(getSql("statChildrenSQL",new Object[]{Channel.ID, Channel.CHANNEL_ENTITY, Channel.PARENT_ID, parentId}));
        if(dataList != null && dataList.size() > 0){
            num = dataList.getData(0).getInt(Channel.COUNT_NUM);
        }
        return num;
	}

	/**
	 * 栏目树
	 * @param conn
	 * @return
	 */
	public CodeList findChannelToCodeList(Connection conn) {
		return UtilCode.getCodeListBySql(conn, getSql("findChannelToCodeListSQL"));
	}
	
	/**
	 * 查询业务培训
	 * @param conn
	 * @param catalog
	 * @return
	 * @throws DBException
	 */
	public DataList findYWPX(Connection conn) throws Exception {
        ide = DataBaseFactory.getDataBase(conn);
        return ide.find(getSql("findAllCatalog"));
    }
	
	/**
	 * 根据Data查询
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public DataList findData(Connection conn, Data data) throws Exception {
	    ide = DataBaseFactory.getDataBase(conn);
	    return ide.find(data);
	}
	
	/**
	 * 根据Data查询
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public DataList findDataBySQL(Connection conn, Data data) throws Exception {
	    ide = DataBaseFactory.getDataBase(conn);
	    System.out.println(getSql("findDataBySQL",data.getString(Channel.PARENT_ID),data.getString(Channel.SEQ_NUM)));
	    return ide.find(getSql("findDataBySQL",data.getString(Channel.PARENT_ID),data.getString(Channel.SEQ_NUM)));
	}
	
	/**
	 * 查询角色拥有的栏目列表
	 * @param conn
	 * @param roleId
	 * @return
	 * @throws Exception
	 */
	public CodeList findChannelsOfRole(Connection conn, String roleId) throws Exception {
		CodeList codeList = new CodeList();
		//System.out.println(getSql("findChannelsOfRoleBySQL",roleId));
        codeList = UtilCode.getCodeListBySql(conn, getSql("findChannelsOfRoleBySQL",roleId));
        return codeList;
    }
	
	/**
	 * 查询人员拥有的栏目列表
	 * @param conn
	 * @param personId
	 * @return
	 */
	public CodeList findChannelsOfPerson(Connection conn, String personId, String role) {
		CodeList codeList = new CodeList();
		codeList = UtilCode.getCodeListBySql(conn, getSql("findChannelsOfPersonBySQL", personId, role));
		return codeList;
	}
	
	public CodeList findChannelsOfPerson2(Connection conn, String personId, String role) {
		CodeList codeList = new CodeList();
		codeList = UtilCode.getCodeListBySql(conn, getSql("findChannelsOfPerson2BySQL", personId, role));
		return codeList;
	}
	
	/**
	 * 查询角色拥有的栏目列表
	 * @param conn
	 * @param roleId
	 * @return
	 * @throws Exception
	 */
	public CodeList findChannelsOfRole(Connection conn, List<Role> roles) throws Exception {
		CodeList codeList = new CodeList();
		
		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i < roles.size(); i++) {
			Role role = roles.get(i);
			if(i == (roles.size() - 1)){
				buffer.append("ROLE_ID = '").append(role.getRoleId()).append("'");
			}else{
				buffer.append("ROLE_ID = '").append(role.getRoleId()).append("' OR ");
			}
		}
		//System.out.println(getSql("findChannelsOfRoleBySQL",buffer.toString()));
        codeList = UtilCode.getCodeListBySql(conn, getSql("findChannelsOfRoleBySQL",buffer.toString()));
        //移除重复值保留原顺序
        return removeDuplicateWithOrder(codeList);
    }
	
	/**
	 * 去除List中重复值但保留原来顺序
	 * @param arlList
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static CodeList removeDuplicateWithOrder(CodeList codeList){    
		Set set = new HashSet();    
		CodeList newList = new CodeList();
		System.out.println(codeList.size()+":原");
		for (Iterator iter = codeList.iterator(); iter.hasNext(); ){
			Object element = iter.next();    
			if (set.add(element)){
				newList.add((Code) element);
			}
		}
		System.out.println(newList.size()+":原");
		return newList;
	}

	public DataList findChannelChildrenFor1nMode(Connection conn, Data data,
			String orgLevelCode, int pageSize, int page, String orderString) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.find(getSql("findChannelChildrenFor1nMode",data.getString(Channel.PARENT_ID),orgLevelCode,orderString), pageSize, page);
	}

	public CodeList generateTreeFor1nMode(Connection conn, String orgLevelCode) {
		CodeList codeList = new CodeList();
        codeList = UtilCode.getCodeListBySql(conn, getSql("generateChannelTreeFor1nModeSQL",orgLevelCode));
        return codeList;
	}

    public DataList getChannels(Connection conn, String channel) throws DBException {
        ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getChannels", channel);
        DataList dl = ide.find(sql);
        return dl;
    }

    public void deleteChannels(Connection conn, String id) throws DBException {
        ide=DataBaseFactory.getDataBase(conn);
        ide.remove("CMS_CHANNEL", "CHANNEL_PATH like '%"+id+"%'");
        
    }

    
}
