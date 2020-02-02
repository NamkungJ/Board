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
		
		/*
		// 댓글 등록
		replyService.add(
			{ reply:"JS TEST", replyer:"TESTER", bno:bnoValue },
			function(result){
				alert("RESULT : " + result);
			}
		);
		
		// 댓글 목록
		replyService.getList(
			{ bno:bnoValue, page:1 },
			function(list){
				for(var i = 0, len = list.length||0; i < len; i++) {
					console.log(list[i]);
				}
			}
		);
		
		// 댓글 삭제
		replyService.remove(
			35,
			function(result){
				if(result === "success") {
					alert("DELETE RESULT : " + rno);
				}
			},
			function(err){
				alert("DELETE ERROR");
			}
		);
		
		// 댓글 수정
		replyService.update(
			{ rno:21, bno:bnoValue, reply:"JS UPDATE!" },
			function(result){
				alert("UPDATE RESULT : " + result);
			}
		);
		*/
		
		// 댓글 조회
		replyService.get(
			37, function(data) {
				console.log("get : " + data);
			}
		);
		
	});
</script>