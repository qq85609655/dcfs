package com.hx.cms;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

import hx.code.CodeList;
import hx.code.UtilCode;
import hx.tools.helper.IHelper;

public class SecurityLevelHelperImpl implements IHelper {

    @Override
    public CodeList getCodeList(String param) {
        UserInfo ui = SessionInfo.getCurUser();
        String level = ui.getPerson().getSecretLevel();
        String sql = "SELECT CODEVALUE AS VALUE,CODENAME AS NAME FROM BZ_CODE WHERE CODESORTID='SECURITY_LEVEL' AND CODEVALUE <= '"+level+"' ORDER BY PNO ASC";
        CodeList cl = UtilCode.getCodeListBySql(null, sql);
        return cl;
    }

}
