package com.autumn.file.model;

import org.springframework.stereotype.Component;


@Component
public class PagingInfo {
	private int countnumber;//总数量
	private int number;     //每一页的数量
	private int pagenumber;//总页数
	private int page;//页码
	private int datanumber;//第几条数据
	
	
	public int getCountnumber() {
		return countnumber;
	}
	public void setCountnumber(int countnumber) {
		this.countnumber = countnumber;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public int getPagenumber() {
		if(this.countnumber%this.number==0){
			this.pagenumber=(this.countnumber/this.number);
		}else {
			this.pagenumber=(this.countnumber/this.number)+1;
		}
		return this.pagenumber;
	}
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getDatanumber() {
		this.datanumber=(this.page-1)*this.number;
		return this.datanumber;
	}
	public void setDatanumber(int datanumber) {
		this.datanumber = datanumber;
	}
	
	
	

}
