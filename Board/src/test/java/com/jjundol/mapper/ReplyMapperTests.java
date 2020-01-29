package com.jjundol.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.jjundol.domain.Criteria;
import com.jjundol.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	/*
	@Test
	public void testMapper() {
		log.info("testMapper : " + mapper);
	}
	*/
	/*
	@Test
	public void register() {		
		ReplyVO reply = new ReplyVO();
		
		reply.setBno(32768);
		reply.setReply("댓글 테스트");
		reply.setReplyer("replyer00");
		
		mapper.register(reply);		
	}
	*/
	/*
	@Test
	public void select() {		
		int rno = 2;
		ReplyVO reply = mapper.select(rno);
		log.info("select : " + reply);		
	}
	*/
	/*
	@Test
	public void remove() {	
		int rno = 3;
		mapper.remove(rno);	
	}
	*/
	/*
	@Test
	public void update() {		
		int rno = 2;
		ReplyVO reply = mapper.select(rno);
		log.info("select_update : " + reply);
		
		reply.setReply("REPLY UPDATE!");
		mapper.update(reply);				
	}
	*/
	@Test
	public void getReplyListWithPaging() {
		int bno = 32768;
		Criteria cri = new Criteria();
		List<ReplyVO> replies =  mapper.getReplyListWithPaging(cri, bno);
		replies.forEach(reply -> log.info(reply));
	}
	
	
}
