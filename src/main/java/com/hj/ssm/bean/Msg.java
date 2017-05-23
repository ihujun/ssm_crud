package com.hj.ssm.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * ���ص���Ϣ��
 * @author Administrator
 *
 */
public class Msg {

	//0:ʧ�ܣ�1:�ɹ�
	private int code;
	
	//������Ϣ
	private String msg;
	
	//�Զ�����Ϣ
	private Map<String,Object> info = new HashMap<String,Object>();

	
	public static Msg success(){
		Msg msg = new Msg();
		msg.setCode(1);
		msg.setMsg("�����ɹ�");
		return msg;
	}
	
	public static Msg fail(){
		Msg msg = new Msg();
		msg.setCode(0);
		msg.setMsg("����ʧ��");
		return msg;
	}
	
	
	public Msg add(String k,Object v){
		this.info.put(k, v);
		return this;
	}
	
	
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getInfo() {
		return info;
	}

	public void setInfo(Map<String, Object> info) {
		this.info = info;
	}
}
