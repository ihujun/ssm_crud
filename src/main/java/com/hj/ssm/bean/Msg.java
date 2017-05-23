package com.hj.ssm.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 返回的信息类
 * @author Administrator
 *
 */
public class Msg {

	//0:失败，1:成功
	private int code;
	
	//错误信息
	private String msg;
	
	//自定义信息
	private Map<String,Object> info = new HashMap<String,Object>();

	
	public static Msg success(){
		Msg msg = new Msg();
		msg.setCode(1);
		msg.setMsg("操作成功");
		return msg;
	}
	
	public static Msg fail(){
		Msg msg = new Msg();
		msg.setCode(0);
		msg.setMsg("操作失败");
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
