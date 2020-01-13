package com.jjundol.domain;

import lombok.Data;

@Data
public class PageDTO {
	
	private int startPage;	// 펏번째 페이지 번호
	private int endPage;	// 마지막 페이지 번호
	private boolean prev, next;		// 이전, 다음으로 이동가능한 표시 여부
	
	private Criteria cri;
	private int total;		// 전체 데이터 개수	
	
	public PageDTO(Criteria cri, int total) {
				
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		this.startPage = this.endPage -9;
		
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;		
	}
	
	
	
}
