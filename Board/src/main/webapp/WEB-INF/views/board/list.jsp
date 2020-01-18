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
		            <div class="panel-heading">게시글 목록<button id="regBtn" type="button" class="btn btn-xs btn-default pull-right">게시글 작성하기</button></div>		            
		            <div class="panel-body">
		                <div class="table-responsive">
		                    <table class="table table-striped table-bordered table-hover">
		                        <thead>
		                            <tr>
		                                <th>번호</th>
		                                <th>제목</th>
		                                <th>작성자</th>
		                                <th>작성일</th>
		                                <th>수정일</th>
		                            </tr>
		                        </thead>
		                        <tbody>
		                        	<c:forEach items="${list}" var="board">
		                        		<tr class="odd gradeX">
			                                <td><c:out value="${board.bno}"/></td>
			                                <!-- <td><a href="/board/get?bno=<c:out value="${board.bno}"/>"><c:out value="${board.title}"/></a></td> -->
			                                <td><a class="move" href="<c:out value='${board.bno}'/>"><c:out value="${board.title}"/></a></td>
			                                <td><c:out value="${board.writer}"/></td>
			                                <td class="center"><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd"/></td>
			                                <td class="center"><fmt:formatDate value="${board.updatedate}" pattern="yyyy-MM-dd"/></td>
		                            	</tr>	
		                        	</c:forEach>		                        		                       
								</tbody>
		                    </table>
		                    <!-- Search Start -->
		                    <div>			                    
			                    <form id="searchForm" action="/board/list" method="GET">
			                    	<select name="type">
			                    		<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}" /> >검색조건</option>
			                    		<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : ''}" /> >제목</option>
			                    		<option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}" /> >내용</option>
			                    		<option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : ''}" /> >작성자</option>
			                    		<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : ''}" /> >제목 or 내용</option>
			                    		<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : ''}" /> >제목 or 작성자</option>
			                    		<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected' : ''}" /> >제목 or 내용 or 작성자</option>
			                    	</select>
			                    	<input type="text" name="keyword">
									<input type="hidden" name="pageNum" value="<c:out value='${pageMaker.cri.pageNum}'/>">
									<input type="hidden" name="amount" value="<c:out value='${pageMaker.cri.amount}'/>">								
									<button class="btn btn-default">검색</button>
			                    </form>
		                    </div>
		                    <!-- Search End -->
		                    <!-- Paging Start -->
		                    <div class="pull-right">
		                    	<ul class="pagination">
		                    		<c:if test="${pageMaker.prev}">
		                    			<li class="paginate_button previous"><a href="${pageMaker.startPage - 1}">Previous</a></li>
		                    		</c:if>		                    		
		                    		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
		                    			<li class="pagination_button ${pageMaker.cri.pageNum == num ? 'active':'' } "><a href="${num}">${num}</a></li>
		                    		</c:forEach>
		                    		<c:if test="${pageMaker.next}">
		                    			<li class="paginate_button next"><a href="${pageMaker.endPage + 1}">Next</a></li>
		                    		</c:if>
		                    	</ul>
		                    </div>
		                    <form id="actionForm" action="/board/list" method="GET">
								<input type="hidden" name="pageNum" value="<c:out value='${pageMaker.cri.pageNum}'/>">
								<input type="hidden" name="amount" value="<c:out value='${pageMaker.cri.amount}'/>">
								<input type="hidden" name="type" value="<c:out value='${pageMaker.cri.type}'/>">
								<input type="hidden" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>">
		                    </form>
                            <!-- Paging End -->                    		                   
		                    <!-- Modal Start -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">게시물 처리완료</h4>
                                        </div>
                                        <div class="modal-body"></div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Modal End -->                            
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	</div>
<%@include file="../include/footer.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		var oper_bno = '<c:out value="${oper_bno}" />';
		var result = '<c:out value="${result}" />';
		
		checkModal(oper_bno);
		
		history.replaceState({}, null, null); // 뒤로가기 문제, modal안뜨도록 표시
		
		// Modal
		function checkModal(oper_bno) {
			if(oper_bno === '' || history.state) {	// 뒤로가기 문제, modal안뜨도록 표시
				return;
			}
			
			if(parseInt(oper_bno) > 0) {
				if(result === 'reg_success') {
					$('.modal-body').html(parseInt(oper_bno) + "번 게시글로로 등록되었습니다.");
				}
				else if(result === 'mod_success') {
					$('.modal-body').html(parseInt(oper_bno) + "번 게시글이 수정되었습니다.");
				}
				else if(result === 'rmv_success') {
					$('.modal-body').html(parseInt(oper_bno) + "번 게시글이 삭제되었습니다.");
				}
			}
			$('#myModal').modal("show");
		}						
		
		var actionFormObj = $('#actionForm');
		
		// register
		$("#regBtn").on("click", function () {			
			actionFormObj.attr("action", "/board/register");
			actionFormObj.submit();			
		});
		
		// page이동
		$('.pagination_button a').on("click", function(e) {
			e.preventDefault();		// <a>클릭 시 페이지 이동 막기
						
			actionFormObj.find("input[name='pageNum']").val($(this).attr("href"));	// .pagination_button a 의 href값
			actionFormObj.submit();
		});
		
		// get
		$('.move').on("click", function(e) {			
			e.preventDefault();		// <a>클릭 시 페이지 이동 막기
			
			actionFormObj.append("<input type='hidden' name='bno' value='" + $(this).attr('href')+"'>");
			actionFormObj.attr("action", "/board/get");
			actionFormObj.submit();		// /board/get?pageNum=7&amount=10&bno=32701
		});
		
		var searchFormObj = $('#searchForm');
		
		// search
		$('#searchForm button').on("click", function(e) {
			
			if(!searchFormObj.find("option:selected").val()){
				alert("검색 조건을 선택하세요.");
				return false;
			}
			if(!searchFormObj.find("input[name='keyword']").val()){
				alert("검색어를 입력하세요.");
				return false;
			}
			searchFormObj.find("input[name='pageNum']").val("1");
			e.preventDefault();
			
			searchFormObj.submit();
		});		
		
	});
</script>