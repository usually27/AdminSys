<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
$(function(){
// 	$("#confirmBtn").click(function(event) {
// 		history.back(-2);
// 	});
})
</script>

<div class="container-fluid">
	<div class="row">
		<div class="col-xs-10 col-xs-offset-1">
			<div class="login-panel panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">에러</h3>
				</div>
				<div class="panel-body">
					<fieldset>
						<div class="row">
							<div class="col-xs-12 text-center">
								<c:choose>
									<c:when test="${errorCode == '404'}">
										요청한 페이지가 존재하지 않습니다.
									</c:when>
									<c:otherwise>
										요청 처리중 에러가 발생하였습니다.(허용되지 않은 요청)
									</c:otherwise>
								</c:choose>
								<br /><br />
							</div>
						</div>

						<c:if test="${sessionScope.auth.roleId == 'R0001'}">
						<div class="row">
							<div class="col-xs-12">
								<label>Exception: </label>
								${exception}
								<br /><br />
							</div>
						</div>
						</c:if>

						<div class="row">
							<div class="col-xs-12 text-center">
								<a href="#" id="confirmBtn" class="btn btn-md btn-primary">확인</a>
							</div>
						</div>
					</fieldset>
				</div>
			</div>
		</div>
	</div>
</div>