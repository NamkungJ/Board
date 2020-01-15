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
                <div class="panel-heading">게시글 작성</div>
                <div class="panel-body">
                	<form id="regForm" role="form" action="/board/register" method="POST">
                       <div class="form-group">
                           <label>제목</label>
                           <input class="form-control" name="title" placeholder="제목을 입력하세요...">   
                       </div>
                       <div class="form-group">
                           <label>내용</label>
                           <textarea class="form-control" rows="3" name="content" placeholder="내용을 입력하세요..." ></textarea>
                       </div>
                       <div class="form-group">
                           <label>작성자</label>
                           <input class="form-control" name="writer" placeholder="작성자를 입력하세요...">
                       </div>
                       
                    	<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
                    	<input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
						
	                   	<button id="backBtn" type="button" class="btn btn-default">목록</button>
	                   	<button type="submit" class="btn btn-default">저장</button>
	                   	<button type="reset" class="btn btn-default">초기화</button>
                   	</form>
                </div>                
             </div>             
         </div>         
     </div>     
</div>
<%@include file="../include/footer.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		
		var	regFormObj = $('#regForm');
		
		$('#backBtn').on("click", function() {
			regFormObj.attr("action", "/board/list").attr("method", "GET");	// 목록화면 이동
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			
			// list로 돌아갈때 다지우고 필요한 애들(pageNum, amount)만 남김
			regFormObj.empty();
			regFormObj.append(pageNumTag);
			regFormObj.append(amountTag);
			
			regFormObj.submit();
		});

	});
</script>