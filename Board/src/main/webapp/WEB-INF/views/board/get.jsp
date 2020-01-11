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
                       <button data-oper="list" class="btn btn-default" onclick="location.href='/board/list'">목록</button>
                       <button data-oper="modify" class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}" />'">수정</button>
	                </div>                
	             </div>             
	         </div>         
     	</div>     
	</div>
<%@include file="../include/footer.jsp" %>