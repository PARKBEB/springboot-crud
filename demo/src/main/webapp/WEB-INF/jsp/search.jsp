<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../../../../../css/board.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script type="text/javascript">
		$(function(){
			var chkObj = document.getElementsByName("RowCheck");
			var rowCnt = chkObj.length;
			
			$("input[name='allCheck']").click(function(){
				var chk_listArr = $("input[name='RowCheck']");
				for(var i=0; i < chk_listArr.length; i++){
					chk_listArr[i].checked = this.checked;
				}
			});
			$("input[name='RowCheck']").click(function(){
				if($("input[name='RowCheck']:checked").length == rowCnt){
					$("input[name='allCheck']")[0].checked = true;
				}
				else{
					$("input[name='allCheck']")[0].checked = false;
				}
			});
		});
		function deleteValue(){
			var url ="delete";
			var valueArr = new Array();
			var list = $("input[name='RowCheck']");
			for(var i = 0; i < list.length; i++){
				if(list[i].checked){
					valueArr.push(list[i].value);
				}
			}
			if(valueArr.length == 0){
				alert("선택된 글이 없습니다");
			}
			else{
				var chk = confirm("정말 삭제하시겠습니까?");
				$.ajax({
					url : url,
					type : 'POST',
					traditional : true,
					data : {
						valueArr : valueArr
					},
					success : function(jdata){
						if(jdata = 1){
							alert("삭제성공");
							location.replace("board");
						}
						else{
							alert("삭제실패");
						}
					}
				});
			}
		}
	</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Board list</title>
</head>
<body>
<div class="wrapper">
    <h1>Search page</h1>
    <form name="searchForm" action="search" autocomplete="off" class="searchF">
    	<select name="type">
    		<option selected value="">---</option>
    		<option value="all">all</option>
    		<option value="id">id</option>
    		<option value="name">name</option>
    		<option value="rank">rank</option>
    		<option value="title">title</option>
    	</select>
    	<input type="text" name="keyword"></input>
    	<button class="btn">search</button>
    	<a href="<c:url value="insert" />" role="button" class="btn">write</a>
    	<input type="button" value="Del" onClick="deleteValue();" class="btn">
    	<a href= "board" class="btn">home</a>
    </form>
	<form name="userForm" class="userF">
	    <table>
	    	<thead>
	    		<tr>
	    			<th scope="col"><input id="allCheck" type="checkbox" name="allCheck" /></th>
	    			<th scope="col">NO</th>
	    			<th scope="col">ID</th>
	    			<th scope="col">NAME</th>
	    			<th scope="col">RANK</th>
	    			<th scope="col">TITLE</th>
	    			<th scope="col">HIT</th>
	    			<th scope="col">INDATE</th>
	    			<th scope="col">INTIME</th>
	    		</tr>
	    	</thead>
	    	<tbody>
	    		<c:forEach items="${searchList}" var="searchList">
	    		<tr class="trT">
	    			<td><input name="RowCheck" type="checkbox" value="${searchList.no}"</td>
	    			<td>${searchList.rownum}&nbsp;</td>
	    			<td>${searchList.id}&nbsp;</td>
	    			<td><a href= "${path}/detail?no=${searchList.no}">${searchList.name}&nbsp;</a></td>
	    			<td>${searchList.rank}&nbsp;</td>
	    			<td>${searchList.title}&nbsp;</td>
	    			<td>${searchList.hit}&nbsp;</td>
	    			<td><fmt:formatDate value="${searchList.date}" type="date" pattern="yyyy/MM/dd" /></td>
	    			<td><fmt:formatDate value="${searchList.time}" type="time" pattern="HH:mm:ss" /></td>						
	    		</tr>
	    		</c:forEach>
	    	</tbody>
	    </table>
    </form>
</div>
</body>
</html>
