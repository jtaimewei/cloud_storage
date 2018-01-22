package com.autumn.file.model;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component
public class Share {
	
	private int shareid;     //分享id （自增）
	private String username; //分享人的username；
	private int  subfolderid; //文件者的所有者的
	private String sharename; //分享文件的名字
	private  Date sharedate; //分享的时间
	private Date shareoverdate; //分享的截止时间
	private int sharestate; //分享公开 0：  1：分享加密
	private String sharefield;  //分享的标识 UUID
	private String sharepassword; //分享的提取码 UUID 
	private  int  sharedaynumber;//分享的时间
	public int getShareid() {
		return shareid;
	}
	public void setShareid(int shareid) {
		this.shareid = shareid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getSubfolderid() {
		return subfolderid;
	}
	public void setSubfolderid(int subfolderid) {
		this.subfolderid = subfolderid;
	}
	public String getSharename() {
		return sharename;
	}
	public void setSharename(String sharename) {
		this.sharename = sharename;
	}
	public Date getSharedate() {
		return sharedate;
	}
	public void setSharedate(Date sharedate) {
		this.sharedate = sharedate;
	}
	public Date getShareoverdate() {
		return shareoverdate;
	}
	public void setShareoverdate(Date shareoverdate) {
		this.shareoverdate = shareoverdate;
	}
	public int getSharestate() {
		return sharestate;
	}
	public void setSharestate(int sharestate) {
		this.sharestate = sharestate;
	}
	public String getSharefield() {
		return sharefield;
	}
	public void setSharefield(String sharefield) {
		this.sharefield = sharefield;
	}
	public String getSharepassword() {
		return sharepassword;
	}
	public void setSharepassword(String sharepassword) {
		this.sharepassword = sharepassword;
	}
	public int getSharedaynumber() {
		return sharedaynumber;
	}
	public void setSharedaynumber(int sharedaynumber) {
		this.sharedaynumber = sharedaynumber;
	}
	
	

}
