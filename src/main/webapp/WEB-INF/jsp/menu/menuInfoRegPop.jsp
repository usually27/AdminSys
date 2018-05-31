<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>

<script type="text/javascript">
	var method="${params.method}";
	var methodName = "";

	if(method == "insert"){
		methodName = "추가";
	}else{
		methodName = "수정";
	}

	var menulevel= "${params.menuLevel}";
	//등록일 경우 상위메뉴에서 값을 넘기기 때문에 +1을 해준다.
	if(method == 'insert'){
		menulevel = Number(menulevel)+1;
	}
	var parMenu_Level = '${params.parMenuLevel}';
	var parLevelId = '${params.parMenu}';
	var useFlag = "";
	if(method == "update"){
		useFlag = '${params.useFlag}';
	}

	var menu_name 	= '${params.menuName}';
	var prog_id 	= '${params.progId}';
	var prog_name 	= '${params.progName}';

	$( function(){
		if( menulevel == 1 ){
			$("#rootReg").show();
// 			document.onload=self.resizeTo(525,370);
			$('#rootUse').val( useFlag );
			$("#pageTitle").text("메뉴 "+methodName);
		}else if( menulevel == 2 ){
			$("#midReg").show();
			if(method == 'insert' && parMenu_Level == 2) {
// 				document.onload=self.resizeTo(525,460);
			}else{
// 				document.onload=self.resizeTo(525,415);
			}
			$('#midUse').val( useFlag );
			$("#pageTitle").text("메뉴 "+methodName);
		}else if( menulevel == 3 ){
			$("#leafReg").show();

			if(method == 'insert' && parMenu_Level == 1) {
// 				document.onload=self.resizeTo(525,600);
			}else{
// 				document.onload=self.resizeTo(525,550);
			}

			if( method == 'update'){
				$("#leafMenuName").val( menu_name );
			}else{
				$("#leafMenuName").val( "" );
			}
			$('#leafUse').val( useFlag );
			$("#pageTitle").text("메뉴 "+methodName);
		}

		if( method == "update" ){
			if( menulevel == 1 ){
				$("#rootMenuName").val( menu_name );
			}else if( menulevel == 2 ){
				$("#midMenuName").val( menu_name );
			}else if( menulevel == 3 ){
				$("#progid").val( prog_id );
				$("#prognm").val( prog_name );
				$("#progpath").val( '${params.progPath}' );
			}
		}else{
			if( menulevel == 1 ){
				$("#rootMenuName").val("");
			}else if( menulevel == 2 ){
				$("#midMenuName").val("");
			}else if( menulevel == 3 ){
			}
		}
	});

	function menuProc(){
		var level1;
		var level2;
		var menuNm;

		if( menulevel == 1 ){
			menuNm = $("#rootMenuName").val();
		}else if( menulevel == 2 ){
			menuNm = $("#midMenuName").val();
		}else if( menulevel == 3 ){
			if(document.getElementById("midLeafFlag").value == 'M'){
				menuNm = $("#midMenuName").val();
			}else{
				menuNm = $("#leafMenuName").val();
			}
		}

		if( menuNm == "" ){
			alert("메뉴명을 입력하세요.");
			return false;
		}

		if( menulevel == 3 ){
			if($("#progid").val() == "" && $("#midLeafFlag").val() != 'M'){
				alert("연결 프로그램을 검색하세요.");
				return false;
			}
		}

		$("#menuNM").val(menuNm);

		var options = {
				success		: responseResult,
				url			: "${context}/menu/menuInfoRegPopup.json" ,
				type		: "post",
				dataType 	: "json"
		};

		try{
			$("#regForm").ajaxSubmit( options );
		}catch(e){
			alert("error= " + e);
		}
	};

	function responseResult( data ){
		reloadMenuLst();
		lp_close('.lp_memberInfo');
	};

	function progSearchPopup(){
		$("#progSearchPop").modalWindow('${context}/menu/progSearchPopup.do', {reqData : $("#regForm").getFormToJsonData()});
	};

	function chgNode(gubun,obj){
		var nodeSelVal2 = obj.value;

		if(gubun == 'S'){
			$("#leafReg").hide();
			$("#midReg").show();
			obj.value = 'S';
			$("#midLeafFlag").val('M');
		}

		if(gubun == 'M'){
			$("#leafReg").show();
			$("#midReg").hide();
			obj.value = 'M';
			$("#midLeafFlag").val('S');
		}
	}

</script>

<!-- lp_inner -->
<div class="lp_inner">
	<div class="lp_header">
		<h1 id="pageTitle" class="ico ico_star"></h1>
	</div>
	<!-- lp_body -->
	<div class="lp_body">
		<div class="lp_box">
			<div class="btn_wrap r">
				<button type="button" class="btn big black" onclick="javascript:menuProc();">저장</button>
			</div>
			<!-- section -->
			<form name="regForm" id="regForm">
			<input type="hidden" name="menuLevel" id="menuLevel" value="${params.menuLevel}"/>
			<input type="hidden" name="menuNM" id="menuNM"/>
			<input type="hidden" name="menuId" id="menuId" value="${params.menuId}"/>
			<input type="hidden" name="parMenuId" id="parMenuId" value="${params.parMenu}"/>
			<input type="hidden" name="updateGb"  value="${params.method}"/>
			<input type="hidden" name="midLeafFlag"  id="midLeafFlag" value="Z"/>
			<input type="hidden" name="parMenu_Level"  id="parMenu_Level" value="${params.parMenuLevel}"/>

			<div class="section">
				<div class="table_wrap" id="rootReg" style="display:none;">
					<table class="board_view" id="regT">
						<colgroup>
							<col width="150">
							<col />
							<col width="150">
						</colgroup>
						<tbody>
							<tr>
								<th>메뉴 레벨</th>
								<td>대메뉴</td>
							</tr>
							<tr>
								<th>메뉴명</th>
								<td>
									<input type="text" id="rootMenuName" name="rootMenuName" style="IME-MODE:active" maxlength="255" class="size200">
								</td>
							</tr>
							<tr>
								<th>사용여부</th>
								<td>
									<select id="rootUse" name="rootUse">
										<option value="Y">사용</option>
										<option value="N">미사용</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="table_wrap" id="midReg" style="display:none;">
					<c:if test="${'insert' eq params.method && '2' eq params.menuLevel && '1' eq params.parmenuLevel }">
						<table class="board_view">
							<tbody>
								<tr>
									<td>
										<select id="nodeSel" name="nodeSel" onchange="chgNode('M',this)">
											<option value="M" selected>중메뉴</option>
											<option value="S">소메뉴</option>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
					</c:if>
					<table class="board_view">
						<colgroup>
							<col width="150">
							<col />
							<col width="150">
						</colgroup>
						<tbody>
							<tr>
								<th>메뉴 레벨</th>
								<td>중메뉴</td>
							</tr>
							<tr>
								<th>메뉴명</th>
								<td>
									<input type="text" id="midMenuName" name="midMenuName" style="IME-MODE:active" maxlength="255" class="size200">
								</td>
							</tr>
							<tr>
								<th>사용여부</th>
								<td>
									<select id="midUse" name="midUse">
										<option value="Y">사용</option>
										<option value="N">미사용</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>상위 메뉴</th>
								<td>
									<c:choose>
										<c:when test="${params.method eq 'insert'}">
											<c:out value="${params.menuName}"/>
										</c:when>
										<c:otherwise>
											<c:out value="${params.parmenuNm}"/>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<th rowspan="2">연결 프로그램</th>
								<td>
									경 로 : <input type="text" id="midProgpath" name="midProgpath" value="${params.progPath}" readonly=readonly class="size200">
								</td>
							</tr>
							<tr>
								<td>
									I&nbsp;&nbsp;&nbsp;&nbsp;D : <input type="text" id="midProgid" name="midProgid" value="${params.progId}" readonly=readonly  class="size100">
									&nbsp;&nbsp; 명 : <input type="text" id="midPrognm" name="midPrognm" value="${params.progName}" readonly=readonly  class="size100" >
									<button type="button" class="btn big blue" onclick="javascript:progSearchPopup();"><span>검색</span></button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="table_wrap" id="leafReg" style="display:none;">
					<c:if test="${'insert' eq params.method && '1' eq params.parmenuLevel}">
						<table class="board_view">
							<tbody>
								<tr>
									<td>
										<select id="nodeSel2" name="nodeSel2" onchange="chgNode('S', this)">
											<option value="M">중메뉴</option>
											<option value="S" selected>소메뉴</option>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
					</c:if>
					<table class="board_view">
						<colgroup>
							<col width="150">
							<col />
							<col width="150">
						</colgroup>
						<tbody>
							<tr>
								<th>메뉴 레벨</th>
								<td>소메뉴</td>
							</tr>
							<tr>
								<th>메뉴명</th>
								<td>
									<input type="text" id="leafMenuName" name="leafMenuName" style="IME-MODE:active" maxlength="255" class="size200">
								</td>
							</tr>
							<tr>
								<th>사용여부</th>
								<td>
									<select id="leafUse" name="leafUse">
										<option value="Y">사용</option>
										<option value="N">미사용</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>상위 메뉴</th>
								<td>
									<c:choose>
									<c:when test="${params.method eq 'insert'}">
										<c:out value="${params.menuName}"/>
									</c:when>
									<c:otherwise>
										<c:out value="${params.parmenuNm}"/>
									</c:otherwise>
								</c:choose>
								</td>
							</tr>
							<tr>
								<th rowspan="2">연결 프로그램</th>
								<td>
									경 로 : <input type="text" id="leafProgpath" name="leafProgpath" value="${params.progPath}" readonly=readonly  class="size200">
								</td>
							</tr>
							<tr>
								<td>
									I&nbsp;&nbsp;&nbsp;&nbsp;D : <input type="text" id="leafProgid" name="leafProgid" value="${params.progId}" readonly=readonly  class="size100">
									&nbsp;&nbsp; 명 : <input type="text" id="leafPrognm" name="leafPrognm" value="${params.progName}" readonly=readonly  class="size100" >
									<button type="button" class="btn big blue" onclick="javascript:progSearchPopup();"><span>검색</span></button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			</form>
			<!-- // section -->
		</div>
	</div>
	<!-- // lp_body -->
	<a href="#this" class="lp_close" onclick="javascript:lp_close('.lp_memberInfo'); return;"></a>
</div>
<!-- // lp_inner -->
<div id="progSearchPop" class="lp_wrap lp_memberInfo lp_w600"></div>