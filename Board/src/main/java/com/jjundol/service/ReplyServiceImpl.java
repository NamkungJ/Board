package com.jjundol.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jjundol.domain.Criteria;
import com.jjundol.domain.ReplyPageDTO;
import com.jjundol.domain.ReplyVO;
import com.jjundol.mapper.BoardMapper;
import com.jjundol.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

/*
 * 댓글에 대한 CRUD 
 */

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
		
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper replyMapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Transactional
	@Override
	public int register(ReplyVO reply) {
		log.info("[ReplyServiceImpl]register.....");
		
		boardMapper.updateReplyCnt(reply.getBno(), 1);
		
		return replyMapper.register(reply);
	}

	@Override
	public ReplyVO select(int rno) {
		log.info("[ReplyServiceImpl]select.....");
		return replyMapper.select(rno);
	}

	@Transactional
	@Override
	public int remove(int rno) {
		log.info("[ReplyServiceImpl]remove.....");
		
		ReplyVO reply = replyMapper.select(rno);
		
		boardMapper.updateReplyCnt(reply.getBno(), -1);
		
		return replyMapper.remove(rno);
	}

	@Override
	public int update(ReplyVO reply) {
		log.info("[ReplyServiceImpl]update.....");
		return replyMapper.update(reply);
	}

	@Override
	public ReplyPageDTO getReplyList(Criteria cri, int bno) {
		log.info("[ReplyServiceImpl]getReplyList.....");
		
		int replyCnt = replyMapper.getCountReplyByBno(bno);
		List<ReplyVO> list = replyMapper.getReplyListWithPaging(cri, bno);
		
		return new ReplyPageDTO(replyCnt, list);
	}	

	

}