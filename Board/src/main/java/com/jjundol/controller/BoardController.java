package com.jjundol.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jjundol.domain.BoardVO;
import com.jjundol.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

/*
 * 게시글 Controller
 */

@Controller
@Log4j
@RequestMapping("/board/*")
//@AllArgsConstructor
public class BoardController {
	
	//private BoardService service; 	//@AllArgsConstructor
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	// 전체 게시글 조회
	@GetMapping("/list")
	public void getList(Model model) {
		log.info("[BoardController]getList...");
		model.addAttribute("list", service.getList());
	}
	
	// 게시글 등록
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("[BoardController]register... : " + board);
		service.register(board);
		
		rttr.addFlashAttribute("result", board.getBno()); // redirect 직전 flash에 데이터 저장
		return "redirect:/board/list";	// 게시글 목록으로 이동
	}
	
	// 특정 게시글 읽기
	@GetMapping("/get")
	public void get(@RequestParam("bno") int bno, Model model) {
		log.info("[BoardController]read... : " + bno);
		model.addAttribute("board", service.get(bno));
	}
	
	// 특정 게시글 수정
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		log.info("[BoardController]read... : " + board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "mod_success");
		}
		return "redirect:/board/list";	// 게시글 목록으로 이동
	}
	
	// 특정 게시글 삭제
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") int bno, RedirectAttributes rttr) {
		log.info("[BoardController]remove... : " + bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result", "rmv_success");
		}
		return "redirect:/board/list";	// 게시글 목록으로 이동
	}
}
