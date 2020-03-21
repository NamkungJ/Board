<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../include/header.jsp" %>
	<div id="page-wrapper">
		<div class="row">
		    <div class="col-lg-12">
		        <h1 class="page-header">게시판</h1>
		    </div>
		</div>
		<div class="row">
	        <div class="col-lg-12">
	            <div class="panel panel-default">
	                <div class="panel-heading">게시글</div>
	                <div class="panel-body">
	                	<div class="form-group">
                           <label>번호</label>
                           <input class="form-control" name="bno" readonly="readonly" value='<c:out value="${board.bno}"/>'>   
                       </div>	                	
                       <div class="form-group">
                           <label>제목</label>
                           <input class="form-control" name="writer" readonly="readonly" value='<c:out value="${board.title}"/>'>
                       </div>
                       <div class="form-group">
                           <label>내용</label>
                           <textarea class="form-control" rows="3" name="content" readonly="readonly"><c:out value="${board.content}"/></textarea>
                       </div>
                       <div class="form-group">
                           <label>작성자</label>
                           <input class="form-control" name="writer" readonly="readonly" value='<c:out value="${board.writer}"/>'>
                       </div>
                       
                       <form id="operForm" role="form" action="/board/modify" method="GET">                       		
                           <input id="bno" type="hidden" class="form-control" name="bno" value='<c:out value="${board.bno}"/>'>
                           <input id="pageNum" type="hidden" class="form-control" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
                           <input id="amount" type="hidden" class="form-control" name="amount" value='<c:out value="${cri.amount}"/>'>
                           <input id="type" type="hidden" class="form-control" name="type" value='<c:out value="${cri.type}"/>'>
                           <input id="keyword" type="hidden" class="form-control" name="keyword" value='<c:out value="${cri.keyword}"/>'>
                       </form>
                       <button type="submit" data-oper="list" class="btn btn-default">목록</button>                      
                       <button type="submit" data-oper="modify" class="btn btn-default">수정</button>
                       <!--<button data-oper="list" class="btn btn-default" onclick="location.href='/board/list'">목록</button>
                       <button data-oper="modify" class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}" />'">수정</button> -->
	                </div>
	             </div>
	         </div>
     	</div>
     	<div class="row">
		    <div class="col-lg-12">
		        <div class="panel panel-default">
		        	<div class="panel-heading"><i class="fa fa-comments fa-fw"></i> 댓글
		        	<button id="addReplyBtn" class="btn, btn-primary btn-xs pull-right">댓글달기</button></div>
	                <div class="panel-body">
	                	<ul class="chat">	                		
	                	</ul>
	                </div>
	                <div class="panel-footer reply-page-footer">	                	
	                </div>
		        </div>
		    </div>
		</div>
	</div>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">            
                <div class="modal-body">
                	<div class="form-group">
                		<label>댓글</label>
                		<input class="form-control" name='reply' value="새로운 댓글">
                	</div>
                	<div class="form-group">
                		<label>등록자</label>
                		<input class="form-control" name='replyer' value="replyer">
                	</div>
                	<div class="form-group">
                		<label>등록일</label>
                		<input class="form-control" name='replyDate' value="">
                	</div>
                </div>
                <div class="modal-footer">
	               <button id="modalModBtn" type="button" class="btn btn-warning" data-dismiss="modal">수정</button>
	               <button id="modalRemoveBtn" type="button" class="btn btn-danger" data-dismiss="modal">삭제</button>
	               <button id="modalRegisterBtn" type="button" class="btn btn-primary" data-dismiss="modal">등록</button>
                   <button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">닫기</button>                             
                </div>
            </div>
        </div>
    </div>    	
<%@include file="../include/footer.jsp" %>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var operFormObj = $('#operForm');
		
		// modify
		$("button[data-oper='modify']").on("click", function() {
			operFormObj.attr("action", "/board/modify").submit();
		});
		
		// list
		$("button[data-oper='list']").on("click", function() {
			operFormObj.find('#bno').remove();	//  bno값 넘길필요없음
			operFormObj.attr("action", "/board/list").submit();
			//self.location = '/board/list';
		});
	});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		
		var bnoValue = '<c:out value="${board.bno}"/>';
		var replyUL = $(".chat");
		
		showList(1);
		
		// 댓글 목록
		function showList(page) {
			
			console.log("showList : " + page);
			var param = { bno : bnoValue, page : page || 1 };
			
			replyService.getList(param, function(replyCnt, list){
				
				console.log("replyCnt : " + replyCnt);
				console.log("replyCnt : " + list);
				
				if(page == -1) {	// 마지막 페이지 이동
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
				var str = "";				
				if(list == null || list.lenth == 0){					
					return;
				}
				
				for(var i = 0, len = list.length || 0; i < len; i++) {
					str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
					str += "<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
					str += "<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";					
					str += "<p>"+list[i].reply+"</p></div></li>";
				}
				replyUL.html(str);
				
				showReplyPageFooter(replyCnt);
			});					
		
		}
				
		
		var pageNum = 1;
		var replyPageFooter = $(".reply-page-footer");
		
		replyPageFooter.on("click", "li a", function(e) {
			e.preventDefault();			
			
			var targetPageNum = $(this).attr("href");
			console.log("Page Click / targetPageNum : " + targetPageNum);
			
			pageNum = targetPageNum;
			showList(pageNum);
			
		});
		
		function showReplyPageFooter(replyCnt) {
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum -9;
			
			var prev = startNum != 1
			var next = false;
			
			if(endNum * 10 > replyCnt) {
				endNum = Math.ceil(replyCnt/10.0);				
			}
			
			if(endNum * 10 < replyCnt) {
				next = true;
			}
			
			var str = "<ul class='pagination pull-right'>";
			
			if(prev) {
				str += "<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
			}
			
			for(var i = startNum ; i <= endNum ; i++) {
				var active = pageNum == i ? "active":"";				
				str += "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
			}
			
			if(next) {
				str += "<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
			}
			
			str += "</ul></div>";
			
			console.log(str);
			
			replyPageFooter.html(str);
			
		}
		
		// 댓글 등록 Modal
		var modal = $('.modal');
		var modalInputReply = modal.find("input[name = 'reply']");
		var modalInputReplyer = modal.find("input[name = 'replyer']");
		var modalInputReplyDate = modal.find("input[name = 'replyDate']");
		
		var modelModBtn = $('#modalModBtn');
		var modelRemoveBtn = $('#modalRemoveBtn');
		var modalRegisterBtn = $('#modalRegisterBtn');
		
		$('#addReplyBtn').on("click", function(e) {
			
			modal.find("input").val('');
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalRegisterBtn.show();
			
			$(".modal").modal("show");
		});
		
		// 댓글 등록
		modalRegisterBtn.on("click", function(e) {
			
			reply = {
					reply : modalInputReply.val(),
					replyer : modalInputReplyer.val(),
					bno:bnoValue
			}
			
			replyService.add(reply, function(result){
				modal.find("input").val("");
				modal.modal("hide");
				// showList(1); // 댓글 등록 후 목록 갱신
				showList(-1); // 마지막 댓글 페이지로 이동
			});
		});
		
		// 댓글 click Event
		$(".chat").on("click", "li", function(e) {
			
			var rno = $(this).data("rno");
			replyService.get(rno, function(result) {
				modalInputReply.val(result.reply);
				modalInputReplyer.val(result.replyer);
				modalInputReplyDate.val(replyService.displayTime(result.replyDate)).attr("readonly", "readonly");
				modal.data("rno", result.rno);	// 수정, 삭제를 위한 data-rno생성
				
				modal.find("button[id = 'modalRegisterBtn']").hide();
				$(".modal").modal("show");
			});
		
		});
		
		// 댓글 수정
		modelModBtn.on("click", function(e) {
			
			var reply = { rno : modal.data("rno"), reply : modalInputReply.val() }
				
			replyService.update( reply, function(result){
					alert("댓글이 수정되었습니다.");
					modal.modal("hide");					
					showList(pageNum);
				}
			);
			
		});
		
		// 댓글 삭제
		modelRemoveBtn.on("click", function(e) {
			
			var rno = modal.data("rno");
			
			replyService.remove(rno, function(result){
					if(result === "success") {
						alert("댓글이 삭제되었습니다.");
						modal.modal("hide");
						showList(pageNum);
					}
				}
			);
		});
	});
</script>