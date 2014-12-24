package hx.util;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Random;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class AES {
	public static final String allChar = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

	/**
	 * �ַ�������
	 * 
	 * @param content
	 *            �������ַ���
	 * @param password
	 *            ����
	 * @return
	 */
	public static String encryptStr(String content, String password) {
		return parseByte2HexStr(encrypt(content, password));
	}

	/**
	 * �ַ�������
	 * 
	 * @param content
	 *            �������ַ���
	 * @param password
	 *            ����
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String decryptStr(String content, String password) {
		try {
			return decryptStr(content, password, null);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * �ֽ�����תΪ16���Ƶ��ַ���
	 * @param buf
	 * @return
	 */
	private static String parseByte2HexStr(byte buf[]) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < buf.length; i++) {
			String hex = Integer.toHexString(buf[i] & 0xFF);
			if (hex.length() == 1) {
				hex = '0' + hex;
			}
			sb.append(hex.toUpperCase());
		}
		return sb.toString();
	}
	/**
	 * 16���Ƶ��ַ���ת��Ϊ�ֽ�����
	 * @param hexStr
	 * @return
	 */
	private static byte[] parseHexStr2Byte(String hexStr) {
		if (hexStr.length() < 1)
			return null;
		byte[] result = new byte[hexStr.length() / 2];
		for (int i = 0; i < hexStr.length() / 2; i++) {
			int high = Integer.parseInt(hexStr.substring(i * 2, i * 2 + 1), 16);
			int low = Integer.parseInt(hexStr.substring(i * 2 + 1, i * 2 + 2),
					16);
			result[i] = (byte) (high * 16 + low);
		}
		return result;
	}

	/**
	 * �ַ�������
	 * 
	 * @param content
	 *            ����������
	 * @param password
	 *            ����
	 * @param encoding
	 *            ���뷽ʽ
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String decryptStr(String content, String password,
			String encoding) throws UnsupportedEncodingException {
		if (encoding==null){
			return new String(decrypt(parseHexStr2Byte(content), password),"UTF-8");
		}else{
			return new String(decrypt(parseHexStr2Byte(content), password), encoding);
		}
		
	}

	/**
	 * ����
	 * 
	 * @param content
	 *            ��Ҫ���ܵ�����
	 * @param password
	 *            ��������
	 * @return
	 */
	public static byte[] encrypt(String content, String password) {
		try {
		    SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");  
            secureRandom.setSeed(password.getBytes()); 
			KeyGenerator kgen = KeyGenerator.getInstance("AES");
			kgen.init(128, secureRandom);
			SecretKey secretKey = kgen.generateKey();
			byte[] enCodeFormat = secretKey.getEncoded();
			SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
			Cipher cipher = Cipher.getInstance("AES");// ����������
			byte[] byteContent = content.getBytes("utf-8");
			cipher.init(Cipher.ENCRYPT_MODE, key);// ��ʼ��
			byte[] result = cipher.doFinal(byteContent);
			return result; // ����
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * ����
	 * 
	 * @param content
	 *            ����������
	 * @param password
	 *            ������Կ
	 * @return
	 */
	public static byte[] decrypt(byte[] content, String password) {
		try {
		    SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");  
		    secureRandom.setSeed(password.getBytes());  
			KeyGenerator kgen = KeyGenerator.getInstance("AES");
			kgen.init(128, secureRandom);
			SecretKey secretKey = kgen.generateKey();
			byte[] enCodeFormat = secretKey.getEncoded();
			SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
			Cipher cipher = Cipher.getInstance("AES");// ����������
			cipher.init(Cipher.DECRYPT_MODE, key);// ��ʼ��
			byte[] result = cipher.doFinal(content);
			return result; // ����
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String getRandomPass(int length) {
		StringBuffer sb = new StringBuffer();
		Random random = new Random();
		for (int i = 0; i < length; i++) {
			sb.append(allChar.charAt(random.nextInt(allChar.length())));
		}
		return sb.toString();
	}

	public static void main(String[] args) {
		String key = getRandomPass(100);
		String str = "���Բ��Բ���";
		String pstr = AES.encryptStr(str, key);
		System.out.println(str.length());
		System.out.println(pstr.length());
		System.out.println(pstr);
		String estr;
		estr = AES.decryptStr(pstr, key);
		System.out.println(estr);
		if (str.equals(estr)) {
			System.out.println("OK");
		} else {
			System.out.println("oh NO!");
		}
		
	}
}
