/**   
 * @Title: FileAuditHandler.java 
 * @Package com.dcfs.ffs.audit 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 ����5:10:43 
 * @version V1.0   
 */
package com.dcfs.sce.publishManager;

import java.sql.Connection;
import java.util.Map;

import com.dcfs.common.StringUtil;

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
public class PublishManagerHandler extends BaseHandler {

	public PublishManagerHandler() {
	}

	public PublishManagerHandler(String propFileName) {
		super(propFileName);
	}
	


	
	
	
	
	
	/**
	 * ���������б�	
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList findListForFBGL(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����

		String PROVINCE_ID = data.getString("PROVINCE_ID", null);	//ʡ��
		String WELFARE_ID = data.getString("WELFARE_ID", null);	//����Ժ
		String NAME = data.getString("NAME", null);	//����
		String SEX = data.getString("SEX", null);	//�Ա�
		String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);	//��������
		String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);	//��������
		String SPECIAL_FOCUS = data.getString("SPECIAL_FOCUS", null);	//�ر��ע
		String SN_TYPE = data.getString("SN_TYPE", null);	//��������
		String PUB_FIRSTDATE_START = data.getString("PUB_FIRSTDATE_START", null);	//�״η�������
		String PUB_FIRSTDATE_END = data.getString("PUB_FIRSTDATE_END", null);	//�״η�������
		String PUB_LASTDATE_START = data.getString("PUB_LASTDATE_START", null);	//ĩ�η�������
		String PUB_LASTDATE_END = data.getString("PUB_LASTDATE_END", null);	//ĩ�η�������
		String PUB_TYPE = data.getString("PUB_TYPE", null);	//��������
		String PUB_ORGID = data.getString("PUB_ORGID", null);	//������֯
		String PUB_MODE = data.getString("PUB_MODE", null);	//�㷢����
		String SETTLE_DATE_START = data.getString("SETTLE_DATE_START", null);	//��������
		String SETTLE_DATE_END = data.getString("SETTLE_DATE_END", null);	//��������
		String PUB_STATE = data.getString("PUB_STATE", null);	//����״̬
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID2", null);	//������֯
		String LOCK_NUM = data.getString("LOCK_NUM", null);	//��������
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START", null);	//��������
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_START_END", null);	//��������
		String RI_STATE = data.getString("RI_STATE", null);	//Ԥ��״̬
		String DISEASE_CN = data.getString("DISEASE_CN", null);	//�������
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findListForFBGL",PROVINCE_ID, WELFARE_ID, NAME, SEX,BIRTHDAY_START,BIRTHDAY_END, SPECIAL_FOCUS, SN_TYPE, PUB_FIRSTDATE_START, PUB_FIRSTDATE_END,PUB_LASTDATE_START,PUB_LASTDATE_END, PUB_TYPE, PUB_ORGID, PUB_MODE,SETTLE_DATE_START,SETTLE_DATE_END,PUB_STATE,ADOPT_ORG_ID,LOCK_NUM,SUBMIT_DATE_START,SUBMIT_DATE_END,RI_STATE,DISEASE_CN, compositor, ordertype);
		//System.out.println("sql---->"+sql);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	
	/**
	 * �ѷ�����֯�б�	
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList findListForFBORG(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����

		String PUB_ID = data.getString("PUB_ID", null);	//������¼ID
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����
		String PUB_ORGID = data.getString("PUB_ORGID", null);	//������֯
		
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sqlOrgIDs=getSql("getFbOrgIdsForFBGL",PUB_ID);
		String orgIds = ide.find(sqlOrgIDs).getData(0).getString("PUB_ORGID");
		orgIds = StringUtil.convertSqlString(orgIds);
		
		
		String sql = getSql("findListForFBORG",orgIds, COUNTRY_CODE, PUB_ORGID, compositor, ordertype);
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
	public DataList toChoseETForFB(Connection conn, Data data, int pageSize,
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
		String sql = getSql("toChoseETForFB",PROVINCE_ID, WELFARE_ID, NAME, SEX,BIRTHDAY_START,BIRTHDAY_END, SN_TYPE, SPECIAL_FOCUS, PUB_NUM, PUB_FIRSTDATE_START, PUB_FIRSTDATE_END, PUB_LASTDATE_START, PUB_LASTDATE_END, compositor, ordertype);
		//System.out.println("toChoseETForFBSql---->"+sql);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * �����Ƿ�Ⱥ�����Ƿ��ر��ע���㷢���ͻ�ð�������
	 * @description 
	 * @author MaYun
	 * @date Sep 17, 2014
	 * @return
	 */
	public DataList getAZQXInfo(Connection conn,String oneType,String secondType,String threeType) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getAZQXInfo",oneType,secondType,threeType);
		//System.out.println("sql000000-->"+sql);
		return ide.find(sql);
	}
	
	
	/**
	 * ���ݷ�����¼����ID�жϸķ���״̬�Ƿ�Ϊ�ѷ���
	 * @description 
	 * @author MaYun
	 * @date Sep 17, 2014
	 * @return
	 */
	public Boolean isFB(Connection conn,String pub_id) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("isFB",pub_id);
		String state = ide.find(sql).getData(0).getString("PUB_STATE");
		if("2".equals(state)||"2"==state){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * ���ݷ�����¼����ID�жϸ��˻�״̬�Ƿ�Ϊ�������˻ػ��˻�ȷ��
	 * @description 
	 * @author MaYun
	 * @date Sep 17, 2014
	 * @return
	 */
	public Boolean isTH(Connection conn,String pub_id) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("isTH",pub_id);
		String state = ide.find(sql).getData(0).getString("RETURN_STATE");
		if("".equals(state)||""==state||null==state){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * ���ݷ�����¼����ID�жϸ�����״̬�Ƿ�Ϊ������,����Ԥ��������δ�ݽ�
	 * @description 
	 * @author MaYun
	 * @date Sep 17, 2014
	 * @return
	 */
	public Boolean isSD(Connection conn,String pub_id) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("isSD",pub_id);
		DataList dataList = ide.find(sql);
		
		if(dataList.size()>0){
			Data data = dataList.getData(0);
			String LOCK_STATE= data.getString("LOCK_STATE");//����״̬  0:������
			String RI_STATE= data.getString("RI_STATE");//Ԥ��״̬ 0:δ�ݽ�
			if("0".equals(LOCK_STATE)||"0"==LOCK_STATE){
				if("0".equals(RI_STATE)||"0"==RI_STATE){
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		}else{
			return false;
		}
		
	}
	
	/**
     * ��ͯ���������ύ����
     * @param conn
     * @param datalist
     * @return
     * @throws DBException
     */
    public boolean batchSubmitForETFB(Connection conn, DataList datalist)throws DBException {
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	for(int i=0;i<datalist.size();i++){
    		datalist.getData(i).setEntityName("SCE_PUB_RECORD");
    		datalist.getData(i).setPrimaryKey("PUB_ID");
    	}
    	int re =ide.batchCreate(datalist);
    	if(re>0){
    		return true;
    	}else{
    		return false;
    	}
    }
    
    /**
     * ���ݶ�ͯ����ID,�ж��Ƿ���й���������
     * @description 
     * @author MaYun
     * @date Sep 18, 2014
     * @param Connection conn
     * @param String ciid ��ͯ����ID
     * @return true:���й�  false:û��
     * @throws DBException 
     */
    public boolean isFirstFb(Connection conn,String ciid) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("isFirstFb",ciid);
    	DataList dataList = ide.find(sql);
    	if(dataList.size()>0){
    		return true;
    	}else{
    		return false;
    	}
    }
    
    /**
     * ���ݶ�ͯ����ID��øö�ͯ�ķ�������
     * @description 
     * @author MaYun
     * @date Sep 18, 2014
     * @return
     * @throws DBException 
     */
    public int getFbNum(Connection conn,String ciid) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("getFbNum",ciid);
    	//System.out.println("sql:"+sql);
    	return ide.find(sql).getData(0).getInt("PUB_NUM");
    }
    
    /**
     * �������¶�ͯ���ϱ���Ϣ
     * @description 
     * @author MaYun
     * @date Sep 18, 2014
     * @return
     * @throws DBException 
     */
    public boolean batchUpdateETCL(Connection conn,DataList dataList) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	for(int i=0;i<dataList.size();i++){
    		dataList.getData(i).setEntityName("CMS_CI_INFO");
    		dataList.getData(i).setPrimaryKey("CI_ID");
    	}
    	int re =ide.batchStore(dataList);
    	if(re>0){
    		return true;
    	}else{
    		return false;
    	}
    }
    
    
    /**
     * ���¶�ͯ���ϱ���Ϣ
     * @description 
     * @author MaYun
     * @date Sep 18, 2014
     * @return
     * @throws DBException 
     */
    public void updateETCL(Connection conn,Data data) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
		data.setEntityName("CMS_CI_INFO");
		data.setPrimaryKey("CI_ID");
	    ide.store(data);
    }
    
    
    /**
     * ���ݷ�����¼ID��÷�����¼�Ͷ�ͯ��Ϣ
     * @description 
     * @author MaYun
     * @date Sep 18, 2014
     * @return
     * @throws DBException 
     */
    public Data getEtAndFbInfo(Connection conn,String pubid) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("getEtAndFbInfo",pubid);
    	return ide.find(sql).getData(0);
    }
    
    /**
     * ���ݷ�����¼ID���Ԥ����������¼�Ͷ�ͯ��Ϣ
     * @description 
     * @author MaYun
     * @date Sep 18, 2014
     * @return
     * @throws DBException 
     */
    public Data getYpEtAndFbInfo(Connection conn,String pubid) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("getYpEtAndFbInfo",pubid);
    	return ide.find(sql).getData(0);
    }
    
    /**
     * ���ݶ�ͯ����ID��ö�ͯ������Ϣ
     * @description 
     * @author MaYun
     * @date Sep 22, 2014
     * @return
     */
    public Data getETInfo(Connection conn,String ciid)throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("getETInfo",ciid);
    	return ide.find(sql).getData(0);
    }
    
    
    /**
     * ���·�����¼��Ϣ
     * @author mayun
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public void updateFbInfo(Connection conn, Map<String, Object> fbData) throws DBException {
        Data dataadd = new Data(fbData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("SCE_PUB_RECORD");
        dataadd.setPrimaryKey("PUB_ID");
        dataadd.store();
        
    }
    
    /**
     * ����Ԥ����Ϣ
     * @author mayun
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public void updateYpInfo(Connection conn, Map<String, Object> fbData) throws DBException {
        Data dataadd = new Data(fbData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("SCE_REQ_INFO");
        dataadd.setPrimaryKey("RI_ID");
        dataadd.store();
    }
    
    /**
     * ���ݶ�ͯ����id��ô�ͬ���ֵܵ�����
     * @description 
     * @author MaYun
     * @date Sep 23, 2014
     * @return String names
     */
    public String getETNameForTB(Connection conn,String ciid) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("getETNamesForTB",ciid);
    	DataList dataList = ide.find(sql);
    	String  NAMES="";
    	
    	if(dataList.size()>0){
    		for(int i=0;i<dataList.size();i++){
        		if(i==0){
        			NAMES=dataList.getData(i).getString("NAME");
        		}else{
        			NAMES+=","+dataList.getData(i).getString("NAME");
        		}
        	}
    	}
    	return NAMES;
    }
    
    
    /**
	 * ��ͯ����������Ϣ	
	 * @param conn
	 * @param String ciid ��ͯ����ID
	 * @return DataList
	 * @throws DBException
	 */
	public DataList showLockHistory(Connection conn, String ciid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("showLockHistory",ciid);
		//System.out.println("sql---->"+sql);
		DataList dl = ide.find(sql);
        return dl;
	}
	
	/**
	 * ��ͯ���η�����Ϣ	
	 * @param conn
	 * @param String ciid ��ͯ����ID
	 * @return DataList
	 * @throws DBException
	 */
	public DataList showFbHistory(Connection conn, String ciid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("showFbHistory",ciid);
		//System.out.println("sql---->"+sql);
		DataList dl = ide.find(sql);
        return dl;
	}
	
	/**
	 * �õ�����ƻ����������ļƻ�ID(��Ҫ�����������)
	 * @param conn
	 * @return DataList
	 * @throws DBException
	 */
	public String getPlanIdForDFB(Connection conn) throws DBException {
		String plan_id = "";
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPlanIdForDFB");
		DataList dl = ide.find(sql);
		
		if(dl.size()>0){
			plan_id = dl.getData(0).getString("PLAN_ID");
		}
        return plan_id;
	}
	
	
    
}
