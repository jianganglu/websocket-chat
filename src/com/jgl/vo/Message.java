package com.jgl.vo;

import java.util.Date;
import java.util.List;

import com.google.gson.Gson;

public class Message {

	private String welcome;
	
	private List<String> usernames;
	
	private String content;
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public void setContent(String name, String msg) {
		this.content = name + " " + new Date().toLocaleString() + ":<br/>"
			+ msg + "<br/>";
	}

	public String getWelcome() {
		return welcome;
	}

	public void setWelcome(String welcome) {
		this.welcome = welcome;
	}

	public List<String> getUsernames() {
		return usernames;
	}

	public void setUsernames(List<String> usernames) {
		this.usernames = usernames;
	}
	
	public Message() {
		super();
	}
	
	public String toJson() {
		
		return gson.toJson(this);
		
	}
	
	public static Gson gson = new Gson();
}
