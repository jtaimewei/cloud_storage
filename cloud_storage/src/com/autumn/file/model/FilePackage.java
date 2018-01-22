package com.autumn.file.model;

import org.springframework.stereotype.Component;

@Component
public class FilePackage {
	private String username;
	private int page;
	private int pagenumber;
	private int folderfatherid;
	
	
	public int getFolderfatherid() {
		return folderfatherid;
	}
	public void setFolderfatherid(int folderfatherid) {
		this.folderfatherid = folderfatherid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getPagenumber() {
		return pagenumber;
	}
	public void setPagenumber(int pagenumber) {
		this.pagenumber = pagenumber;
	}
	
	
}
