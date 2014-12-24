package com.dcfs.ncm.SYZZadvice;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

import hx.code.CodeList;
import hx.code.UtilCode;
import hx.tools.helper.IHelper;

public class CountryGovmentHelperImpl implements IHelper {

    @Override
    public CodeList getCodeList(String param) {
        UserInfo ui = SessionInfo.getCurUser();
        String orgCode = ui.getCurOrgan().getOrgCode();
        String sql = "SELECT CG.GOV_ID AS VALUE,CG.NAME_EN AS NAME FROM MKR_COUNTRY_GOVMENT CG LEFT JOIN PUB_ORGAN O ON O.AREA_CODE=CG.COUNTRY_CODE WHERE O.ORG_CODE='"+orgCode+"' ORDER BY CG.SEQ_NO ASC";
        CodeList cl = UtilCode.getCodeListBySql(null, sql);
        return cl;
    }

}
