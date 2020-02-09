/*
 * 게시글 댓글 처리
 * */

var replyService = (function(){
	
	// 댓글 등록
	function add(reply, callback, error){
		console.log("add reply ajax..... : " + reply);
		
		$.ajax({
			type : 'post',
			url : '/replies/reg',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, err){
				if(error){
					error(err);
				}
			}
		});
	}
	
	// 댓글 목록
	function getList(param, callback, error) {
		console.log("getList reply getJSON..... : " + param.bno + "/" + param.page);
		
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/"+bno+"/"+page+".json",
				function(data) {
					if (callback) {
						//callback(data);	// json 수신
						callback(data.replyCnt, data.list); // 댓글 개수와 옥록 (ReplypageDTO)
					}
				}).fail(function(xhr, status, err) {
					if(error) {
						error();
					}
				});
	}
	
	// 댓글 삭제
	function remove(rno, callback, error){
		console.log("remove reply ajax..... : " + rno);
		
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,						
			success : function(result, status, xhr){
				if(callback){					
					callback(result);
				}
			},
			error : function(xhr, status, err){
				if(error){
					error(err);
				}
			}
		});
	}
	
	// 댓글 수정
	function update(reply, callback, error){
		console.log("update reply ajax..... : " + reply.rno);
		
		$.ajax({
			type : 'put',
			url : '/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, err){
				if(error){
					error(err);
				}
			}
		});
	}
	
	// 댓글 조회
	function get(rno, callback, error) {
		console.log("get reply ajax..... : " + rno);
		
		$.get("/replies/" + rno + ".json",
				function(result){
					if(callback) {
						callback(result);
				}
		}).fail(function(xhr, status, err) {
			if(error) {
				error();
			}
		});
		
	}
	
	
	// 시간 처리 '시:분:초', '년/월/일'
	function displayTime(timeValue) {
		var today = new Date();
		
		var gap = today.getTime() - timeValue;
		
		var dataObj = new Date(timeValue);
		var str = "";
		
		if( gap < (1000 * 60 * 60 * 24) ) {
			var hh = dataObj.getHours();
			var mi = dataObj.getMinutes();
			var ss = dataObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0' ) + mi, ':',  (ss > 9 ? '' : '0') + ss ].join('');			
		}else {
			var yy = dataObj.getFullYear();
			var mm = dataObj.getMonth() + 1;
			var dd = dataObj.getDate();
			
			return [ yy, '/', ( mm > 9 ? '' : '0' ) + mm, '/', ( dd > 9 ? '' : '0' ) + dd ].join('');
		}
	}
	
	
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
	};	
})();