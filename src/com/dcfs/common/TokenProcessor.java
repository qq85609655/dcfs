package com.dcfs.common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * TokenProcess����һ��������
 * 
 * @author mayun
 * 
 */
public class TokenProcessor {
	static final String TOKEN_KEY = "token";

	private static TokenProcessor instance = new TokenProcessor();

	/**
	 * getInstance()�����õ�������ʵ��
	 */
	public static TokenProcessor getInstance() {
		return instance;
	}

	/**
	 * ���һ����������ֵ��ʱ���
	 */
	private long previous;

	/**
	 * �ж���������е�����ֵ�Ƿ���Ч
	 */
	public synchronized boolean isTokenValid(HttpServletRequest request) {
		// �õ�����ĵ�ǰsession����
		HttpSession session = request.getSession(false);
		if (session == null) {
			return false;
		}

		// ��session��ȡ�����������ֵ
		String saved = (String) session.getAttribute(TOKEN_KEY);
		if (saved == null) {
			return false;
		}

		// ���session�е�����ֵ
		resetToken(request);

		// �õ���������е�����ֵ
		String token = request.getParameter(TOKEN_KEY);
		if (token == null) {
			return false;
		}

		return saved.equals(token);
	}

	/**
	 * ���session�е�����ֵ
	 */
	public synchronized void resetToken(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session == null) {
			return;
		}
		session.removeAttribute(TOKEN_KEY);
	}

	/**
	 * ����һ���µ�����ֵ �����浽session�� �����ǰsesison�����ڣ��򴴽�һ���µĵ�session
	 */
	public synchronized void saveToken(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		String token = generateToken(request);
		if (token != null) {
			session.setAttribute(TOKEN_KEY, token);
		}
	}

	/**
	 * �����û��Ựid�͵�ǰϵͳʱ������һ��Ψһ������
	 */
	public synchronized String generateToken(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		try {
			byte id[] = session.getId().getBytes();
			long current = System.currentTimeMillis();
			if (current == previous) {
				current++;

			}
			previous = current;
			byte now[] = new Long(current).toString().getBytes();
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(id);
			md.update(now);
			return toHex(md.digest());
		} catch (NoSuchAlgorithmException e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * ��һ���ֽ�����ת��һ��ʮ���������ֵ��ַ���
	 * 
	 * @param buffer
	 * @return
	 */
	private String toHex(byte buffer[]) {
		StringBuffer sb = new StringBuffer(buffer.length * 2);
		for (int i = 0; i < buffer.length; i++) {
			sb.append(Character.forDigit((buffer[i] & 0xf0) >> 4, 16));
			sb.append(Character.forDigit(buffer[i] & 0x0f, 16));
		}

		return sb.toString();
	}

	/**
	 * ��Session�еõ�����ֵ�����Session��û������ֵ ��������һ���µ�����ֵ
	 */
	public synchronized String getToken(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (null == session)
			return null;

		String token = (String) session.getAttribute(TOKEN_KEY);

		if (null == token) {
			token = generateToken(request);
			if (token != null) {
				session.setAttribute(TOKEN_KEY, token);
				return token;
			} else
				return null;
		} else
			return token;
	}
}
