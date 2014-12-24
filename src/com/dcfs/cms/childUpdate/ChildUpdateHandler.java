package com.dcfs.cms.childUpdate;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import com.dcfs.common.batchattmanager.BatchAttManager;
import com.hx.upload.sdk.AttHelper;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

public class ChildUpdateHandler extends BaseHandler{

	 public DataList updateListFLY(Connection conn, String oId, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {

	    	//��ѯ����
			String NAME = data.getString("NAME", null);	//����
			String SEX = data.getString("SEX", null);	//�Ա�
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//�������ڿ�ʼ
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//�������ڿ�ʼ
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//��ͯ����
			String SN_TYPE = data.getString("SN_TYPE", null);	//��������
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//������ڿ�ʼ
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//������ڽ���
			String UPDATE_STATE = data.getString("UPDATE_STATE", null);	//����״̬
			String UPDATE_DATE_START = data.getString("UPDATE_DATE_START",null);//�������ڿ�ʼ
			String UPDATE_DATE_END = data.getString("UPDATE_DATE_END",null);//�������ڽ���
			//��ѯ����
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("updateListFLY",oId,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,UPDATE_STATE,UPDATE_DATE_START,UPDATE_DATE_END,compositor,ordertype);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	 
	   public DataList updateListST(Connection conn, String oCode, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {

	    	//��ѯ����
		    String WELFARE_ID = data.getString("WELFARE_ID", null);	//����Ժcode
			String NAME = data.getString("NAME", null);	//����
			String SEX = data.getString("SEX", null);	//�Ա�
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//�������ڿ�ʼ
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//�������ڿ�ʼ
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//��ͯ����
			String SN_TYPE = data.getString("SN_TYPE", null);	//��������
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//������ڿ�ʼ
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//������ڽ���
			String UPDATE_STATE = data.getString("UPDATE_STATE", null);	//����״̬
			String UPDATE_DATE_START = data.getString("UPDATE_DATE_START",null);//�������ڿ�ʼ
			String UPDATE_DATE_END = data.getString("UPDATE_DATE_END",null);//�������ڽ���
			//��ѯ����
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("updateListST",oCode,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,UPDATE_STATE,UPDATE_DATE_START,UPDATE_DATE_END,compositor,ordertype);
	        System.out.println(sql);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	   
	   public DataList updateListZX(Connection conn,Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {

	    	//��ѯ����
		    String PROVINCE_ID = data.getString("PROVINCE_ID", null);	//ʡ��
		    String WELFARE_ID = data.getString("WELFARE_ID", null);	//����Ժ
			String NAME = data.getString("NAME", null);	//����
			String SEX = data.getString("SEX", null);	//�Ա�
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//�������ڿ�ʼ
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//�������ڿ�ʼ
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//��ͯ����
			String SN_TYPE = data.getString("SN_TYPE", null);	//��������
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//������ڿ�ʼ
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//������ڽ���
			String UPDATE_STATE = data.getString("UPDATE_STATE", null);	//����״̬
			String UPDATE_DATE_START = data.getString("UPDATE_DATE_START",null);//�������ڿ�ʼ
			String UPDATE_DATE_END = data.getString("UPDATE_DATE_END",null);//�������ڽ���
			String UPDATE_USERNAME=data.getString("UPDATE_USERNAME",null);//������
			//��ѯ����
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("updateListZX",PROVINCE_ID,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,UPDATE_STATE,UPDATE_DATE_START,UPDATE_DATE_END,UPDATE_USERNAME,compositor,ordertype);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	 
	   public DataList updateSelectFLY(Connection conn, String oId, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {

	    	//��ѯ����
			String NAME = data.getString("NAME", null);	//����
			String SEX = data.getString("SEX", null);	//�Ա�
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//�������ڿ�ʼ
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//�������ڿ�ʼ
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//��ͯ����
			String SN_TYPE = data.getString("SN_TYPE", null);	//��������
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//������ڿ�ʼ
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//������ڽ���
			String SEND_DATE_START =  data.getString("SEND_DATE_START", null);//�������ڿ�ʼ
			String SEND_DATE_END = data.getString("SEND_DATE_END",null);//�������ڽ���
			String CI_GLOBAL_STATE = data.getString("CI_GLOBAL_STATE", null);	//��ͯ״̬
			String NAME_CN = data.getString("NAME_CN", null);	//������֯
			//��ѯ����
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("updateSelectFLY",oId,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,SEND_DATE_START,SEND_DATE_END,CI_GLOBAL_STATE,NAME_CN,compositor,ordertype);
	        System.out.println(sql);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	   
	   public DataList updateSelectZX(Connection conn, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {
	    	//��ѯ����
	 		String PROVINCE_ID = data.getString("PROVINCE_ID", null);	//ʡ��
		    String WELFARE_ID = data.getString("WELFARE_ID", null);	//����Ժ
			String NAME = data.getString("NAME", null);	//����
			String SEX = data.getString("SEX", null);	//�Ա�
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//�������ڿ�ʼ
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//�������ڿ�ʼ
			String SN_TYPE = data.getString("SN_TYPE", null);	//��������
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//������ڿ�ʼ
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//������ڽ���
			String SPECIAL_FOCUS = data.getString("SPECIAL_FOCUS", null);	//�ر��ע
			String UPDATE_NUM = data.getString("UPDATE_NUM", null);	//���´���
			String PUB_STATE = data.getString("PUB_STATE", null);	//����״̬
			String RI_STATE = data.getString("RI_STATE", null);	//Ԥ������״̬������״̬��
			String ADREG_STATE = data.getString("ADREG_STATE", null);	//�Ǽ�״̬
			//��ѯ����
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("updateSelectZX",PROVINCE_ID,WELFARE_ID,NAME,SEX,
	        		BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,SPECIAL_FOCUS,UPDATE_NUM,PUB_STATE,RI_STATE,ADREG_STATE,compositor,ordertype);
	        System.out.println(sql);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	   
	   public DataList updateSelectST(Connection conn, String oId, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {

	    	//��ѯ����
		    String WELFARE_ID = data.getString("WELFARE_ID", null);	//����Ժcode
			String NAME = data.getString("NAME", null);	//����
			String SEX = data.getString("SEX", null);	//�Ա�
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//�������ڿ�ʼ
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//�������ڿ�ʼ
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//��ͯ����
			String SN_TYPE = data.getString("SN_TYPE", null);	//��������
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//������ڿ�ʼ
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//������ڽ���
			String SEND_DATE_START =  data.getString("SEND_DATE_START", null);//�������ڿ�ʼ
			String SEND_DATE_END = data.getString("SEND_DATE_END",null);//�������ڽ���
			String CI_GLOBAL_STATE = data.getString("CI_GLOBAL_STATE", null);	//��ͯ״̬
			String NAME_CN = data.getString("NAME_CN", null);	//������֯
			//��ѯ����
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("updateSelectST",oId,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,SEND_DATE_START,SEND_DATE_END,CI_GLOBAL_STATE,NAME_CN,compositor,ordertype);
	        System.out.println(sql);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	   
	    //��ȡ��ͯ���ϸ��¼�¼����ͯ���ϻ�����Ϣ
	    public Data getShowData(Connection conn, String cui_id) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = new DataList();
	        dataList = ide.find(getSql("getShowData", cui_id));
	        Data updateData=dataList.getData(0);
	        return updateData;
	    }
	  //��ȡ��ͯ���ϸ������ҳ���չʾ��Ϣ
	    public Data getShowDataByCuaId(Connection conn, String cua_id) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = new DataList();
	        dataList = ide.find(getSql("getAuditShowData", cua_id));
	        Data updateData=dataList.getData(0);
	        return updateData;
	    }
	  //���ݶ�ͯ����������ȡ��ͯ���ϻ�����Ϣ���޸���
	    public Data getChildInfoById(Connection conn, String ci_id) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = new DataList();
	        dataList = ide.find(getSql("getChildInfoById", ci_id));
	        return dataList.getData(0);
	         
	    }
	    //���ݶ�ͯ����������ȡ�������ͨ���ĸ��¼�¼��Ϣ
	    public DataList getUpdateDataByCIID(Connection conn, String CI_ID) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = null;
	        dataList = ide.find(getSql("getUpdateDataByCIID", CI_ID));
	        return dataList;
	    }
	    //��ȡ��ͯ���ϸ�����ϸ��Ϣ
	    /**
	     * updateClassֵΪ0���ʾ��ȡ������Ϣ�ĸ�����ϸ��updateClassֵΪ1���ʾ��ȡ��ͯ����������ϸ
	     */
	    public DataList getUpdateDetail(Connection conn, String CUI_ID,String updateClass) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = new DataList();
	        dataList = ide.find(getSql("getUpdateDetail", CUI_ID,updateClass));
	        return dataList;
	    }
	    //��ȡ��ͯ���ϸ���������ϸ��Ϣ
	    public DataList getAttUpdateDetail(Connection conn, String CUI_ID)throws DBException {
	    	    IDataExecute ide = DataBaseFactory.getDataBase(conn);
		        DataList dataList = new DataList();
		        dataList = ide.find(getSql("getAttUpdateDetail", CUI_ID));
		        return dataList;
	    }
	  //��ȡ��ͯ���ϸ���������ϸ��ϢӢ��
	    public DataList getAttUpdateDetailEN(Connection conn, String CUI_ID)throws DBException {
	    	    IDataExecute ide = DataBaseFactory.getDataBase(conn);
		        DataList dataList = new DataList();
		        dataList = ide.find(getSql("getAttUpdateDetailEN", CUI_ID));
		        return dataList;
	    }
	    //������¼�¼
	    public boolean saveUpdateData(Connection conn, Data data) throws DBException {
	    	 data.setConnection(conn);
	    	 data.setEntityName("CMS_CI_UPDATE_INFO");
	    	 data.setPrimaryKey("CUI_ID");
	    	 String id=data.getString("CUI_ID", null);
	    	 if(id==null){
	    		 data.create();
	    	 }else{
	    	     data.store();
	    	 }
		    return true;
	     }
	   //���������ϸ��Ϣ��������Ϣ��
	    public boolean saveUpdateDetail(Connection conn,DataList updateDetails,String CUI_ID, Data originaldata,Data newdata) throws DBException {
	    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        Set keysSet = newdata.keySet();
	        Iterator iterator = keysSet.iterator();
	        while(iterator.hasNext()) {
	            Data savedata = new Data();
	            Object key = iterator.next();//key
	            String keystr = key.toString().substring(1,key.toString().length());
	            if(newdata.getString(key)==null){
	            	continue;
	               // newdata.add(key.toString(), "");
	            }
	            if(originaldata.getString(keystr)==null){
	                originaldata.add(keystr.toString(), "");
	            } 
	            if(!originaldata.getString(keystr).equals(newdata.getString(key))){
	                savedata.setEntityName("CMS_CI_UPDATE_DETAIL");
	                savedata.add("CUI_ID", CUI_ID);
	                savedata.add("UPDATE_FIELD", keystr);
	                savedata.add("ORIGINAL_DATA", originaldata.getString(keystr));
	                savedata.add("UPDATE_DATA",newdata.getString(key));
	                savedata.add("UPDATE_TYPE","0");
	                savedata.add("UPDATE_CLASS","0");
	                updateDetails.add(savedata);
	            }    
	        }
	        //��ɾ�����еĸ�����ϸ��Ϣ
	        ide.execute(getSql("deleteUpdateDetail", CUI_ID,"0"));
	        if(updateDetails.size()==0){
	        	return false;
	        }
	        int j = ide.batchCreate(updateDetails);
	        if (j >= 0) {
	            return true;
	        } else {
	            return false;
	        }
	     }
	    //���������ϸ��Ϣ��������Ϣ��
	    public boolean saveAttUpdateDetail(Connection conn,DataList attUpdateDetails,String[] smallTypes,String[] updatetypes ,String CUI_ID, String FILE_CODE) throws DBException {
	    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
	    	String smallTypeUsed="";
	    	//����file_code(��packageId)��ȡÿ��С���Ӧ�ĸ�������
	    	Map<String,DataList> attMap=new BatchAttManager().getAttDataByPackageID("N"+FILE_CODE, "CI");
	    	Map<String,DataList> attOMap=new BatchAttManager().getAttDataByPackageID(FILE_CODE, "CI");
	    	if(smallTypes!=null){
	    		//����smallTypes��С�ࣩ�����������ϸ���ݣ�ͬʱ��smallTypesƴ�ӳ��ַ������Թ�ɾ����������ʹ��
		    	for(int i=0;i<smallTypes.length;i++){
		    		 if(i<(smallTypes.length-1)){
		    			 smallTypeUsed=smallTypeUsed+"'"+smallTypes[i]+"'"+",";
		    		 }else{
		    			 smallTypeUsed=smallTypeUsed+"'"+smallTypes[i]+"'";
		    		 }
		    		Data savedata = new Data();
	    		    savedata.setEntityName("CMS_CI_UPDATE_DETAIL");
	                savedata.add("CUI_ID", CUI_ID);
	                savedata.add("UPDATE_FIELD", smallTypes[i]);
	                savedata.add("UPDATE_TYPE",updatetypes[i]);
	                savedata.add("UPDATE_CLASS","1");
	                //��ȡ��С���Ӧ�ĸ��¸�������������ƴ�ӳ��ַ������硰id1#name1,id2#name2,id3#name3����,���丳ֵ��UPDATE_DATA
	                String attIds="";
	                DataList attList=attMap.get(smallTypes[i]);
	                if(attList!=null){
	                	for(int j=0;j<attList.size();j++){
	                        if(j<(attList.size()-1)){
	                   	    attIds=attIds+(attList.getData(j).getString("ID"))+"#"+(attList.getData(j).getString("ATT_NAME"))+",";
	                   	  }else{
	                   	    attIds=attIds+(attList.getData(j).getString("ID"))+"#"+(attList.getData(j).getString("ATT_NAME")); 
	                   	  }
	                   }
	                }
	                savedata.add("UPDATE_DATA",attIds);
	                //��ȡ��С���Ӧ��ԭ��������������ƴ�ӳ��ַ������硰id1#name1,id2#name2,id3#name3����,���丳ֵ��ORIGINAL_DATA
	                String attOIds="";
	                DataList attOList=attOMap.get(smallTypes[i]);
	                if(attOList!=null){
	                	for(int j=0;j<attOList.size();j++){
	                        if(j<(attOList.size()-1)){
	                       	 attOIds=attOIds+(attOList.getData(j).getString("ID"))+"#"+(attOList.getData(j).getString("ATT_NAME"))+",";
	                   	 }else{
	                   		 attOIds=attOIds+(attOList.getData(j).getString("ID"))+"#"+(attOList.getData(j).getString("ATT_NAME")); 
	                   	 }
	                   }
	                }
	                savedata.add("ORIGINAL_DATA",attOIds);
	                attUpdateDetails.add(savedata);
		    	}
		    	//��ɾ����������
		    	ide.execute(getSql("deleteAttBySmallType", ("N"+FILE_CODE),smallTypeUsed));
	    	}
	    	
	        //��ɾ�����еĸ�����ϸ��Ϣ
	        ide.execute(getSql("deleteUpdateDetail", CUI_ID,"1"));
	        if(attUpdateDetails.size()==0){
	        	return false;
	        }
	        int j=ide.batchCreate(attUpdateDetails);
	        if (j >= 0) {
	            return true;
	        } else {
	            return false;
	        }
	     }
	    //������Ϣ����ʵ��
	    public boolean updateAttachment(Connection conn,String packageId,String smalltype, String updatetype) throws DBException {
	    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
	    	if("1".equals(updatetype)){
	    		ide.execute(getSql("updateAttPackageId",packageId,"N"+packageId,smalltype));
	    	}else if("0".equals(updatetype)){
	    		//AttHelper.delAttsOfPackageId(packageId, smalltype, "CI");���ɾ���ᵼ�²鿴���¼�¼ʱû�и��¸���
	    		ide.execute(getSql("updateAttPackageId","D"+packageId,packageId,smalltype));
	    		ide.execute(getSql("updateAttPackageId",packageId,"N"+packageId,smalltype));
	    	}
	    	return true;
	     }
	  //���¸�����Ϣ���߼�ɾ��
	    public boolean changeUpdateAttPackagId(Connection conn,String packageId,String smalltype) throws DBException {
	    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        ide.execute(getSql("updateAttPackageId","D"+packageId,"N"+packageId,smalltype));
	    	return true;
	     }
	  //���������˼�¼��Ϣ
	    public boolean saveAuditInfo(Connection conn, Data data) throws DBException {
	    	 data.setConnection(conn);
	    	 data.setEntityName("CMS_CI_UPDATE_ADUIT");
	    	 data.setPrimaryKey("CUA_ID");
	    	 String id=data.getString("CUA_ID", null);
	    	 if(id==null){
	    		 data.create();
	    	 }else{
	    	     data.store();
	    	 }
		    return true;
	     }
	    //���¶�ͯ������Ϣ���еĸ���״̬
	    public boolean saveChildUpdateState(Connection conn, Data data) throws DBException {
	    	 String CI_ID=data.getString("CI_ID",null);
	    	 if(CI_ID==null){
	    		 return false;
	    	 }
	    	 data.setConnection(conn);
	    	 data.setEntityName("CMS_CI_INFO");
	    	 data.setPrimaryKey("CI_ID");
	    	 data.store();
		    return true;
	     }
	    
	    public DataList updateAuditListSt(Connection conn,String provinceId, String auditType, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {

	    	//��ѯ����
		    String WELFARE_ID = data.getString("WELFARE_ID", null);	//����Ժcode
			String NAME = data.getString("NAME", null);	//����
			String SEX = data.getString("SEX", null);	//�Ա�
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//�������ڿ�ʼ
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//�������ڿ�ʼ
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//��ͯ����
			String SN_TYPE = data.getString("SN_TYPE", null);	//��������
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//������ڿ�ʼ
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//������ڽ���
			String UPDATE_STATE = data.getString("UPDATE_STATE", null);	//����״̬
			String UPDATE_DATE_START = data.getString("UPDATE_DATE_START",null);//�������ڿ�ʼ
			String UPDATE_DATE_END = data.getString("UPDATE_DATE_END",null);//�������ڽ���
			String AUDIT_USERNAME = data.getString("AUDIT_USERNAME", null);	//�����
			String AUDIT_DATE_START = data.getString("AUDIT_DATE_START",null);//������ڿ�ʼ
			String AUDIT_DATE_END = data.getString("AUDIT_DATE_END",null);//������ڽ���
			
			//��ѯ����
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("updateAuditListSt",provinceId,auditType,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,UPDATE_STATE,UPDATE_DATE_START,UPDATE_DATE_END,AUDIT_USERNAME,AUDIT_DATE_START,AUDIT_DATE_END,compositor,ordertype);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	    
	    public DataList updateAuditListZX(Connection conn,String auditType, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {

	    	//��ѯ����
	    	String PROVINCE_ID = data.getString("PROVINCE_ID", null);	//ʡ��
		    String WELFARE_ID = data.getString("WELFARE_ID", null);	//����Ժ
			String NAME = data.getString("NAME", null);	//����
			String SEX = data.getString("SEX", null);	//�Ա�
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//�������ڿ�ʼ
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//�������ڿ�ʼ
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//��ͯ����
			String SN_TYPE = data.getString("SN_TYPE", null);	//��������
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//������ڿ�ʼ
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//������ڽ���
			String UPDATE_STATE = data.getString("UPDATE_STATE", null);	//����״̬
			String UPDATE_DATE_START = data.getString("UPDATE_DATE_START",null);//�������ڿ�ʼ
			String UPDATE_DATE_END = data.getString("UPDATE_DATE_END",null);//�������ڽ���
			String AUDIT_USERNAME = data.getString("AUDIT_USERNAME", null);	//�����
			String AUDIT_DATE_START = data.getString("AUDIT_DATE_START",null);//������ڿ�ʼ
			String AUDIT_DATE_END = data.getString("AUDIT_DATE_END",null);//������ڽ���
			
			//��ѯ����
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("updateAuditListZX",auditType,PROVINCE_ID,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,UPDATE_STATE,UPDATE_DATE_START,UPDATE_DATE_END,AUDIT_USERNAME,AUDIT_DATE_START,AUDIT_DATE_END,compositor,ordertype);
	        System.out.println("zxds"+sql);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	    
	  //���������ϸ��Ϣ��������Ϣ��
	    public boolean saveUpdateDetailStore(Connection conn,DataList updateDetails,Data newUpateData,String prefix) throws DBException {
	    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
	    	for(int i=0;i<updateDetails.size();i++){
	    		Data tmpData=updateDetails.getData(i);
	    		tmpData.setConnection(conn);
	    		tmpData.setEntityName("CMS_CI_UPDATE_DETAIL");
	    		tmpData.setPrimaryKey("CUI_ID","UPDATE_FIELD");
	    		String oupdateData=tmpData.getString("UPDATE_DATA","");
	    		String nupdateData=newUpateData.getString(prefix+tmpData.getString("UPDATE_FIELD"),"");
	    		if(!oupdateData.equals(nupdateData)){
	    			tmpData.add("UPDATE_DATA", nupdateData);
	    		}
	    	}
	        ide.batchStore(updateDetails);
	       return true; 
	     }
	  //���������ϸ��Ϣ��������Ϣ��
	    public boolean saveAttUpdateDetailStore(Connection conn,DataList attUpdateDetails,String[] smallTypes,String[] updatetypes ,String CUI_ID, String FILE_CODE) throws DBException {
	    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
	    	//����file_code(��packageId)��ȡÿ��С���Ӧ�ĸ�������
	    	Map<String,DataList> attMap=new BatchAttManager().getAttDataByPackageID("N"+FILE_CODE, "CI");
	    	//����smallTypes��С�ࣩ�����������ϸ���ݣ�ͬʱ��smallTypesƴ�ӳ��ַ������Թ�ɾ����������ʹ��
	    	for(int i=0;i<smallTypes.length;i++){
	    		Data savedata = new Data();
    		    savedata.setEntityName("CMS_CI_UPDATE_DETAIL");
                savedata.add("CUI_ID", CUI_ID);
                savedata.add("UPDATE_FIELD", smallTypes[i]);
                savedata.add("UPDATE_TYPE",updatetypes[i]);
                savedata.add("UPDATE_CLASS","1");
                //��ȡ��С���Ӧ�ĸ�������������ƴ�ӳ��ַ������硰id1,id2,id3����,���丳ֵ��UPDATE_DATA
                String attIds="";
                DataList attList=attMap.get(smallTypes[i]);
                if(attList!=null){
                	for(int j=0;j<attList.size();j++){
                        if(j<(attList.size()-1)){
                   	    attIds=attIds+(attList.getData(j).getString("ID"))+"#"+(attList.getData(j).getString("ATT_NAME"))+",";
                   	  }else{
                   	    attIds=attIds+(attList.getData(j).getString("ID"))+"#"+(attList.getData(j).getString("ATT_NAME")); 
                   	  }
                   }
                }
                savedata.setPrimaryKey("CUI_ID","UPDATE_FIELD");
                savedata.add("UPDATE_DATA",attIds);
                attUpdateDetails.add(savedata);
	    	}
	    	ide.batchStore(attUpdateDetails);
	    	return true;
	     }
	    
	   
}
