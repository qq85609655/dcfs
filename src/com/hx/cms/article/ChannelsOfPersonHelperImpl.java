package com.hx.cms.article;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

import hx.code.CodeList;
import hx.code.UtilCode;
import hx.tools.helper.IHelper;


/**
 * 
 * @Title: ChannelsOfPersonHelperImpl.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2014-7-28 ÏÂÎç4:58:37
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ChannelsOfPersonHelperImpl implements IHelper {

    @Override
    public CodeList getCodeList(String param) {
        UserInfo ui = SessionInfo.getCurUser();
        String personId = ui.getPerson().getPersonId();
        String sql = "SELECT CC.ID AS VALUE,CC.NAME AS NAME,CC.PARENT_ID AS PARENTVALUE FROM CMS_PERSON_CHANNEL_RELA RC JOIN CMS_CHANNEL CC ON RC.CHANNEL_ID = CC.ID WHERE 1 = 1 AND RC.PERSON_ID = '"+personId+"' AND RC.ROLE = '1' ORDER BY CC.SEQ_NUM ASC";
        System.out.println(sql);
        CodeList cl = UtilCode.getCodeListBySql(null, sql);
        return cl;
    }

}
