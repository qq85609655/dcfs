package com.dcfs.common.atttype;

import javax.servlet.http.HttpServletRequest;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.adapter.UserAdapter;
/**
 * �򹫹��������ﱣ�������IDʵ����
 * @description 
 * @author MaYun
 * @date Aug 1, 2014
 * @return
 */

public class UploadUserInfo implements UserAdapter {

	@Override
	public String getCurrentUserName(HttpServletRequest request) {
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
		return personId;
	}

}
