package com.hx.cms.tags;

import hx.database.databean.Data;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.channel.vo.Channel;

/**
 * 
 * @Title: ChannelStyleTag.java
 * @Description: 频道样式<br>
 *               1 普通栏目
 *               2 虚拟栏目
 *               3 外部链接 <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 10:18:51 AM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ChannelStyleTag extends TagSupport {
    
    /**
     * 序列化
     */
    private static final long serialVersionUID = 330680087521827763L;

    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
     * 开始标签
     */
    @Override
    public int doStartTag() throws JspException {
        Tag tag = getParent();
        //输出内容
        String html = "";
        
        try {
            if(tag instanceof ChannelListTag){
                ChannelListTag channelListTag = (ChannelListTag) tag;
                //得到当前循环到的Data元素
                Data data = channelListTag.getData();
                //栏目样式
                html = data.getString(Channel.CHANNEL_STYLE);
            }
            pageContext.getOut().println(html);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }
}
