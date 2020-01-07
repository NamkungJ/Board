package com.jjundol.mapper;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.jjundol.domain.BoardVO;
import com.jjundol.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	/*
	@Test
	public void getList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	*/
	
	/*
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글!!!");
		board.setContent("새로 작성하는 내용!!");
		board.setWriter("새작성자2");
		
		mapper.insert(board);
		
		log.info("testInsert : " + board);
	}
	*/
	/*
	@Test
	public void testInsertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글 SelectKey!");
		board.setContent("새로 작성하는 내용 SelectKey!");
		board.setWriter("새작성자2");
		
		mapper.insertSelectKey(board);
		
		log.info("testInsertSelectKey : " + board);
	}
	*/
	/*
	@Test
	public void testRead() {
		BoardVO board = mapper.read(10);		
		log.info("testRead : " + board);
	}
	*/
	/*
	@Test
	public void testDelete() {
		int result = mapper.delete(7);		
		log.info("testDelete : " + result);
	}
	*/
	/*
	@Test
	public void testUpdate() {
		
		BoardVO board = new BoardVO();
		
		board.setBno(6);
		board.setTitle("제목 수정!");
		board.setContent("내용 수정~~~~~~!!!");
		board.setWriter("user02");
		
		int result = mapper.update(board);
		log.info("testUpdate : " + result);
	}
	*/
	/*
	@Test
	public void testExits() {
		log.info(service);
		assertNotNull(service);
	}
	*/
	/*
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();		
		board.setTitle("Service 테스트");
		board.setContent("Service 테스트 내용 !!!");
		board.setWriter("user03");
		service.register(board);		
		
		log.info("testRegister : " + board.getBno());
	}
	*/
	/*
	@Test
	public void testRemove() {			
		log.info("testRemove : " + service.remove(5));
	}
	*/
	
	@Test
	public void testUpdate() {
		
		BoardVO board = service.get(6);
		
		if(board == null) {
			log.info("\"testUpdate : 게시물없음");
			return;
		}
		board.setTitle("제목을 수정합니다.");		
		log.info("testUpdate : " + service.modify(board));
	}
	
}
