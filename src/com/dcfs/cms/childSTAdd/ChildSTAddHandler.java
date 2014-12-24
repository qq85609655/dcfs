package com.dcfs.cms.childSTAdd;

import hx.common.Exception.DBException;
import hx.database.databean.Data;
import java.sql.Connection;

import com.dcfs.cms.childManager.ChildStateManager;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/**
 * @Title: ChildSTAddHandler.java
 * @Description:
 * @Created on 
 * @author xcp
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class ChildSTAddHandler extends BaseHandler{

	  /**
     * �����ͯ������Ϣ
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
	public Data save(Connection conn, Data data) throws DBException {
		// ***��������*****
		Data dataadd = new Data(data);
		dataadd.setConnection(conn);
		dataadd.setEntityName("CMS_CI_INFO");
		dataadd.setPrimaryKey("CI_ID");
		if ("".equals(dataadd.getString("CI_ID", ""))) {
			dataadd = dataadd.create();			
		} else {
			dataadd = dataadd.store();
		}
		return dataadd;
	}
	/**
	 * ���������˼�¼
	 * 
	 */
	public boolean saveCIAduit(Connection conn, Data data) throws DBException {
		// ***��������*****
		Data dataadd = new Data(data);

		dataadd.setConnection(conn);
		dataadd.setEntityName("CMS_CI_ADUIT");
		dataadd.setPrimaryKey("CA_ID");
		if ("".equals(dataadd.getString("CA_ID", ""))) {
			dataadd.create();
		} else {
			dataadd.store();
		}
		return true;
	}
   
    /**
     *��ͯ���ϼ�¼��ѯ�б�
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public DataList getChildInfoList(Connection conn, Data data)
            throws DBException {
    	
    	//��ѯ����
    	String WELFARE_ID		= data.getString("WELFARE_ID", null);    
    	String NAME			= data.getString("NAME", null);               
    	String SEX			= data.getString("SEX", null);                
    	String BIRTHDAY		= data.getString("BIRTHDAY", null);     
    	//��ѯ����
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getChildList",WELFARE_ID,NAME,SEX,BIRTHDAY);
        DataList dl = ide.find(sql);        
        return dl;
    }
    
    /**
     *��ͯ���ϼ�¼��ѯ�б�
     * @param conn
     * @param childNO
     * @return
     * @throws DBException
     */
    public DataList getTwinsByChildNO(Connection conn, String childNO)
            throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getTwinsByChildNO",childNO);
        DataList dl = ide.find(sql);        
        return dl;
    }
   
    /**
     * �����Ч��ͯ��Ϣ�б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException
     */
    public DataList getValidChildList(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {
    	
    	//��ѯ����
    	String WELFARE_ID = data.getString("WELFARE_ID", null);   
    	String NAME = data.getString("NAME", null);   
    	String SEX = data.getString("SEX", null);   
    	String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   
    	String BIRTHDAY_END = data.getString("BIRTHDAY_END", null); 
    	String CI_ID = data.getString("CI_ID");
    	
		//��ѯ����
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getValidChildList",WELFARE_ID,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,compositor,ordertype,CI_ID);
        System.out.println("getValidChildList:"+sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * ʡ�������ύ
     * @param conn
     * @param uuid ����id����
     * @return
     * @throws DBException
     */
     public boolean stBatchSubmit(Connection conn, String[] uuid) throws DBException {
         IDataExecute ide = DataBaseFactory.getDataBase(conn);
         //���ϼ�¼list
         DataList dataList = new DataList();
         for (int i = 0; i < uuid.length; i++) {
         	//���¶�ͯ���ϱ���״̬
             Data data = new Data();
             data.setConnection(conn);
             data.setEntityName("CMS_CI_INFO");
             data.setPrimaryKey("CI_ID");
             data.add("CI_ID", uuid[i]);
             data.add("AUD_STATE", ChildStateManager.CHILD_AUD_STATE_STG);
             dataList.add(data);
         }
         ide.batchStore(dataList);
         return true;
     }
    /**
     * ���ݶ�ͯ����ID��ȡ��ͯ���ϼ�¼��ѯ�б�
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public DataList getChildListByCIID(Connection conn, String[] uuid)
            throws DBException {
    	
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
        
        StringBuffer sb = new StringBuffer();
        sb.append("SELECT CHILD_NO,PROVINCE_ID,WELFARE_NAME_CN,NAME,SEX,BIRTHDAY,CHILD_TYPE,IS_HOPE,IS_PLAN,SN_TYPE FROM CMS_CI_INFO WHERE");
        sb.append(" CI_ID='").append(uuid[0]).append("'");
        for (int i = 1; i < uuid.length; i++) {
        	sb.append(" OR CI_ID='").append(uuid[i]).append("'");
        }
        DataList dl = ide.find(sb.toString());
        return dl;
    }
    /**
     * ����ͬ��
     * @param conn
     * @param cid
     * @param cno
     * @return
     * @throws DBException
     */
    public boolean setTwins(Connection conn, String[] cid,String[] cno,String CI_ID) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        String IS_TWINS = "1";
        String cnos = "";
        
        if(cno.length==0){
        	IS_TWINS = "0";        	
        }else{
	        StringBuffer sb = new StringBuffer();
	        for(int  j=0 ; j < cno.length ;j++){
	        	sb.append(cno[j]);	        	
	        	if (j!= (cno.length-1)){
	        		sb.append(",");
	        	}
	        }
	        cnos = sb.toString();
        }
        	
        String isMain = "1";
        for (int i = 0; i < cid.length; i++) {
            Data data = new Data();
            
            data.setConnection(conn);
            data.setEntityName("CMS_CI_INFO");
            data.setPrimaryKey("CI_ID");
            if(i!=0){
            	isMain = "0";
            }
            data.add("CI_ID", cid[i]);
            data.add("IS_TWINS", IS_TWINS);
            data.add("TWINS_IDS", this.getTWINS_IDS(cnos, cno[i]));
            
            data.add("IS_MAIN",isMain);
            data.add("MAIN_CI_ID", CI_ID);
            dataList.add(data);
        }
       ide.batchStore(dataList);
	        
       return true;
    }
    
    /**
     * ���ͬ����ͯ��ţ���ż��ԣ��ŷָ�
     * @param cnos
     * @param childno
     * @return
     */
    public String getTWINS_IDS(String cnos,String childno){
    	String s = ","+childno;
    	String sc = ","+cnos + ",";
    	sc = sc.replace(s, "");
    	if(sc.length()==1){
    		sc = "";
    	}else{
    		sc = sc.substring(1,sc.length()-1);
    	}
    	return sc;    	
    }
    /**
     * ���ɶ�ͯ���
     * @param conn
     * @param data
     * @param operType
     * @return
     * @throws DBException
     */
    public boolean createChildNO(Connection conn, Data data,String operType) throws DBException{
    	// ***��������*****
		Data dataadd = new Data(data);

		dataadd.setConnection(conn);
		dataadd.setEntityName("CMS_CI_CHILDNO");
		dataadd.setPrimaryKey("YEAR","PROVINCE_ID");
		if ("new".equals(operType)) {
			dataadd.create();
		} else {
			dataadd.store();
		}
		return true;
    }
    
    /**
     * ��ȡ��ͯ������ֵ����û���򷵻�null
     * @throws DBException 
     * 
     */
    public Data getMaxChildNO(Connection conn, String proviceId,String year) throws DBException{    	
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getMaxChildNO",proviceId,year);
        DataList dl = ide.find(sql);
        if(dl.size()!=0){
        	return dl.getData(0);
        }else{
        	return null;
        }
    }

    /**
     * ��ѯ�б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @return
     * @throws DBException
     */
    public DataList findList(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {
    	//��ѯ����
    	String PROVINCE_ID	= data.getString("PROVINCE_ID", null); 
    	String IS_DAILU = data.getString("IS_DAILU",null);
    	String WELFARE_ID = data.getString("WELFARE_ID", null);	//����Ժcode
		String NAME = data.getString("NAME", null);	//����
		String SEX = data.getString("SEX", null);	//�Ա�
		String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//��ͯ����
		String SN_TYPE = data.getString("SN_TYPE", null);	//��������
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//�������ڿ�ʼ
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//�������ڿ�ʼ
		String REG_USERNAME = data.getString("REG_USERNAME",null);//¼����
		String AUD_STATE = data.getString("AUD_STATE",null);//����״̬
		String REG_DATE_STRAT = data.getString("REG_DATE_STRAT",null);//¼��ʱ�俪ʼ
		String REG_DATE_END = data.getString("REG_DATE_END",null);//¼��ʱ�����
		String CHECKUP_DATE_START = data.getString("CHECKUP_DATE_START",null);//���ʱ�俪ʼ
		String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//���ʱ�����
		if("0".equals(AUD_STATE)){
			AUD_STATE=",0,";
		}else if("4".equals(AUD_STATE)){
			AUD_STATE=",1,2,3,4,5,6,7,8,9,";
		}
		//��ѯ����
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findList",PROVINCE_ID,IS_DAILU,WELFARE_ID,NAME,SEX,CHILD_TYPE,SN_TYPE,BIRTHDAY_START,BIRTHDAY_END,REG_USERNAME,AUD_STATE,REG_DATE_STRAT,REG_DATE_END,CHECKUP_DATE_START,CHECKUP_DATE_END,compositor,ordertype);
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * �鿴
     * 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public Data getShowData(Connection conn, String uuid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("getShowData", uuid));
        System.out.println(getSql("getShowData", uuid));
        return dataList.getData(0);
    }

    /**
     * ɾ��
     * 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public boolean delete(Connection conn, String[] uuid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList deleteList = new DataList();
        for (int i = 0; i < uuid.length; i++) {
            Data data = new Data();
            data.setConnection(conn);
            data.setEntityName("CMS_CI_INFO");
            data.setPrimaryKey("CI_ID");
            data.add("CI_ID", uuid[i]);
            deleteList.add(data);
        }
        ide.remove(deleteList);
        return true;
    }
    

}