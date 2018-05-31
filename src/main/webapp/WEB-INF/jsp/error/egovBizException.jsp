<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %> --%>
<%-- <%@ taglib prefix="custom" uri="/WEB-INF/tld/Custom.tld" %> --%>
<c:import charEncoding="utf-8" url="/main/PageLink.do?link=template/simple/header" />
<script type="text/javascript">
$(function(){
	$("#confirmBtn").click(function(event) {
		history.back(-2);
	});
})

</script>

<c:import charEncoding="utf-8" url="/main/PageLink.do?link=template/simple/content-top" />

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
								요청 처리 중 에러가 발생하였습니다.
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

<c:import charEncoding="utf-8" url="/main/PageLink.do?link=template/simple/content-btm" />
<c:import charEncoding="utf-8" url="/main/PageLink.do?link=template/simple/footer" />