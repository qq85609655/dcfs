package com.dcfs.ncm.AZBadvice;

import hx.code.CodeList;
import hx.code.UtilCode;
import hx.tools.helper.IHelper;

public class CountryGovmentCNAllHelperImpl implements IHelper {

    @Override
    public CodeList getCodeList(String param) {
        String sql = "SELECT GOV_ID AS VALUE,NAME_CN AS NAME FROM MKR_COUNTRY_GOVMENT ORDER BY SEQ_NO ASC";
        CodeList cl = UtilCode.getCodeListBySql(null, sql);
        return cl;
    }

}
