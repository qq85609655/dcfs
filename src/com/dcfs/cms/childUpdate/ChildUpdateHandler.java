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

	    	//查询条件
			String NAME = data.getString("NAME", null);	//姓名
			String SEX = data.getString("SEX", null);	//性别
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//出生日期开始
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//出生日期开始
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//儿童类型
			String SN_TYPE = data.getString("SN_TYPE", null);	//病残种类
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//体检日期开始
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//体检日期结束
			String UPDATE_STATE = data.getString("UPDATE_STATE", null);	//更新状态
			String UPDATE_DATE_START = data.getString("UPDATE_DATE_START",null);//申请日期开始
			String UPDATE_DATE_END = data.getString("UPDATE_DATE_END",null);//申请日期结束
			//查询条件
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("updateListFLY",oId,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,UPDATE_STATE,UPDATE_DATE_START,UPDATE_DATE_END,compositor,ordertype);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	 
	   public DataList updateListST(Connection conn, String oCode, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {

	    	//查询条件
		    String WELFARE_ID = data.getString("WELFARE_ID", null);	//福利院code
			String NAME = data.getString("NAME", null);	//姓名
			String SEX = data.getString("SEX", null);	//性别
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//出生日期开始
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//出生日期开始
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//儿童类型
			String SN_TYPE = data.getString("SN_TYPE", null);	//病残种类
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//体检日期开始
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//体检日期结束
			String UPDATE_STATE = data.getString("UPDATE_STATE", null);	//更新状态
			String UPDATE_DATE_START = data.getString("UPDATE_DATE_START",null);//申请日期开始
			String UPDATE_DATE_END = data.getString("UPDATE_DATE_END",null);//申请日期结束
			//查询条件
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("updateListST",oCode,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,UPDATE_STATE,UPDATE_DATE_START,UPDATE_DATE_END,compositor,ordertype);
	        System.out.println(sql);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	   
	   public DataList updateListZX(Connection conn,Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {

	    	//查询条件
		    String PROVINCE_ID = data.getString("PROVINCE_ID", null);	//省份
		    String WELFARE_ID = data.getString("WELFARE_ID", null);	//福利院
			String NAME = data.getString("NAME", null);	//姓名
			String SEX = data.getString("SEX", null);	//性别
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//出生日期开始
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//出生日期开始
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//儿童类型
			String SN_TYPE = data.getString("SN_TYPE", null);	//病残种类
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//体检日期开始
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//体检日期结束
			String UPDATE_STATE = data.getString("UPDATE_STATE", null);	//更新状态
			String UPDATE_DATE_START = data.getString("UPDATE_DATE_START",null);//更新日期开始
			String UPDATE_DATE_END = data.getString("UPDATE_DATE_END",null);//更新日期结束
			String UPDATE_USERNAME=data.getString("UPDATE_USERNAME",null);//更新人
			//查询条件
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("updateListZX",PROVINCE_ID,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,UPDATE_STATE,UPDATE_DATE_START,UPDATE_DATE_END,UPDATE_USERNAME,compositor,ordertype);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	 
	   public DataList updateSelectFLY(Connection conn, String oId, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {

	    	//查询条件
			String NAME = data.getString("NAME", null);	//姓名
			String SEX = data.getString("SEX", null);	//性别
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//出生日期开始
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//出生日期开始
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//儿童类型
			String SN_TYPE = data.getString("SN_TYPE", null);	//病残种类
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//体检日期开始
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//体检日期结束
			String SEND_DATE_START =  data.getString("SEND_DATE_START", null);//报送日期开始
			String SEND_DATE_END = data.getString("SEND_DATE_END",null);//报送日期结束
			String CI_GLOBAL_STATE = data.getString("CI_GLOBAL_STATE", null);	//儿童状态
			String NAME_CN = data.getString("NAME_CN", null);	//锁定组织
			//查询条件
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("updateSelectFLY",oId,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,SEND_DATE_START,SEND_DATE_END,CI_GLOBAL_STATE,NAME_CN,compositor,ordertype);
	        System.out.println(sql);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	   
	   public DataList updateSelectZX(Connection conn, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {
	    	//查询条件
	 		String PROVINCE_ID = data.getString("PROVINCE_ID", null);	//省份
		    String WELFARE_ID = data.getString("WELFARE_ID", null);	//福利院
			String NAME = data.getString("NAME", null);	//姓名
			String SEX = data.getString("SEX", null);	//性别
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//出生日期开始
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//出生日期开始
			String SN_TYPE = data.getString("SN_TYPE", null);	//病残种类
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//体检日期开始
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//体检日期结束
			String SPECIAL_FOCUS = data.getString("SPECIAL_FOCUS", null);	//特别关注
			String UPDATE_NUM = data.getString("UPDATE_NUM", null);	//更新次数
			String PUB_STATE = data.getString("PUB_STATE", null);	//发布状态
			String RI_STATE = data.getString("RI_STATE", null);	//预批申请状态（申请状态）
			String ADREG_STATE = data.getString("ADREG_STATE", null);	//登记状态
			//查询条件
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

	    	//查询条件
		    String WELFARE_ID = data.getString("WELFARE_ID", null);	//福利院code
			String NAME = data.getString("NAME", null);	//姓名
			String SEX = data.getString("SEX", null);	//性别
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//出生日期开始
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//出生日期开始
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//儿童类型
			String SN_TYPE = data.getString("SN_TYPE", null);	//病残种类
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//体检日期开始
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//体检日期结束
			String SEND_DATE_START =  data.getString("SEND_DATE_START", null);//报送日期开始
			String SEND_DATE_END = data.getString("SEND_DATE_END",null);//报送日期结束
			String CI_GLOBAL_STATE = data.getString("CI_GLOBAL_STATE", null);	//儿童状态
			String NAME_CN = data.getString("NAME_CN", null);	//锁定组织
			//查询条件
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("updateSelectST",oId,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,SEND_DATE_START,SEND_DATE_END,CI_GLOBAL_STATE,NAME_CN,compositor,ordertype);
	        System.out.println(sql);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	   
	    //获取儿童材料更新记录及儿童材料基本信息
	    public Data getShowData(Connection conn, String cui_id) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = new DataList();
	        dataList = ide.find(getSql("getShowData", cui_id));
	        Data updateData=dataList.getData(0);
	        return updateData;
	    }
	  //获取儿童材料更新审核页面的展示信息
	    public Data getShowDataByCuaId(Connection conn, String cua_id) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = new DataList();
	        dataList = ide.find(getSql("getAuditShowData", cua_id));
	        Data updateData=dataList.getData(0);
	        return updateData;
	    }
	  //根据儿童材料主键获取儿童材料基本信息的修改项
	    public Data getChildInfoById(Connection conn, String ci_id) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = new DataList();
	        dataList = ide.find(getSql("getChildInfoById", ci_id));
	        return dataList.getData(0);
	         
	    }
	    //根据儿童材料主键获取更新审核通过的更新记录信息
	    public DataList getUpdateDataByCIID(Connection conn, String CI_ID) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = null;
	        dataList = ide.find(getSql("getUpdateDataByCIID", CI_ID));
	        return dataList;
	    }
	    //获取儿童材料更新明细信息
	    /**
	     * updateClass值为0则表示获取基本信息的更新明细，updateClass值为1则表示获取儿童附件更新明细
	     */
	    public DataList getUpdateDetail(Connection conn, String CUI_ID,String updateClass) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = new DataList();
	        dataList = ide.find(getSql("getUpdateDetail", CUI_ID,updateClass));
	        return dataList;
	    }
	    //获取儿童材料附件更新明细信息
	    public DataList getAttUpdateDetail(Connection conn, String CUI_ID)throws DBException {
	    	    IDataExecute ide = DataBaseFactory.getDataBase(conn);
		        DataList dataList = new DataList();
		        dataList = ide.find(getSql("getAttUpdateDetail", CUI_ID));
		        return dataList;
	    }
	  //获取儿童材料附件更新明细信息英文
	    public DataList getAttUpdateDetailEN(Connection conn, String CUI_ID)throws DBException {
	    	    IDataExecute ide = DataBaseFactory.getDataBase(conn);
		        DataList dataList = new DataList();
		        dataList = ide.find(getSql("getAttUpdateDetailEN", CUI_ID));
		        return dataList;
	    }
	    //保存更新记录
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
	   //保存更新明细信息（基本信息）
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
	        //先删除已有的更新明细信息
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
	    //保存更新明细信息（附件信息）
	    public boolean saveAttUpdateDetail(Connection conn,DataList attUpdateDetails,String[] smallTypes,String[] updatetypes ,String CUI_ID, String FILE_CODE) throws DBException {
	    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
	    	String smallTypeUsed="";
	    	//根据file_code(即packageId)获取每个小类对应的附件内容
	    	Map<String,DataList> attMap=new BatchAttManager().getAttDataByPackageID("N"+FILE_CODE, "CI");
	    	Map<String,DataList> attOMap=new BatchAttManager().getAttDataByPackageID(FILE_CODE, "CI");
	    	if(smallTypes!=null){
	    		//遍历smallTypes（小类），构造更新明细数据，同时将smallTypes拼接成字符串，以供删除垃圾附件使用
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
	                //获取该小类对应的更新附件内容主键，拼接成字符串（如“id1#name1,id2#name2,id3#name3”）,将其赋值于UPDATE_DATA
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
	                //获取该小类对应的原附件内容主键，拼接成字符串（如“id1#name1,id2#name2,id3#name3”）,将其赋值于ORIGINAL_DATA
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
		    	//先删除垃圾附件
		    	ide.execute(getSql("deleteAttBySmallType", ("N"+FILE_CODE),smallTypeUsed));
	    	}
	    	
	        //先删除已有的更新明细信息
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
	    //附件信息更新实现
	    public boolean updateAttachment(Connection conn,String packageId,String smalltype, String updatetype) throws DBException {
	    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
	    	if("1".equals(updatetype)){
	    		ide.execute(getSql("updateAttPackageId",packageId,"N"+packageId,smalltype));
	    	}else if("0".equals(updatetype)){
	    		//AttHelper.delAttsOfPackageId(packageId, smalltype, "CI");如果删除会导致查看更新记录时没有更新附件
	    		ide.execute(getSql("updateAttPackageId","D"+packageId,packageId,smalltype));
	    		ide.execute(getSql("updateAttPackageId",packageId,"N"+packageId,smalltype));
	    	}
	    	return true;
	     }
	  //更新附件信息的逻辑删除
	    public boolean changeUpdateAttPackagId(Connection conn,String packageId,String smalltype) throws DBException {
	    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        ide.execute(getSql("updateAttPackageId","D"+packageId,"N"+packageId,smalltype));
	    	return true;
	     }
	  //保存更新审核记录信息
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
	    //更新儿童材料信息表中的更新状态
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

	    	//查询条件
		    String WELFARE_ID = data.getString("WELFARE_ID", null);	//福利院code
			String NAME = data.getString("NAME", null);	//姓名
			String SEX = data.getString("SEX", null);	//性别
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//出生日期开始
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//出生日期开始
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//儿童类型
			String SN_TYPE = data.getString("SN_TYPE", null);	//病残种类
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//体检日期开始
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//体检日期结束
			String UPDATE_STATE = data.getString("UPDATE_STATE", null);	//更新状态
			String UPDATE_DATE_START = data.getString("UPDATE_DATE_START",null);//申请日期开始
			String UPDATE_DATE_END = data.getString("UPDATE_DATE_END",null);//申请日期结束
			String AUDIT_USERNAME = data.getString("AUDIT_USERNAME", null);	//审核人
			String AUDIT_DATE_START = data.getString("AUDIT_DATE_START",null);//审核日期开始
			String AUDIT_DATE_END = data.getString("AUDIT_DATE_END",null);//审核日期结束
			
			//查询条件
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("updateAuditListSt",provinceId,auditType,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,UPDATE_STATE,UPDATE_DATE_START,UPDATE_DATE_END,AUDIT_USERNAME,AUDIT_DATE_START,AUDIT_DATE_END,compositor,ordertype);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	    
	    public DataList updateAuditListZX(Connection conn,String auditType, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {

	    	//查询条件
	    	String PROVINCE_ID = data.getString("PROVINCE_ID", null);	//省份
		    String WELFARE_ID = data.getString("WELFARE_ID", null);	//福利院
			String NAME = data.getString("NAME", null);	//姓名
			String SEX = data.getString("SEX", null);	//性别
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//出生日期开始
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//出生日期开始
			String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//儿童类型
			String SN_TYPE = data.getString("SN_TYPE", null);	//病残种类
			String CHECKUP_DATE_START =  data.getString("CHECKUP_DATE_START", null);//体检日期开始
			String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END",null);//体检日期结束
			String UPDATE_STATE = data.getString("UPDATE_STATE", null);	//更新状态
			String UPDATE_DATE_START = data.getString("UPDATE_DATE_START",null);//申请日期开始
			String UPDATE_DATE_END = data.getString("UPDATE_DATE_END",null);//申请日期结束
			String AUDIT_USERNAME = data.getString("AUDIT_USERNAME", null);	//审核人
			String AUDIT_DATE_START = data.getString("AUDIT_DATE_START",null);//审核日期开始
			String AUDIT_DATE_END = data.getString("AUDIT_DATE_END",null);//审核日期结束
			
			//查询条件
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("updateAuditListZX",auditType,PROVINCE_ID,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,UPDATE_STATE,UPDATE_DATE_START,UPDATE_DATE_END,AUDIT_USERNAME,AUDIT_DATE_START,AUDIT_DATE_END,compositor,ordertype);
	        System.out.println("zxds"+sql);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	    
	  //保存更新明细信息（基本信息）
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
	  //保存更新明细信息（附件信息）
	    public boolean saveAttUpdateDetailStore(Connection conn,DataList attUpdateDetails,String[] smallTypes,String[] updatetypes ,String CUI_ID, String FILE_CODE) throws DBException {
	    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
	    	//根据file_code(即packageId)获取每个小类对应的附件内容
	    	Map<String,DataList> attMap=new BatchAttManager().getAttDataByPackageID("N"+FILE_CODE, "CI");
	    	//遍历smallTypes（小类），构造更新明细数据，同时将smallTypes拼接成字符串，以供删除垃圾附件使用
	    	for(int i=0;i<smallTypes.length;i++){
	    		Data savedata = new Data();
    		    savedata.setEntityName("CMS_CI_UPDATE_DETAIL");
                savedata.add("CUI_ID", CUI_ID);
                savedata.add("UPDATE_FIELD", smallTypes[i]);
                savedata.add("UPDATE_TYPE",updatetypes[i]);
                savedata.add("UPDATE_CLASS","1");
                //获取该小类对应的附件内容主键，拼接成字符串（如“id1,id2,id3”）,将其赋值于UPDATE_DATA
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
