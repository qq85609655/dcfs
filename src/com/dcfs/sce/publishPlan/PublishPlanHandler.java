/**   
 * @Title: FileAuditHandler.java 
 * @Package com.dcfs.ffs.audit 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 ����5:10:43 
 * @version V1.0   
 */
package com.dcfs.sce.publishPlan;

import java.sql.Connection;
import java.util.Map;

import com.sun.corba.se.spi.ior.Identifiable;

import java_cup.internal_error;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: FileAuditHandler 
 * @Description: TODO(������һ�仰��������������) 
 * @author songhn@21softech.com 
 * @date 2014-7-14 ����5:10:43 
 *  
 */
public class PublishPlanHandler extends BaseHandler {

	public PublishPlanHandler() {
	}

	public PublishPlanHandler(String propFileName) {
		super(propFileName);
	}
	
	
	/**
	 * �����ƻ��б�	
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList findListForFBJH(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����

		String PLAN_NO = data.getString("PLAN_NO", null);	//�ƻ�����
		String NOTE_DATE_START = data.getString("NOTE_DATE_START", null);	//Ԥ������
		String NOTE_DATE_END = data.getString("NOTE_DATE_END", null);	//Ԥ������
		String PUB_DATE_START = data.getString("PUB_DATE_START", null);	//��������
		String PUB_DATE_END = data.getString("PUB_DATE_END", null);	//��������
		String PLAN_USERNAME = data.getString("PLAN_USERNAME", null);	//�ƶ�������
		String PLAN_DATE_START = data.getString("PLAN_DATE_START", null);	//�ƶ�����
		String PLAN_DATE_END = data.getString("PLAN_DATE_END", null);	//�ƶ�����
		String NOTICE_STATE = data.getString("NOTICE_STATE", null);	//Ԥ��״̬
		String PLAN_STATE = data.getString("PLAN_STATE", null);	//�ƻ�״̬
		
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findListForFBJH",PLAN_NO, NOTE_DATE_START, NOTE_DATE_END, PUB_DATE_START,PUB_DATE_END,PLAN_USERNAME, PLAN_DATE_START, PLAN_DATE_END, NOTICE_STATE, PLAN_STATE, compositor, ordertype);
		//System.out.println("sql---->"+sql);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * ��������ͯѡ���б�	
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList toChoseETForJH(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����

		String PROVINCE_ID = data.getString("PROVINCE_ID", null);	//ʡ��
		String WELFARE_ID = data.getString("WELFARE_ID", null);	//����Ժ
		String NAME = data.getString("NAME", null);	//����
		String SEX = data.getString("SEX", null);	//�Ա�
		String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);	//��������
		String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);	//��������
		String SN_TYPE = data.getString("SN_TYPE", null);	//��������
		String SPECIAL_FOCUS = data.getString("SPECIAL_FOCUS", null);	//�ر��ע
		String PUB_NUM = data.getString("PUB_NUM", null);	//��������
		String PUB_FIRSTDATE_START = data.getString("PUB_FIRSTDATE_START", null);	//�״η�������
		String PUB_FIRSTDATE_END = data.getString("PUB_FIRSTDATE_END", null);	//�״η�������
		String PUB_LASTDATE_START = data.getString("PUB_LASTDATE_START", null);	//ĩ�η�������
		String PUB_LASTDATE_END = data.getString("PUB_LASTDATE_END", null);	//ĩ�η�������
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("toChoseETForJH",PROVINCE_ID, WELFARE_ID, NAME, SEX,BIRTHDAY_START,BIRTHDAY_END, SN_TYPE, SPECIAL_FOCUS, PUB_NUM, PUB_FIRSTDATE_START, PUB_FIRSTDATE_END, PUB_LASTDATE_START, PUB_LASTDATE_END, compositor, ordertype);
		//System.out.println("toChoseETForFBSql---->"+sql);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * ��ѯ�����ƻ�����ѡ��Ķ�ͯ�б�
	 * @description 
	 * @author MaYun
	 * @date Sep 28, 2014
	 * @return
	 */
	public DataList findSelectedET(Connection conn,String ciids) throws DBException{
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findSelectedET",ciids);
		//System.out.println("toChoseETForFBSql---->"+sql);
		DataList dl = ide.find(sql);
        return dl;
	}
	
	
	/**
	 * ���ݶ�ͯ����IDS�ͷ���״̬���������¶�ͯ��Ϣ��ķ���״̬
	 * @description 
	 * @author MaYun
	 * @date Sep 28, 2014
	 * @param String ciids ��ʽΪ'a','b','c'
	 * @param String pub_state 0:������  1���ƻ���  2:�ѷ���  3:������  4:������
	 * @return
	 * @throws DBException 
	 */
	public void updatePubStateForET(Connection conn,String ciids,String pub_state) throws DBException{
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("updatePubStateForET",ciids,pub_state);
		ide.execute(sql);
	}
	
	
	/**
     * ���淢���ƻ���Ϣ
     * @author mayun
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data saveFbJhInfo(Connection conn, Map<String, Object> fbjhData) throws DBException {
        Data dataadd = new Data(fbjhData);
        String plan_id = dataadd.getString("PLAN_ID");
        dataadd.setConnection(conn);
        dataadd.setEntityName("SCE_PUB_PLAN");
        dataadd.setPrimaryKey("PLAN_ID");
        if("".equals(plan_id)||null==plan_id||"null".equals(plan_id)){
        	return dataadd.create();
        }else{
        	return dataadd.store();
        }
    }
    
    /**
     * �ж��Ƿ�����ƶ��µķ����ƻ�
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @return  false:������  true:����
     */
    public boolean isCanMakeNewPlan(Connection conn)throws DBException{
    	boolean flag = false;
    	
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("isCanMakeNewPlan");
		Data data = ide.find(sql).getData(0);
		int num = data.getInt("COUNT");
    	if(num>=1){
    		flag = false;
    	}else{
    		flag = true;
    	}
    	return flag;
    }
    
    /**
     * �ж��Ƿ����ɾ�������ƻ�
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @return  false:������  true:����
     */
    public boolean isCanDeletePlan(Connection conn,String plan_id)throws DBException{
    	boolean flag = false;
    	
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("isCanDeletePlan",plan_id);
		Data data = ide.find(sql).getData(0);
		String plan_state = data.getString("PLAN_STATE");
    	if("2".equals(plan_state)||"2"==plan_state){
    		flag = false;
    	}else{
    		flag = true;
    	}
    	return flag;
    }
    
    /**
     * �ж��Ƿ���Է����üƻ�
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @return  false:������  true:����
     */
    public boolean isCanPublishPlan(Connection conn,String plan_id)throws DBException{
    	boolean flag = false;
    	
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("isCanPublishPlan",plan_id);
		Data data = ide.find(sql).getData(0);
		int num = data.getInt("COUNT");
    	if(num==0){
    		flag = false;
    	}else{
    		flag = true;
    	}
    	return flag;
    }
    
    
    
    /**
     * ���·����ƻ���ķ���״̬Ϊ�ѷ���
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @return
     * @throws DBException 
     */
    public void updateFBStateForFBJH(Connection conn,String plan_id) throws DBException{
    	//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("updateFBStateForFBJH",plan_id);
		ide.execute(sql);
    }
    
    /**
     * ���·�����¼��ķ���״̬Ϊ�ѷ���
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @param String userId
     * @param String userName
     * @param String plan_id
     * @return
     * @throws DBException 
     */
    public void updateFBStateForFBJL(Connection conn,String userId,String userName,String plan_id) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("updateFBStateForFBJL",userId,userName,plan_id);
		ide.execute(sql);
    }
    
    /**
     * ���¶�ͯ���ϵķ���״̬Ϊ�ѷ���
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @return
     * @throws DBException 
     */
    public void updateFBStateForETCL(Connection conn,DataList dataList) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
		
		for(int i=0;i<dataList.size();i++){
    		dataList.getData(i).setEntityName("CMS_CI_INFO");
    		dataList.getData(i).setPrimaryKey("CI_ID");
    	}
    	ide.batchStore(dataList);
    	
    }
    
    /**
     * ���ݷ����ƻ�����ID�õ����δ������Ķ�ͯ����
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @param String plan_id  �����ƻ�����ID
     * @return DataList ��ͯ����
     */
    public DataList getEtInfoListForFBJH(Connection conn,String plan_id) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getEtInfoListForFBJH",plan_id);
		return ide.find(sql);
    }
    
    /**
     * ���ݷ����ƻ�����ID�õ������ƻ���ϸ��Ϣ
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @param String plan_id  �����ƻ�����ID
     * @return Data �����ƻ���ϸ��Ϣ
     */
    public Data getFbDataForFBJH(Connection conn,String plan_id) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getFbDataForFBJH",plan_id);
		return ide.find(sql).getData(0);
    }
    
    /**
     * ɾ�������ƻ�
     * @description 
     * @author MaYun
     * @date Oct 10, 2014
     * @return
     * @throws DBException 
     */
    public void deletePlan(Connection conn,String plan_id) throws DBException {
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("deletePlan",plan_id);
		ide.execute(sql);
    }
    
    /**
     * ɾ��������¼
     * @description 
     * @author MaYun
     * @date Oct 10, 2014
     * @return
     * @throws DBException 
     */
    public void deleteFBJL(Connection conn,DataList dataList) throws DBException {
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
		for(int i=0;i<dataList.size();i++){
    		dataList.getData(i).setEntityName("SCE_PUB_RECORD");
    		dataList.getData(i).setPrimaryKey("PUB_ID");
    	}
		ide.remove(dataList);
    }
    
    
    /**
     * ���ӷ����ƻ�����ID�Ͷ�ͯ����ID��ɾ��������¼����ط�����¼��Ϣ
     * @description 
     * @author MaYun
     * @date Oct 15, 2014
     * @return
     */
    public void deleteFBJLForCIIDS(Connection conn,String plan_id,String ciids) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("deleteFBJLForCIIDS",plan_id,ciids);
		ide.execute(sql);
    }
   
    
    /**
     * ���ݷ����ƻ�����ID�õ����δ�������¼
     * @description 
     * @author MaYun
     * @date Oct 10, 2014
     * @return
     * @throws DBException 
     */
    public DataList getFBJLListForPlan(Connection conn,String plan_id) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getFBJLListForPlan",plan_id);
		return  ide.find(sql);
    }
	
    /**
     * ���·����ƻ���Ϣ
     * @description 
     * @author MaYun
     * @date Oct 15, 2014
     * @return
     */
    public void updateFBJH(Connection conn,Data data) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	data.setEntityName("SCE_PUB_PLAN");
    	data.setPrimaryKey("PLAN_ID");
		ide.store(data);
    }
    
    /**
	 * �õ�����һ����Ԥ��ķ����ƻ������Ϣ
	 * @description 
	 * @author MaYun
	 * @date Dec 9, 2014
	 * @return
	 */
	public Data getFBJHForYYG(Connection conn)throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("getFBJHForYYG");
    	Data data = new Data();
    	DataList dataList = ide.find(sql);
    	if(dataList.size()>0){
    		data = (Data)dataList.get(0);
    	}
    	return data;
    }
    
}
