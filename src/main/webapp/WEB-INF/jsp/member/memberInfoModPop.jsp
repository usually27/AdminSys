<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>

<script type="text/javascript">
var flag ="${flag}";

if(flag == "" || flag == null || flag == "null") {
	flag = "insert";
}

var roleId = "${memberDetailData.roleId}";
var userId= "${memberDetailData.userId}";
var telephone= "${memberDetailData.userTel}".split('-');

var misscntb= "${memberDetailData.misscnt}";

if(misscntb == "" || misscntb == null || misscntb == "null") {
	misscntb = 0;
}

$(function() {
	if(misscntb > 4) {
		$("#misscnt").val("Y");
	} else {
		$("#misscnt").val("N");
	}

	$("#roleId").val("${memberDetailData.roleId}");

	//숫자 체크
	$("#telephone1 ,#telephone2").keyup(function() {
		if ($(this).val() != "" && checkNumber($(this).val()) == false) {
			alert("숫자만 입력 가능합니다.");
			this.focus();
			$(this).val("");
		}
	});

	/* 권한 콤보 */
	var comboArea = new AjaxComboBox("#roleId", {
		url			: "<c:url value='/common/util/code/combobox.json?codegroup=authCode' />"
	}).load({select: roleId});
	$("#gbnL").change(function(evt){
		console.log($("#gbnL").val());
		var value1 = $(this).val();
		var $gbnM = $("#gbnM");
// 		$gbnM.empty(); //지워
		$gbnM.append("<option value='000'>-- 선택 --</option>");
		if(value1 =="시청"){
			$gbnM.empty();
			$gbnM.append("<option value='대변인실(시청)'>	대변인실	</option>");
			$gbnM.append("<option value='여성청소년가족정책관실(시청)'>	여성청소년가족정책관실	</option>");
			$gbnM.append("<option value='인권평화협력관(시청)'>인권평화협력관	</option>");
			$gbnM.append("<option value='지역공동체추진단(시청)'>	지역공동체추진단	</option>");
			$gbnM.append("<option value='사회통합추진단(시청)'>	사회통합추진단	</option>");
			$gbnM.append("<option value='군공항이전사업단(시청)'>	군공항이전사업단	</option>");
			$gbnM.append("<option value='혁신도시협력추진단(시청)'>	혁신도시협력추진단	</option>");
			$gbnM.append("<option value='기획조정실(시청)'>	기획조정실	</option>");
			$gbnM.append("<option value='시민안전실(시청)'>	시민안전실	</option>");
			$gbnM.append("<option value='문화관광체육실(시청)'>	문화관광체육실	</option>");
			$gbnM.append("<option value='복지건강국(시청)'>	복지건강국	</option>");
			$gbnM.append("<option value='환경생태국(시청)'>	환경생태국	</option>");
			$gbnM.append("<option value='도시재생국(시청)'>	도시재생국	</option>");
			$gbnM.append("<option value='교통건설국(시청)'>	교통건설국	</option>");
			$gbnM.append("<option value='자치행정국(시청)'>	자치행정국	</option>");
			$gbnM.append("<option value='수영대회지원본부(시청)'>	수영대회지원본부	</option>");
			$gbnM.append("<option value='소방안전본부(시청)'>	소방안전본부	</option>");
			$gbnM.append("<option value='전략산업본부(시청)'>	전략산업본부	</option>");
			$gbnM.append("<option value='일자리경제국(시청)'>	일자리경제국	</option>");
			$gbnM.append("<option value='공무원교육원(시청)'>	공무원교육원	</option>");
			$gbnM.append("<option value='보건환경연구원(시청)'>	보건환경연구원	</option>");
			$gbnM.append("<option value='농업기술센터(시청)'>	농업기술센터	</option>");
			$gbnM.append("<option value='소방학교(시청)'>	소방학교	</option>");
			$gbnM.append("<option value='동부소방서(시청)'>	동부소방서	</option>");
			$gbnM.append("<option value='서부소방서(시청)'>	서부소방서	</option>");
			$gbnM.append("<option value='남부소방서(시청)'>	남부소방서	</option>");
			$gbnM.append("<option value='북부소방서(시청)'>	북부소방서	</option>");
			$gbnM.append("<option value='광산소방서(시청)'>	광산소방서	</option>");
			$gbnM.append("<option value='상수도사업본부(시청)'>	상수도사업본부	</option>");
			$gbnM.append("<option value='종합건설본부(시청)'>	종합건설본부	</option>");
			$gbnM.append("<option value='도시철도건설본부(시청)'>	도시철도건설본부	</option>");
			$gbnM.append("<option value='시립도서관(시청)'>	시립도서관	</option>");
			$gbnM.append("<option value='문화예술회관(시청)'>	문화예술회관	</option>");
			$gbnM.append("<option value='푸른도시사업소(시청)'>	푸른도시사업소	</option>");
			$gbnM.append("<option value='시립민속박물관(시청)'>	시립민속박물관	</option>");
			$gbnM.append("<option value='서부농수산물도매시장관리사무소(시청)'>	서부농수산물도매시장관리사무소	</option>");
			$gbnM.append("<option value='5.18민주화운동기록관(시청)'>	5.18민주화운동기록관	</option>");
			$gbnM.append("<option value='일가정양립지원본부(시청)'>	일가정양립지원본부	</option>");
			$gbnM.append("<option value='서울본부(시청)'>	서울본부	</option>");
			$gbnM.append("<option value='5.18기념문화센터(시청)'>	5.18기념문화센터	</option>");
			$gbnM.append("<option value='각화동농산물도매시장관리사무소(시청)'>	각화동농산물도매시장관리사무소	</option>");
			$gbnM.append("<option value='우치공원관리사무소(시청)'>	우치공원관리사무소	</option>");
			$gbnM.append("<option value='김치타운관리사무소(시청)'>	김치타운관리사무소	</option>");
			$gbnM.append("<option value='의회사무처(시청)'>	의회사무처	</option>");
			$gbnM.append("<option value='총무담당관(시청)'>	총무담당관	</option>");
			$gbnM.append("<option value='의사담당관(시청)'>	의사담당관	</option>");
			$gbnM.append("<option value='입법정책담당관(시청)'>	입법정책담당관	</option>");
			$gbnM.append("<option value='운영전문위원(시청)'>	운영전문위원	</option>");
			$gbnM.append("<option value='행정자치전문위원(시청)'>	행정자치전문위원	</option>");
			$gbnM.append("<option value='환경복지전문위원(시청)'>	환경복지전문위원	</option>");
			$gbnM.append("<option value='산업건설전문위원(시청)'>	산업건설전문위원	</option>");
			$gbnM.append("<option value='교육문화전문위원(시청)'>	교육문화전문위원	</option>");
			$gbnM.append("<option value='광주광역시 감사위원회(시청)'>	광주광역시 감사위원회	</option>");
		}
			else if(value1 =="광산구"){
				$gbnM.empty();
				$gbnM.append("<option value='기획관리실(광산구)'>	기획관리실	</option>");
				$gbnM.append("<option value='혁신정책관(광산구)'>	혁신정책관	</option>");
				$gbnM.append("<option value='과학행정관(광산구)'>	과학행정관	</option>");
				$gbnM.append("<option value='공보관(광산구)'>	공보관	</option>");
				$gbnM.append("<option value='감사관(광산구)'>	감사관	</option>");
				$gbnM.append("<option value='복지문화국(광산구)'>	복지문화국	</option>");
				$gbnM.append("<option value='경제환경국(광산구)'>	경제환경국	</option>");
				$gbnM.append("<option value='안전도시국(광산구)'>	안전도시국	</option>");
				$gbnM.append("<option value='자치행정국(광산구)'>	자치행정국	</option>");
				$gbnM.append("<option value='보건소(광산구)'>	보건소	</option>");
				$gbnM.append("<option value='의회사무국(광산구)'>	의회사무국	</option>");

		}else if(value1 =="동구"){
			$gbnM.empty();
			$gbnM.append("<option value='기획예산실(동구)'>	기획예산실	</option>");
			$gbnM.append("<option value='미래전략실(동구)'>	미래전략실	</option>");
			$gbnM.append("<option value='홍보실(동구)'>	홍보실	</option>");
			$gbnM.append("<option value='법무감사관(동구)'>	법무감사관	</option>");
			$gbnM.append("<option value='복지경제국(동구)'>	복지경제국	</option>");
			$gbnM.append("<option value='도시관리국(동구)'>	도시관리국	</option>");
			$gbnM.append("<option value='자치행정국(동구)'>	자치행정국	</option>");
			$gbnM.append("<option value='보건소(동구)'>	보건소	</option>");


	}else if(value1 =="서구"){
		$gbnM.empty();
		$gbnM.append("<option value='기획실(서구)'>	기획실	</option>");
		$gbnM.append("<option value='홍보실(서구)'>	홍보실	</option>");
		$gbnM.append("<option value='감사담당관(서구)'>	감사담당관	</option>");
		$gbnM.append("<option value='의회사무국(서구)'>	의회사무국	</option>");
		$gbnM.append("<option value='서구보건소(서구)'>	서구보건소	</option>");
		$gbnM.append("<option value='총무국(서구)'>	총무국	</option>");
		$gbnM.append("<option value='복지환경국(서구)'>	복지환경국	</option>");
		$gbnM.append("<option value='경제문화국(서구)'>	경제문화국	</option>");
		$gbnM.append("<option value='안전도시국(서구)'>	안전도시국	</option>");



}else if(value1 =="남구"){
	$gbnM.empty();
	$gbnM.append("<option value='기획실(남구)'>	기획실	</option>");
	$gbnM.append("<option value='감사담당관(남구)'>	감사담당관	</option>");
	$gbnM.append("<option value='도시재생담당관(남구)'>	도시재생담당관	</option>");
	$gbnM.append("<option value='문화교육사업단(남구)'>	문화교육사업단	</option>");
	$gbnM.append("<option value='자치행정국(남구)'>	자치행정국	</option>");
	$gbnM.append("<option value='복지경제국(남구)'>	복지경제국	</option>");
	$gbnM.append("<option value='도시환경국(남구)'>	도시환경국	</option>");
	$gbnM.append("<option value='보건소(남구)'>	보건소	</option>");

}else if(value1 =="북구"){
	$gbnM.empty();
	$gbnM.append("<option value='기획조정실(북구)'>	기획조정실	</option>");
	$gbnM.append("<option value='감사담당관(북구)'>	감사담당관	</option>");
	$gbnM.append("<option value='도시재생추진단(북구)'>	도시재생추진단	</option>");
	$gbnM.append("<option value='자치행정국(북구)'>	자치행정국	</option>");
	$gbnM.append("<option value='복지경제국(북구)'>	복지경제국	</option>");
	$gbnM.append("<option value='문화인권추진단(북구)'>	문화인권추진단	</option>");
	$gbnM.append("<option value='안전도시국(북구)'>	안전도시국	</option>");
	$gbnM.append("<option value='보건소(북구)'>	보건소	</option>");
	$gbnM.append("<option value='의회사무국(북구)'>	의회사무국	</option>");


}
	});


$("#gbnM").change(function(evt){
		console.log($(this).val());
		var value = $(this).val();
		var $gbnS = $("#gbnS");
		$gbnS.empty(); //지워
		$gbnS.append("<option value="+null+">-- 선택 --</option>");
		if(value =="기획조정실(시청)")
		{
			$gbnS.append("<option value='	정책기관'>	정책기관	</option>");
			$gbnS.append("<option value='	예산정책관'	>	예산정책관	</option>");
			$gbnS.append("<option value='	세정담당관'	>	세정담당관	</option>");
			$gbnS.append("<option value='	스마트행정담당관'	>	스마트행정담당관	</option>");
			$gbnS.append("<option value='	법무담당관'	>	법무담당관	</option>");
			$gbnS.append("<option value='	국제교류담당관'	>	국제교류담당관	</option>");

		}else if(value =="시민안전실(시청)"){
			$gbnS.append("<option value='	안전정책관'	>	안전정책관	</option>");
			$gbnS.append("<option value='	재난예방과	>	재난예방과	</option>");
			$gbnS.append("<option value='	재난대응과	>	재난대응과	</option>");
			$gbnS.append("<option value='	민생사법경찰과	>	민생사법경찰과	</option>");


		}else if(value =="문화관광체육실(시청)"){
			$gbnS.append("<option value='	문화도시정책관'	>	문화도시정책관	</option>");
			$gbnS.append("<option value='	문화예술진흥과'	>	문화예술진흥과	</option>");
			$gbnS.append("<option value='	문화산업과'	>	문화산업과	</option>");
			$gbnS.append("<option value='	관광진흥과'	>	관광진흥과	</option>");
			$gbnS.append("<option value='	체육진흥과'	>	체육진흥과	</option>");



		}else if(value =="복지건강국(시청)"){
			$gbnS.append("<option value='	사회복지과'	>	사회복지과	</option>");
			$gbnS.append("<option value='	고령사회정책과'	>	고령사회정책과	</option>");
			$gbnS.append("<option value='	장애인복지과'	>	장애인복지과	</option>");
			$gbnS.append("<option value='	건강정책과'	>	건강정책과	</option>");
			$gbnS.append("<option value='	식품안전과'	>	식품안전과	</option>");




		}else if(value =="환경생태국(시청)"){
			$gbnS.append("<option value='	환경정책과'	>	환경정책과	</option>");
			$gbnS.append("<option value='	기후변화대응과'	>	기후변화대응과	</option>");
			$gbnS.append("<option value='	공원녹지과'	>	공원녹지과	</option>");
			$gbnS.append("<option value='	생태수질과'	>	생태수질과	</option>");




		}else if(value =="도시재생국(시청)"){
			$gbnS.append("<option value='	도시계획과'	>	도시계획과	</option>");
			$gbnS.append("<option value='	도시재생정책과'	>	도시재생정책과	</option>");
			$gbnS.append("<option value='	건축주택과'	>	건축주택과	</option>");
			$gbnS.append("<option value='	토지정보과'	>	토지정보과	</option>");




		}else if(value =="교통건설국(시청)"){
			$gbnS.append("<option value='	교통정책과'	>	교통정책과	</option>");
			$gbnS.append("<option value='	대중교통과'	>	대중교통과	</option>");
			$gbnS.append("<option value='	건설행정과'	>	건설행정과	</option>");
			$gbnS.append("<option value='	도로과'	>	도로과	</option>");




		}else if(value =="자치행정국(시청)"){
			$gbnS.append("<option value='	자치행정과'	>	자치행정과	</option>");
			$gbnS.append("<option value='	행정지원과'	>	행정지원과	</option>");
			$gbnS.append("<option value='	회계과'	>	회계과	</option>");
			$gbnS.append("<option value='	청년정책과'	>	청년정책과	</option>");




		}else if(value =="수영대회지원본부(시청)"){
			$gbnS.append("<option value='	대회지원과'	>	대회지원과	</option>");
			$gbnS.append("<option value='	경기시설과'	>	경기시설과	</option>");



		}else if(value =="소방안전본부(시청)"){
			$gbnS.append("<option value='	소방행정과'	>	소방행정과	</option>");
			$gbnS.append("<option value='	방호예방과'	>	방호예방과	</option>");
			$gbnS.append("<option value='	구조구급과'	>	구조구급과	</option>");
			$gbnS.append("<option value='	119종합상황실'	>	119종합상황실	</option>");
			$gbnS.append("<option value='	119특수구조단'	>	119특수구조단	</option>");




		}else if(value =="전략산업본부(시청)"){
			$gbnS.append("<option value='	미래산업정책관'	>	미래산업정책관	</option>");
			$gbnS.append("<option value='	자동차산업과'	>	자동차산업과	</option>");
			$gbnS.append("<option value='	에너지산업과'	>	에너지산업과	</option>");
			$gbnS.append("<option value='	투자유치과'	>	투자유치과	</option>");




		}else if(value =="일자리경제국(시청)"){
			$gbnS.append("<option value='	일자리정책과'	>	일자리정책과	</option>");
			$gbnS.append("<option value='	기업육성과'	>	기업육성과	</option>");
			$gbnS.append("<option value='	민생경제과'>	민생경제과	</option>");
			$gbnS.append("<option value='	생명농업과'	>	생명농업과	</option>");




		}else if(value =="상수도사업본부(시청)"){
			$gbnS.append("<option value='	업무과'	>	업무과	</option>");
			$gbnS.append("<option value='	요금과'	>	요금과	</option>");
			$gbnS.append("<option value='	제무과'	>	제무과	</option>");
			$gbnS.append("<option value='	시설과'	>	시설과	</option>");
			$gbnS.append("<option value='	급수과'	>	급수과	</option>");
			$gbnS.append("<option value='	용연정수사업소'	>	용연정수사업소	</option>");
			$gbnS.append("<option value='	용연정수사업소(동복취수장)'	>	용연정수사업소(동복취수장)	</option>");
			$gbnS.append("<option value='	용연정수사업소(지원정수장)'	>	용연정수사업소(지원정수장)	</option>");
			$gbnS.append("<option value='	용연정수사업소(각화정수장)'	>	용연정수사업소(각화정수장)	</option>");
			$gbnS.append("<option value='	시설관리소'	>	시설관리소	</option>");
			$gbnS.append("<option value='	수질연구원'	>	수질연구원	</option>");
			$gbnS.append("<option value='	덕남정수사업소'	>	덕남정수사업소	</option>");
			$gbnS.append("<option value='	동부사업소'	>	동부사업소	</option>");
			$gbnS.append("<option value='	서부사업소'	>	서부사업소	</option>");
			$gbnS.append("<option value='	남부사업소'	>	남부사업소	</option>");
			$gbnS.append("<option value='	북부사업소'	>	북부사업소	</option>");
			$gbnS.append("<option value='	광산사업소'	>	광산사업소	</option>");




		}else if(value =="종합건설본부(시청)"){
			$gbnS.append("<option value='	관리과'	>	관리과	</option>");
			$gbnS.append("<option value='	보상과'	>	보상과	</option>");
			$gbnS.append("<option value='	토목1과'	>	토목1과	</option>");
			$gbnS.append("<option value='	토목2과'	>	토목2과	</option>");
			$gbnS.append("<option value='	토목3과'	>	토목3과	</option>");
			$gbnS.append("<option value='	도로관리과'	>	도로관리과	</option>");
			$gbnS.append("<option value='	건축과'	>	건축과	</option>");
			$gbnS.append("<option value='	설비1과'	>	설비1과	</option>");
			$gbnS.append("<option value='	설비2과'	>	설비2과	</option>");
			$gbnS.append("<option value='	품질시험과'	>	품질시험과	</option>");




		}else if(value =="도시철도건설본부(시청)"){
			$gbnS.append("<option value='	관리과'	>	관리과	</option>");
			$gbnS.append("<option value='	공사계획과'	>	공사계획과	</option>");
			$gbnS.append("<option value='	차량설비과'	>	차량설비과	</option>");
			$gbnS.append("<option value='	신호통신과'	>	신호통신과	</option>");




		}else if(value =="복지문화국(광산구)"){
			$gbnS.append("<option value='	복지행정과'	>	복지행정과	</option>");
			$gbnS.append("<option value='	노인장애인아동과'	>	노인장애인아동과	</option>");
			$gbnS.append("<option value='	여성보육과'	>	여성보육과	</option>");
			$gbnS.append("<option value='	희망복지과'	>	희망복지과	</option>");
			$gbnS.append("<option value='	공동체복지과'	>	공동체복지과	</option>");
			$gbnS.append("<option value='	문화예술과'	>	문화예술과	</option>");
			$gbnS.append("<option value='	관광체육지원단'	>	관광체육지원단	</option>");
			$gbnS.append("<option value='	도서관과'	>	도서관과	</option>");




		}else if(value =="경제환경국(광산구)"){
			$gbnS.append("<option value='	사회경제과'	>	사회경제과	</option>");
			$gbnS.append("<option value='	생명농업과'	>	생명농업과	</option>");
			$gbnS.append("<option value='	환경생태과'	>	환경생태과	</option>");
			$gbnS.append("<option value='	청소행정과'	>	청소행정과	</option>");
			$gbnS.append("<option value='	공원녹지과'	>	공원녹지과	</option>");



		}else if(value =="안전도시국(광산구)"){
			$gbnS.append("<option value='	도시재생과'	>	도시재생과	</option>");
			$gbnS.append("<option value='	건설과'	>	건설과	</option>");
			$gbnS.append("<option value='	안전관리과'	>	안전관리과	</option>");
			$gbnS.append("<option value='	주택과'	>	주택과	</option>");
			$gbnS.append("<option value='	건축과'	>	건축과	</option>");
			$gbnS.append("<option value='	교통행정과'	>	교통행정과	</option>");
			$gbnS.append("<option value='	교통지도과'	>	교통지도과	</option>");




		}else if(value =="자치행정국(광산구)"){
			$gbnS.append("<option value='	주민자치과'	>	주민자치과	</option>");
			$gbnS.append("<option value='	교육지원과'	>	교육지원과	</option>");
			$gbnS.append("<option value='	세무1과'	>	세무1과	</option>");
			$gbnS.append("<option value='	세무2과'	>	세무2과	</option>");
			$gbnS.append("<option value='	민원봉사과'	>	민원봉사과	</option>");
			$gbnS.append("<option value='	부동산지적과'	>	부동산지적과	</option>");
			$gbnS.append("<option value='	회계전산과'	>	회계전산과	</option>");
			$gbnS.append("<option value='	행정지원과'	>	행정지원과	</option>");




		}else if(value =="보건소(광산구)"){
			$gbnS.append("<option value='	보건행정과'	>	보건행정과	</option>");
			$gbnS.append("<option value='	건강증진과'	>	건강증진과	</option>");
			$gbnS.append("<option value='	식품위생과'	>	식품위생과	</option>");
			$gbnS.append("<option value='	수완보건지소'	>	수완보건지소	</option>");
			$gbnS.append("<option value='	우산건강생활지원센터'	>	우산건강생활지원센터	</option>");




		}else if(value =="의회사무국(광산구)"){
			$gbnS.append("<option value='	전문위원'	>	전문위원	</option>");
			$gbnS.append("<option value='	의정'	>	의정	</option>");
			$gbnS.append("<option value='	의사'	>	의사	</option>");




		}else if(value =="복지경제국(동구)"){
			$gbnS.append("<option value='	복지정책과'	>	복지정책과	</option>");
			$gbnS.append("<option value='	노인장애인복지과'	>	노인장애인복지과	</option>");
			$gbnS.append("<option value='	여성가족과'	>	여성가족과	</option>");
			$gbnS.append("<option value='	문화관광과'	>	문화관광과	</option>");
			$gbnS.append("<option value='	경제과'	>	경제과	</option>");




		}else if(value =="도시관리국(동구)"){
			$gbnS.append("<option value='	도시재생과'	>	도시재생과	</option>");
			$gbnS.append("<option value='	건설과'	>	건설과	</option>");
			$gbnS.append("<option value='	건축과'	>	건축과	</option>");
			$gbnS.append("<option value='	교통과'	>	교통과	</option>");
			$gbnS.append("<option value='	공원녹지과'	>	공원녹지과	</option>");
			$gbnS.append("<option value='	환경청소과'	>	환경청소과	</option>");




		}else if(value =="자치행정국(동구)"){
			$gbnS.append("<option value='	행정지원과'	>	행정지원과	</option>");
			$gbnS.append("<option value='	회계정보과'	>	회계정보과	</option>");
			$gbnS.append("<option value='	인권청년과'	>	인권청년과	</option>");
			$gbnS.append("<option value='	안전관리과'	>	안전관리과	</option>");
			$gbnS.append("<option value='	세무과'	>	세무과	</option>");
			$gbnS.append("<option value='	민원봉사과'	>	민원봉사과	</option>");



		}else if(value =="보건소(동구)"){
			$gbnS.append("<option value='	건강정책과'	>	건강정책과	</option>");
			$gbnS.append("<option value='	보건위생과'	>	보건위생과	</option>");




		}else if(value =="서구보건소(서구)"){
			$gbnS.append("<option value='	보건행정과'	>	보건행정과	</option>");
			$gbnS.append("<option value='	보건위생과'	>	보건위생과	</option>");
			$gbnS.append("<option value='	상무금호보건지소'	>	상무금호보건지소	</option>");




		}else if(value =="총무국(서구)"){
			$gbnS.append("<option value='	총무과'	>	총무과	</option>");
			$gbnS.append("<option value='	주민자치과'	>	주민자치과	</option>");
			$gbnS.append("<option value='	교육지원과'	>	교육지원과	</option>");
			$gbnS.append("<option value='	세무1과'	>	세무1과	</option>");
			$gbnS.append("<option value='	세무2과'	>	세무2과	</option>");
			$gbnS.append("<option value='	회계정보과'	>	회계정보과	</option>");
			$gbnS.append("<option value='	민원봉사과'	>	민원봉사과	</option>");




		}else if(value =="복지환경국(서구)"){
			$gbnS.append("<option value='	복지정책과'	>	복지정책과	</option>");
			$gbnS.append("<option value='	복지급여과'	>	복지급여과	</option>");
			$gbnS.append("<option value='	노인장애인복지과'	>	노인장애인복지과	</option>");
			$gbnS.append("<option value='	여성아동복지과'	>	여성아동복지과	</option>");
			$gbnS.append("<option value='	녹색환경과'	>	녹색환경과	</option>");
			$gbnS.append("<option value='	청소행정과'	>	청소행정과	</option>");




		}else if(value =="경제문화국(서구)"){
			$gbnS.append("<option value='	문화체육과'	>	문화체육과	</option>");
			$gbnS.append("<option value='	도서관과'	>	도서관과	</option>");
			$gbnS.append("<option value='	경제과'	>	경제과	</option>");
			$gbnS.append("<option value='	공원녹지과'	>	공원녹지과	</option>");




		}else if(value =="안전도시국(서구)"){
			$gbnS.append("<option value='	도시재생과'	>	도시재생과	</option>");
			$gbnS.append("<option value='	안전총괄과'	>	안전총괄과	</option>");
			$gbnS.append("<option value='	교통과'	>	교통과	</option>");
			$gbnS.append("<option value='	건설과'	>	건설과	</option>");
			$gbnS.append("<option value='	건축과'	>	건축과	</option>");
			$gbnS.append("<option value='	부동산정보과'	>	부동산정보과	</option>");





		}else if(value =="문화교육사업단(남구)"){
			$gbnS.append("<option value='	문화관광과'	>	문화관광과	</option>");
			$gbnS.append("<option value='	교육지원과'	>	교육지원과	</option>");





		}else if(value =="자치행정국(남구)"){
			$gbnS.append("<option value='	총무과'	>	총무과	</option>");
			$gbnS.append("<option value='	안전행정과'	>	안전행정과	</option>");
			$gbnS.append("<option value='	회계과'	>	회계과	</option>");
			$gbnS.append("<option value='	세무과'	>	세무과	</option>");
			$gbnS.append("<option value='	민원봉사과'	>	민원봉사과	</option>");
			$gbnS.append("<option value='	도서관과'	>	도서관과	</option>");





		}else if(value =="복지경제국(남구)"){
			$gbnS.append("<option value='	복지기획과'	>	복지기획과	</option>");
			$gbnS.append("<option value='	노인장애인복지과'	>	노인장애인복지과	</option>");
			$gbnS.append("<option value='	여성아동복지과'	>	여성아동복지과	</option>");
			$gbnS.append("<option value='	경제과'	>	경제과	</option>");
			$gbnS.append("<option value='	지역경제순환과'	>	지역경제순환과	</option>");





		}else if(value =="도시환경국(남구)"){
			$gbnS.append("<option value='	도시계획과'	>	도시계획과	</option>");
			$gbnS.append("<option value='	건설과'	>	건설과	</option>");
			$gbnS.append("<option value='	건축과'	>	건축과	</option>");
			$gbnS.append("<option value='	교통과'	>	교통과	</option>");
			$gbnS.append("<option value='	환경생태과'	>	환경생태과	</option>");
			$gbnS.append("<option value='	공원녹지과'	>	공원녹지과	</option>");





		}else if(value =="보건소(남구)"){
			$gbnS.append("<option value='	보건행정과'	>	보건행정과	</option>");
			$gbnS.append("<option value='	보건위생과'	>	보건위생과	</option>");
			$gbnS.append("<option value='	주월보건지소'	>	주월보건지소	</option>");





		}else if(value =="자치행정국(북구)"){
			$gbnS.append("<option value='	총무과'	>	총무과	</option>");
			$gbnS.append("<option value='	주민자치과'	>	주민자치과	</option>");
			$gbnS.append("<option value='	세무1과'	>	세무1과	</option>");
			$gbnS.append("<option value='	세무2과'	>	세무2과	</option>");
			$gbnS.append("<option value='	회계과'	>	회계과	</option>");
			$gbnS.append("<option value='	민원봉사과'	>	민원봉사과	</option>");
			$gbnS.append("<option value='	홍보전산과'	>	홍보전산과	</option>");
			$gbnS.append("<option value='	도서관과'	>	도서관과	</option>");





		}else if(value =="복지경제국(북구)"){
			$gbnS.append("<option value='	복지정책과'	>	복지정책과	</option>");
			$gbnS.append("<option value='	통합조사과'	>	통합조사과	</option>");
			$gbnS.append("<option value='	통합관리과'	>	통합관리과	</option>");
			$gbnS.append("<option value='	노인장애인복지과'	>	노인장애인복지과	</option>");
			$gbnS.append("<option value='	여성가족과'	>	여성가족과	</option>");
			$gbnS.append("<option value='	경제정책과'	>	경제정책과	</option>");
			$gbnS.append("<option value='	기업지원과'	>	기업지원과	</option>");
			$gbnS.append("<option value='	환경과'	>	환경과	</option>");
			$gbnS.append("<option value='	청소행정과'	>	청소행정과	</option>");





		}else if(value =="문화인권추진단(북구)"){
			$gbnS.append("<option value='	문화관광과'	>	문화관광과	</option>");
			$gbnS.append("<option value='	인권교육과'	>	인권교육과	</option>");





		}else if(value =="안전도시국(북구)"){
			$gbnS.append("<option value='	안전총괄과'	>	안전총괄과	</option>");
			$gbnS.append("<option value='	건설과'	>	건설과	</option>");
			$gbnS.append("<option value='	건축과'	>	건축과	</option>");
			$gbnS.append("<option value='	공동주택과'	>	공동주택과	</option>");
			$gbnS.append("<option value='	도시정비과'	>	도시정비과	</option>");
			$gbnS.append("<option value='	교통행정과'	>	교통행정과	</option>");
			$gbnS.append("<option value='	교통지도과'>	교통지도과	</option>");
			$gbnS.append("<option value='	공원녹지과'	>	공원녹지과	</option>");
			$gbnS.append("<option value='	토지정보과'	>	토지정보과	</option>");





		}else if(value =="보건소(북구)"){
			$gbnS.append("<option value='	보건행정과'	>	보건행정과	</option>");
			$gbnS.append("<option value='	건강증진과'	>	건강증진과	</option>");
			$gbnS.append("<option value='	위생과'	>	위생과	</option>");
			$gbnS.append("<option value='	두암보건지소'	>	두암보건지소	</option>");
			$gbnS.append("<option value='	본촌건강생활 비원센터'	>	본촌건강생활 비원센터	</option>");





		}else if(value =="의회사무국(북구)"){
			$gbnS.append("<option value='	의회원영전문위원'	>	의회원영전문위원	</option>");
			$gbnS.append("<option value='	행정자치전문위원'	>	행정자치전문위원	</option>");
			$gbnS.append("<option value='	경제복지전문위원'	>	경제복지전문위원	</option>");
			$gbnS.append("<option value='	도시보건전문위원'	>	도시보건전문위원	</option>");
			$gbnS.append("<option value='의정/의사/의정홍보'	>	의정/의사/의정홍보	</option>");



		}




	});
$("#userId").val(userId);
$("#userName").val("${memberDetailData.userName}");
$("#orgName").val("${memberDetailData.orgName}");
$("#userClass").val("${memberDetailData.userClass}");
$("#telephone1").val(telephone[0]);
$("#telephone2").val(telephone[1]);
$("#gbnL").val("${memberDetailData.gbnL}").attr('selected','selected');
$("#gbnL").val("${memberDetailData.gbnL}").trigger('change');
$("#gbnM").val("${memberDetailData.gbnM}").attr('selected','selected');

$("#gbnM").val("${memberDetailData.gbnM}").trigger('change');
$("#gbnS").val("${memberDetailData.gbnS}").attr('selected','selected');

});

// 사용자 정보 수정
function modMember(){
	var userId = $('#userId');
	var userName = $('#userName');

	if(userName.val().indexOf(" " ) != -1) {
		alert("사용자 이름에는 공백을 입력할 수 없습니다.");
		userName.focus();
		return;
	} else if(userName.val()=="") {
		alert("사용자 이름을 입력해 주세요!");
		userName.focus();
		return;
	}

	if($('#orgName').val() == ""){
		alert("기관명을 입력해 주세요");
		$('#orgName').focus();
		return;
	}

	if($('#userClass').val() == ""){
		alert("소속기관을 입력해 주세요");
		$('#userClass').focus();
		return;
	}

	var tel1 = $('#telephone1').val();
	var tel2 = $('#telephone2').val();
	if( tel1 == "" || tel2 == "" ) {
		alert("전화번호를 입력하세요.");
		$('#telephone1').focus();
		return;
	}

	var stat = confirm("모든 가입정보를 확인하셨습니까?");
	if(!stat) {
		return;
	}

	var options = {
			success : insertResult,
			url : "${pageContext.request.contextPath}/member/memberInfoMod.json",
			contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			type : "post",
			dataType : "Json"
	};

	try{
		$("#memberForm").ajaxSubmit( options );
	}catch(e){
		alert("error = " + e);
	}
}

function insertResult(data){
	var resultMsg = data.resultMsg;
	var instFlag = data.instFlag;

	if(instFlag =="N"){
		alert(resultMsg);
	} else if (instFlag == "M"){
		alert(resultMsg);
		lp_close('.lp_memberInfo');
		reloadList();
	}
}

//비밀번호 초기화
function pwdInit() {
	if(confirm("사용자 비밀번호가 " + "${initPass}" + "로 초기화 됩니다. \n초기화 하시겠습니까?")) {
		$.ajax({
			type : "post",
			url	 : "${context}/member/memberInfoPwdInit.json",
			data : {
				"method" : "pwdInit",
				"userId" : userId,
				"aprState" : 'A',
				"userPwd" : "${initPass}"},
			dataType:"json",
			cache: false,
			success: function( data ){
				alert(data.result_string);
				lp_close('.lp_memberInfo');
			}
		});
	}
}

//삭제
function deleteInfo(){
	if( confirm("사용자의 정보를 삭제하시겠습니까?") ){
		$.ajax({
			type: "post",
			url	 : "${context}/member/memberInfoDelete.json",
			data : {
				"method" : "delete",
				"userId" : userId
			},
			dataType:"json",
			cache: false,
			success: function( data ){
				alert("사용자 정보가 삭제되었습니다.");
				reloadList();
				lp_close('.lp_memberInfo');
			}
		});
	}
}

//차단
function block() {
	if( confirm("사용자의 접속을 차단하시겠습니까?") ){
		$.ajax({
			type : "post",
			url : "${context}/member/memberInfoBlock.json",
			data : {
				"method" : "block",
				"userId" : userId},
			dataType : "json",
			cache : false,
			success : function( data ){
				alert("${memberDetailData.userName}" + "님의 접속이 차단되었습니다.");
				reloadList();
				lp_close('.lp_memberInfo');
			}
		});
	}
}

//승인
function approval(){
	$("#gubun").val("sec");

	if( confirm("사용자의 등록을 승인하시겠습니까?") ){
		$.ajax({
			type: "post",
			url	 : "${context}/member/memberInfoApproval.json",
			data : {
				"method" : "approval",
				"userId" : userId
			},
			dataType:"json",
			cache: false,
			success: resultApproval
		});
	}
}

function resultApproval( data ){
	var dataCnt = data.rstCnt;

	if(dataCnt == '1'){
		alert("${memberDetailData.userName}" + "님의 정보가 승인되었습니다.");
		reloadList();
		lp_close('.lp_memberInfo');
	} else {
		alert("${memberDetailData.userName}" + "님의  승인에 실패하였습니다. \n\n 다시 시도하여 주십시오.");
	}
}

//승인보류
function defer(){
	if( confirm("사용자의 등록을 승인을 보류하시겠습니까?") ){
		$.ajax({
			type : "post",
			url	 : "${context}/member/memberInfoDefer.json",
			data : {
				"method" : "defer",
				"userId" : userId
			},
			dataType:"json",
			cache: false,
			success: function( data ){
				alert("${memberDetailData.userName}" + "님의 정보가 승인 보류되었습니다.");
				reloadList();
				lp_close('.lp_memberInfo');
			}
		});
	}
}

//숫자 체크
function checkNumber(str){
	event.returnValue = true;
	if (str.length > 0) {
		for (i = 0; i < str.length; i++) {
			if (str.charAt(i) < '0' || str.charAt(i) > '9') {
				event.returnValue = false;
			}
		}
	}
	return event.returnValue;
}

</script>

<div class="lp_inner">
	<div class="lp_header">
		<h1 class="ico ico_star">사용자 수정</h1>
	</div>
	<div class="lp_body">
		<div class="lp_box">
			<div class="btn_wrap r">
				<c:if test="${'modifyMgr' eq flag }">
					<c:if test="${'N' eq memberDetailData.aprState || 'D' eq memberDetailData.aprState || 'R' eq memberDetailData.aprState }">
						<button type="button" class="btn big blue" onclick="approval();">승인</button>
						<c:if test="${'R' ne memberDetailData.aprState}">
							<button type="button" class="btn big blue" onclick="defer();">승인보류</button>
						</c:if>
					</c:if>
					<button type="button" class="btn big blue" onclick="deleteInfo();">삭제</button>
					<c:if test="${'S' ne memberDetailData.aprState }">
						<button type="button" class="btn big blue" onclick="block();">차단</button>
					</c:if>
				</c:if>
				<button type="button" class="btn big black" onclick="modMember();">저장</button>
			</div>
			<form id="memberForm">
			<input type="hidden" id="flag" name="flag" value="${flag}"/>
			<input type="hidden" id="aprovalFlag" name="aprovalFlag" value="N"/>
			<input type="hidden" id="gubun" name="gubun" value=""/>
			<div class="section">
				<div class="hgroup_wrap">
					<h2>아이디(ID) 정보</h2>
				</div>
				<div class="table_wrap">
					<div class="board_info">
						<div class="board_right">
							<p class="txt_guide">등록시 <span class="ico_ess">표시는 필수 입력사항입니다.</span></p>
						</div>
					</div>
					<table class="board_view">
						<colgroup>
							<col width="140">
							<col>
						</colgroup>
						<tbody>
							<tr id="modifyIdTr">
								<th>사용자 아이디</th>
								<td>
									<input type="text" id="userId" name="userId" readonly>
								</td>
							</tr>
							<tr id="mgrPwdTr">
								<th>비밀번호 *</th>
								<td>
									<input type="password" id="pwd" name="pwd" maxlength="16" style="ime-mode:disabled">
									<span>비밀번호를 <span style="color:red">&quot;<c:out value="${initPass}"/>&quot;</span>로 <a href="javascript:pwdInit();"><span style="color:blue">[초기화]</span></a></span>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="hgroup_wrap">
					<h2>개인 정보</h2>
				</div>
				<div class="table_wrap">
					<table class="board_view">
						<colgroup>
							<col width="90">
							<col>
							<col width="90">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th><label class="est">이름</label></th>
								<td colspan="3">
									<input type="text" id="userName" name="userName" style="IME-MODE:active;">
								</td>
							</tr>
							<tr>
								<th><label class="est">기관명:대분류</label></th>
								<td>
								<select name="gbnL" id="gbnL" class="size100p">
									<option value="000">-- 선택 --</option>
									<option value="시청">시청</option>
									<option value="광산구">광산구</option>
									<option value="동구">동구</option>
									<option value="서구">서구</option>
									<option value="남구">남구</option>
									<option value="북구">북구</option>
								</select>
								</td>
							</tr>
							<tr>
								<th><label class="est">기관명:중분류</label></th>
								<td>
									<select name="gbnM" id="gbnM" class="size100p">
										<option value="000">-- 선택 --</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>기관명:소분류</th>
								<td>
									<select name="gbnS" id="gbnS" class="size100p">
										<option value="000">-- 선택 --</option>
									</select>
								</td>
							</tr>

							<tr>
								<th><label class="est">사무실<br>전화번호</label></th>
								<td colspan="3">
									<input type="text" id="telephone1" name="telephone1" maxlength="3" size="3" onkeypress="checkNumber(this);" style="IME-MODE: disabled;"> -
									<input type="text" id="telephone2" name="telephone2" maxlength="4" size="4" onkeypress="checkNumber(this);" style="IME-MODE: disabled;">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="hgroup_wrap">
					<h2>권한 정보</h2>
				</div>
				<div class="table_wrap">
					<table class="board_view">
						<colgroup>
							<col width="150">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th><label>메뉴권한</label></th>
								<td>
									<select name="roleId" id="roleId"></select>
								</td>
							</tr>
							<c:if test="${flag eq 'modifyMgr' }">
								<tr>
									<th>비밀번호 5회 이상<br>실패 차단여부</th>
									<td>
										<input type="text" id="misscnt" name="misscnt" style="border:0px;">
									</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
			</form>
		</div>
	</div>
	<a href="#this" class="lp_close" onclick="javascript:lp_close('.lp_memberInfo'); return;"></a>
</div>