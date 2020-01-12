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
	                <div class="panel-heading">게시글 수정</div>
	                <div class="panel-body">
		                <form id="modForm" role="form" action='/board/modify' method="POST">
		                	<div class="form-group">
	                           <label>번호</label>
	                           <input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly" >
	                       	</div>	                	
	                       	<div class="form-group">
	                           <label>제목</label>
	                           <input class="form-control" name="title" value='<c:out value="${board.title}"/>'>
	                       	</div>
	                       	<div class="form-group">
	                           <label>내용</label>
	                           <textarea class="form-control" rows="3" name="content"><c:out value="${board.content}"/></textarea>
	                       	</div>
	                       	<div class="form-group">
	                           <label>작성자</label>
	                           <input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly" >
	                    	</div>
	                    	
	                    	<div class="form-group" hidden="ture">
	                           <label>등록일</label>
	                           <input class="form-control" name="regdate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>' readonly="readonly" >
	                    	</div>
	                    	<div class="form-group" hidden="ture">
	                           <label>수정일</label>
	                           <input class="form-control" name="updatedate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updatedate}"/>' readonly="readonly" >
	                    	</div>
						</form>
						<button type="submit" data-oper="modify" class="btn btn-info">수정</button>
                       	<button type="submit" data-oper="remove" class="btn btn-danger">삭제</button>
                       	<button type="submit" data-oper="list" class="btn btn-default">목록</button>
	                </div>
	             </div>
	         </div>
     	</div>
	</div>
<%@include file="../include/footer.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		var modFormObj = $("#modForm");
		
		$('button').on("click", function(e) {
			e.preventDefault();
			
			var operation = $(this).data("oper");	// data-oper 속성	
			
			if(operation === 'remove') {
				modFormObj.attr("action", "/board/remove");		// 삭제처리
			}
			else if(operation === 'list') {				
				modFormObj.attr("action", "/board/list").attr("method", "GET");	// 목록화면 이동
				modFormObj.empty();
				//self.location = '/board/list';
				//return;
			}
			
			modFormObj.submit();
		});
		
	});
</script>