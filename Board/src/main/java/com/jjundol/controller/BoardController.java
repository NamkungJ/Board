package com.jjundol.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jjundol.domain.BoardVO;
import com.jjundol.domain.Criteria;
import com.jjundol.domain.PageDTO;
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
	public void getList(Criteria cri, Model model) {
		log.info("[BoardController]getList_getListWithPaging...");
		model.addAttribute("list", service.getList(cri));	// 10개만 조회, 검색타입, 키워드
		
		int total = service.getTotalCnt(cri);	// 전체 게시글 개수
		model.addAttribute("pageMaker",new PageDTO(cri, total));	// cri, total(전체 데이터 개수), new PageDTO(cri, total)->paging관련 파라미터 계산됨->list.jsp
	}
	
	// 게시글 등록 페이지
	@GetMapping
	public void register(Criteria cri, Model model) {
		log.info("[BoardController]register[GET]... : " + cri);
		model.addAttribute("cri", cri);
		
	}
	
	// 게시글 등록
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("[BoardController]register[POST]... : " + board);
		service.register(board);
		rttr.addFlashAttribute("oper_bno", board.getBno());	// redirect 직전 flash에 데이터 저장
		rttr.addFlashAttribute("result", "reg_success");
		return "redirect:/board/list";	// 게시글 목록으로 이동
	}		
	
	// 게시글 읽기 for 조회, 게시글 읽기 for 수정
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model) {		
		// @ModelAttribute : 자동으로 Model에 지정한 이름(cri)으로 담아줌
		
		log.info("[BoardController]get or modify[GET]... : " + bno);
		model.addAttribute("board", service.get(bno));
	}
	
	// 특정 게시글 수정
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("[BoardController]modify[POST]... : " + board);
		log.info("[BoardController]modify[POST]... : " + cri);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("oper_bno", board.getBno());
			rttr.addFlashAttribute("result", "mod_success");
		}
		
		/*
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		*/
		
		return "redirect:/board/list" + cri.getListLink();	// 게시글 목록으로 이동
	}
	
	// 특정 게시글 삭제
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("[BoardController]remove... : " + bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("oper_bno", bno);
			rttr.addFlashAttribute("result", "rmv_success");
		}
		
		/*
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		*/
		
		return "redirect:/board/list" + cri.getListLink();	// 게시글 목록으로 이동
	}
}
