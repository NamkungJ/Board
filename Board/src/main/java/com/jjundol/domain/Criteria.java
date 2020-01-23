package com.jjundol.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

/*
 * 조회(페이징, 검색) 처리용 파라미터 객체
 */
@Data
public class Criteria {
	private int pageNum;	// 페이지 변호 
	private int amount;		// 조회개수/화면
	
	private String type;	// 검색조건
	private String keyword;	// 검색키워드
	
	public Criteria() {
		this(1, 10);
	}
	
	public Criteria(int pageNum, int amout) {
		this.pageNum = pageNum;
		this.amount = amout;
	}
	
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
	}
	
}
