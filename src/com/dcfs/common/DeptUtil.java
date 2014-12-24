package com.dcfs.common;

import java.sql.Connection;

import com.hx.framework.organ.vo.Organ;
import com.hx.framework.sdk.OrganHelper;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

public class DeptUtil extends BaseHandler{
	
	/**
	 * 根据收养组织ID获得收养组织相关信息
	 * @description 
	 * @author MaYun
	 * @date Oct 16, 2014
	 * @param Connection conn 数据库连接
	 * @param String orgID 收养组织ID
	 * @return com.dcfs.common.SyzzDept
	 * @throws DBException 
	 */
	public SyzzDept getSYZZInfo(Connection conn,String orgID) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		Organ organ= new Organ();
		Data organData = new Data();
		SyzzDept syzzData = new SyzzDept();
		
		//如果orgID是组织机构code，则组织机构信息通过以下方法获得
		String organSql = getSql("getOrgan", orgID);
		DataList organList = ide.find(organSql);
		
		if(organList.size()>0){
			organData = organList.getData(0);
			syzzData.setSyzzId(organData.getString("ID"));
			syzzData.setSyzzCode(organData.getString("ORG_CODE"));
			syzzData.setSyzzCnName(organData.getString("CNAME"));
			syzzData.setSyzzEnName(organData.getString("ENNAME"));
			orgID = organData.getString("ID");
		}else{//如果orgID是组织机构ID，则组织机构信息通过以下方法获得
			organ= OrganHelper.getOrganById(orgID);
			syzzData.setSyzzId(orgID);
			syzzData.setSyzzCode(organ.getOrgCode());
			syzzData.setSyzzCnName(organ.getCName());
			syzzData.setSyzzEnName(organ.getEnName());
		}
		
		String sql = getSql("getSyzzInfo", orgID);
		DataList dl = ide.find(sql);
		Data data = new Data();
		
		if(dl.size()>0){
			data = dl.getData(0);
			syzzData.setCountryCode(data.getString("COUNTRY_CODE"));
			syzzData.setCountryCnName(data.getString("COUNTRY_NAME_CN"));
			syzzData.setCountryEnName(data.getString("COUNTRY_NAME_EN"));
			syzzData.setConvention(data.getString("CONVENTION"));
			syzzData.setSolicitSubmissions(data.getString("SOLICIT_SUBMISSIONS"));
			syzzData.setCurrency(data.getString("CURRENCY"));
			syzzData.setLicenseStartvalId(data.getString("LICENSE_STARTVALID"));
			syzzData.setLicenseValId(data.getString("LICENSE_VALID"));
			syzzData.setFoundedDate(data.getString("FOUNDED_DATE"));
			syzzData.setCnstartDate(data.getString("CNSTART_DATE"));
			syzzData.setHeadquarterAddress(data.getString("HEADQUARTER_ADDRESS"));
			syzzData.setMailingAddress(data.getString("MAILING_ADDRESS"));
			syzzData.setTel(data.getString("TEL"));
			syzzData.setFax(data.getString("FAX"));
			syzzData.setWebSite(data.getString("WEBSITE"));
			syzzData.setEmail(data.getString("EMAIL"));
			syzzData.setAuthorDepartment(data.getString("AUTHOR_DEPARTMENT"));
			syzzData.setAdviceGetmethod(data.getString("ADVICE_GETMETHOD"));
			syzzData.setTransFlag(data.getString("TRANS_FLAG"));
			syzzData.setService(data.getString("SERVICE"));
			syzzData.setOtherCountry(data.getString("OTHER_COUNTRY"));
			syzzData.setState(data.getString("STATE"));
			syzzData.setIntroduction(data.getString("INTRODUCTION"));
			syzzData.setRemark(data.getString("REMARK"));
			syzzData.setRecordState(data.getString("RECORD_STATE"));
			syzzData.setAccountLmt(data.getFloat("ACCOUNT_LMT"));
			syzzData.setAccountCurr(data.getFloat("ACCOUNT_CURR"));
		}
		
		return syzzData;
	}
}
