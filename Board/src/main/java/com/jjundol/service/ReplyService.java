package com.jjundol.service;

import com.jjundol.domain.Criteria;
import com.jjundol.domain.ReplyPageDTO;
import com.jjundol.domain.ReplyVO;

public interface ReplyService {
	
	// 댓글 등록
	public int register(ReplyVO reply);
		
	// 댓글 조회
	public ReplyVO select(int rno);
	
	// 댓글 삭제
	public int remove(int rno);
	
	// 댓글 수정
	public int update(ReplyVO reply);
	
	// 댓글 목록 조회, 페이징
	public ReplyPageDTO getReplyList(Criteria cri, int bno);

}
