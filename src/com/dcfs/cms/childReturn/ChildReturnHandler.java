package com.dcfs.cms.childReturn;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

public class ChildReturnHandler extends BaseHandler{
	 public DataList returnListFLY(Connection conn, String oId, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {

	    	//查询条件
			String NAME = data.getString("NAME", null);	//姓名
			String SEX = data.getString("SEX", null);	//性别
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//出生日期开始
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//出生日期开始
			String APPLE_DATE_START = data.getString("APPLE_DATE_START",null);//申请日期开始
			String APPLE_DATE_END = data.getString("APPLE_DATE_END",null);//申请日期结束
			//String APPLE_TYPE = data.getString("APPLE_TYPE", null);	//退材料类型
			//String RETURN_STATE = data.getString("RETURN_STATE", null);	//退材料状态
			String BACK_TYPE = data.getString("BACK_TYPE", null);	//退材料分类/退文类型
			String BACK_RESULT = data.getString("BACK_RESULT", null);	//状态/退材料结果 null时未确认 1时已确认
			String RETURN_REASON = data.getString("RETURN_REASON", null);	//退材料原因
			if("0".equals(BACK_RESULT)){
				BACK_RESULT="AND A.BACK_RESULT IS NULL";
			}else if("1".equals(BACK_RESULT)){
				BACK_RESULT="AND A.BACK_RESULT='1'";
			}
			//查询条件
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("returnListFLY",oId,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,APPLE_DATE_START,APPLE_DATE_END,BACK_TYPE,BACK_RESULT,RETURN_REASON,compositor,ordertype);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	 public DataList returnListST(Connection conn, String oCode, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {
		    //查询条件
			String NAME = data.getString("NAME", null);	//姓名
			String SEX = data.getString("SEX", null);	//性别
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//出生日期开始
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//出生日期开始
			String WELFARE_ID = data.getString("WELFARE_ID",null);//福利院code
			String APPLE_DATE_START = data.getString("APPLE_DATE_START",null);//申请日期开始
			String APPLE_DATE_END = data.getString("APPLE_DATE_END",null);//申请日期结束
			//String APPLE_TYPE = data.getString("APPLE_TYPE", null);	//退材料类型
			//String RETURN_STATE = data.getString("RETURN_STATE", null);	//退材料状态
			String BACK_TYPE = data.getString("BACK_TYPE", null);	//退材料分类/退文类型
			String BACK_RESULT = data.getString("BACK_RESULT", null);	//状态/退材料结果 null时未确认 1时已确认
			String RETURN_REASON = data.getString("RETURN_REASON", null);	//退材料原因
			if("0".equals(BACK_RESULT)){
				BACK_RESULT="AND A.BACK_RESULT IS NULL";
			}else if("1".equals(BACK_RESULT)){
				BACK_RESULT="AND A.BACK_RESULT='1'";
			}
			//查询条件
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("returnListST",oCode,WELFARE_ID,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,APPLE_DATE_START,APPLE_DATE_END,BACK_TYPE,BACK_RESULT,RETURN_REASON,compositor,ordertype);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	 public DataList returnListZX(Connection conn, Data data,
	            int pageSize, int page, String compositor, String ordertype)
	            throws DBException {
		    //查询条件
			String NAME = data.getString("NAME", null);	//姓名
			String SEX = data.getString("SEX", null);	//性别
			String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//出生日期开始
			String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//出生日期开始
			String PROVINCE_ID = data.getString("PROVINCE_ID",null);//省份
			String WELFARE_ID = data.getString("WELFARE_ID",null);//福利院
			String APPLE_DATE_START = data.getString("APPLE_DATE_START",null);//申请日期开始
			String APPLE_DATE_END = data.getString("APPLE_DATE_END",null);//申请日期结束
			//String APPLE_TYPE = data.getString("APPLE_TYPE", null);	//退材料类型
			//String RETURN_STATE = data.getString("RETURN_STATE", null);	//退材料状态
			String BACK_TYPE = data.getString("BACK_TYPE", null);	//退材料分类/退文类型
			String BACK_RESULT = data.getString("BACK_RESULT", null);	//状态/退材料结果 null时未确认 1时已确认
			String RETURN_REASON = data.getString("RETURN_REASON", null);	//退材料原因
			if("0".equals(BACK_RESULT)){
				BACK_RESULT="AND A.BACK_RESULT IS NULL";
			}else if("1".equals(BACK_RESULT)){
				BACK_RESULT="AND A.BACK_RESULT='1'";
			}
			//查询条件
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("returnListZX",PROVINCE_ID,WELFARE_ID,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,APPLE_DATE_START,APPLE_DATE_END,BACK_TYPE,BACK_RESULT,RETURN_REASON,compositor,ordertype);
	        System.out.println(sql);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	  public DataList returnSelectFLY(Connection conn, String oId, Data data,
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
			String AUD_STATE = data.getString("AUD_STATE", null);	//儿童状态
			//查询条件
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("returnSelectFLY",oId,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,AUD_STATE,compositor,ordertype);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	  public DataList returnSelectST(Connection conn, String oId, Data data,
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
			String AUD_STATE = data.getString("AUD_STATE", null);	//儿童状态
			//查询条件
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("returnSelectST",oId,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,AUD_STATE,compositor,ordertype);
	        System.out.println(sql);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	  public DataList returnSelectZX(Connection conn,Data data,
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
			String AUD_STATE = data.getString("AUD_STATE", null);	//儿童状态
			//查询条件
			
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        String sql = getSql("returnSelectZX",PROVINCE_ID,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,CHECKUP_DATE_START,CHECKUP_DATE_END,AUD_STATE,compositor,ordertype);
	        DataList dl = ide.find(sql, pageSize, page);
	        return dl;
	    }
	 //根据儿童材料主键获取儿童材料基本信息
	 public Data getChildInfoById(Connection conn, String ci_id) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = new DataList();
	        dataList = ide.find(getSql("getChildInfoById", ci_id));
	        return dataList.getData(0);
	         
	    }
	 //根据儿童材料退材料主键获取退材料信息及儿童信息
	 public Data getConfirmDataByID(Connection conn, String AR_ID) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = new DataList();
	        dataList = ide.find(getSql("getConfirmDataByID", AR_ID));
	        return dataList.getData(0);
	    }
	 
	 public boolean save(Connection conn, Data data) throws DBException {
    	 String CI_ID=data.getString("CI_ID",null);
    	 if(CI_ID==null){
    		 return false;
    	 }
    	 data.setConnection(conn);
    	 data.setEntityName("RFM_CI_REVOCATION");
    	 data.setPrimaryKey("AR_ID");
    	 String id=data.getString("AR_ID", null);
    	 if(id==null){
    		 data.create();
    	 }else{
    	     data.store();
    	 }
	    return true;
     }
	//获取年龄超过17岁的儿童材料
	//查询条件为：儿童材料已提交;审核状态不为省不通过、中心不通过;退材料状态为空;儿童匹配状态不为1（已匹配）;儿童发布状态不为4(已申请);儿童发布状态不为3（锁定）
	 public DataList findChildAgeOutSeventeen(Connection conn, String time) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = new DataList();
	        dataList = ide.find(getSql("findChildAgeOutSeventeen", time));
	        return dataList;
	    }
}
