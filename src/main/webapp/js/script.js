// 회원가입 ================================================================
$(document).ready(function() {

    var isIdChecked = false; // 아이디 중복 확인 버튼 클릭 여부를 나타내는 변수

    // 아이디 중복 체크 버튼 클릭 시 userIdCheck 메소드 실행
    $("#idCheck").click(function() {
        userIdCheck();
    });
    
    // 아이디 중복 체크 및 유효성 검사
    function userIdCheck() {
        var userId = $("input[name='id']").val();
        var userIdCheckLocation = $("#user_id_check");
        var userIdRegex = /^[a-zA-Z0-9]{4,20}$/; // 4~20자의 영문, 숫자만 허용
        
        if (userId === "") {
            userIdCheckLocation.html('아이디를 입력해주세요').css('color', 'red');
            $("input[name='id']").focus();
            isIdChecked = false; // 아이디 중복 확인 미수행 상태로 설정
            return false;
        } else if (!userIdRegex.test(userId)) {
            userIdCheckLocation.html('아이디는 4~20자의 영문, 숫자만 가능합니다.').css('color', 'red');
            $("input[name='id']").focus();
            isIdChecked = false; // 아이디 중복 확인 미수행 상태로 설정
            return false;
        } else {
            userIdCheckLocation.html('').css('color', '');
            isIdChecked = false; // 중복확인 버튼을 누를 때마다 초기화
			
            // 아이디 중복 체크 AJAX 요청
			$.ajax({
				url: "registerIdCheck.jsp",	// 중복 체크를 수행할 파일
				method: "POST",
				data: {user_id: userId},
				dataType: "json",
				success: function(response) {
					if (response.result === "duplicate") {
						userIdCheckLocation.html('사용할 수 없는 아이디입니다.').css('color', 'red');
					} else if (response.result === "not_duplicate") {
						userIdCheckLocation.html('사용 가능한 아이디입니다.').css('color', 'blue');
                        isIdChecked = true; // 아이디 중복 확인 완료 상태로 설정
					} else {
						userIdCheckLocation.html('오류가 발생했습니다. 다시 시도해주세요.').css('color', 'red');
						isIdChecked = false; // 아이디 중복 확인 미수행 상태로 설정
					}
				}
			});
			return true;	// 함수 실행이 정상적으로 완료되었음을 true로 반환
		}
	}
	// 가입 버튼 클릭 시
	$("#btnRegister").click(function() {
		if (validateForm()) {
			combineEmail();
			combineAddress();
			submitForm();
		}
	});
	
	// 폼 유효성 검사 ==================================================================
	function validateForm() {
		var isValid = true;
		
		// 아이디 중복 확인 여부 체크
        if (!isIdChecked) {
			var userIdCheckLocation = $("#user_id_check");
			userIdCheckLocation.html('아이디 중복 체크를 해주세요').css('color', 'red');
            isValid = false;
        }
		
		// 비밀번호 유효성 검사
        var userPwd = $("input[name='pwd']").val();
        var pwdChk = $("input[name='pwd_chk']").val();
        var userPwdCheckLocation = $("#user_pwd_check");
        var pwdChkCheckLocation = $("#pwd_chk_check");
        var userPwdRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{4,}$/; // 최소 4자, 영문, 숫자, 특수문자 포함
        
        //console.log(userPwd);
        // 비밀번호 입력 확인 및 유효성 검사
        if (userPwd === "") {
            userPwdCheckLocation.text('비밀번호를 입력해주세요').css('color', 'red');
            isValid = false;
        } else if (!userPwdRegex.test(userPwd)) {	// userPwd 문자열이 정규 표현식에 맞지 않으면 true를 반환. 이 경우 조건에 맞지 않는다는 의미
            userPwdCheckLocation.text('비밀번호는 최소 4자, 영문, 숫자, 특수문자 포함해야 합니다.').css('color', 'red');
            isValid = false;
        } else {
            userPwdCheckLocation.text('').css('color', '');
        }
        
        // 비밀번호 확인 입력 확인 및 일치 검사
        if (pwdChk === "") {
            pwdChkCheckLocation.text('비밀번호 확인을 입력해주세요.').css('color', 'red');
            isValid = false;
        } else if (userPwd !== pwdChk) {
            pwdChkCheckLocation.text('비밀번호가 일치하지 않습니다.').css('color', 'red');
            isValid = false;
        } else {
            pwdChkCheckLocation.text('').css('color', '');
        }
		
		// 다른 필드에 대한 유효성 검사
		$("input[name='name'], input[name='tel']").each(function() {
			var fieldName = $(this).attr('name');
			var checkLocation = $("#" + fieldName + "_check");
			var fieldLabel = $(this).attr("placeholder");
			
			if ($(this).val() === "") {
				checkLocation.text(fieldLabel + '을(를) 입력해주세요').css('color','red');
				isValid = false;
			} else {
				checkLocation.text('').css('color','');
			}
		});
		
		// 이메일 유효성 검사
		var userEmail = $("input[name='user_email']").val();
		var emailDomain = $("input[name='email_domain']").val();
		var emailCheckLocation = $("#user_email_check");
		
		if (userEmail === "" || emailDomain === "") {
			emailCheckLocation.text('이메일을 입력해주세요').css('color','red');
			isValid = false;
		} else {
			emailCheckLocation.text('').css('color','red');
		}
		
		// 주소 유효성 검사
		var zipCode = document.getElementById("zipcode_display").value;
		var addrStart = $("input[name='addr_start']").val();
		var addrEnd = $("input[name='addr_end']").val();
		var addrCheck = $("#user_addr_check");
		
		if (zipCode === "" || addrStart === "" || addrEnd === "") {
			addrCheck.text('주소를 입력해주세요').css('color', 'red');
			isValid = false;
		} else {
			addrCheck.text('').css('color', '');
		}
		
		return isValid;
	}
	
	// 이메일 도메인 선택 시
	$("#email_select").change(function() {
		email_change();
	});
	
	function email_change() {
		var emailSelect = document.getElementById("email_select");
		var emailDomain = document.getElementById("email_domain");
		
		if (emailSelect.value === "0") {
			emailDomain.disabled = true;
			emailDomain.value = "";
		} else if (emailSelect.value === "9") {
			emailDomain.disabled = false;
			emailDomain.value = "";
			emailDomain.focus();
		} else {
			emailDomain.disabled = true;
			emailDomain.value = emailSelect.value;
		}
	}
	
	// 이메일 조합 ==================================================================
	function combineEmail() {
		var userEmail = $("#user_email").val();
		var emailDomain = $("#email_domain").val();
		var fullEmail = userEmail + "@" + emailDomain;
		$("#full_email").val(fullEmail);
	}
	
	// 주소 조합 ==================================================================
	function combineAddress() {
		var addrStart = $("#addr_start").val();
		var addrEnd = $("#addr_end").val();
		var fullAddr = addrStart + " " + addrEnd;
		$("#full_addr").val(fullAddr);
	}
	
	// 폼 제출 ==================================================================
	function submitForm() {
		$("#registerForm").submit();	
	}
});

// 주소 불러오기 daum api
function daum_AddressAPI() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = '';
            if (data.userSelectedType === 'R') {
                addr = data.roadAddress;
            } else {
                addr = data.jibunAddress;
            }
            document.getElementById('zipcode_display').value = data.zonecode;
            document.getElementById("addr_start").value = addr;
            document.getElementById("addr_end").focus();
            document.getElementById("user_zipcode").value = data.zonecode; // 우편번호 설정
        }
    }).open();
}	

// ===================================================================================
	
// 로그인 ======================================
$(document).ready(function() {
    //console.log("문서 준비 완료");
    
    $("#btnLogin").click(function() {
        funcLogin();
    	//console.log("버튼 눌림");
    });
    
    // 로그인 유효성 검사 및 Ajax 요청
    function funcLogin() {
        var loginId = $("input[name='id']").val();
        var loginPwd = $("input[name='pwd']").val();
        var loginIdCheckLocation = $("#login_id_check");
        var loginPwdCheckLocation = $("#login_pwd_check");
        
        //console.log("로그인 ID: " + loginId);
		//console.log("로그인 비밀번호: " + loginPwd);
        
        // 아이디 및 비밀번호 유효성 검사
        if (loginId === "") {
            loginIdCheckLocation.text('아이디를 입력해주세요').css('color', 'red');
            $("input[name='id']").focus();
            return false;
        } else {
            loginIdCheckLocation.text('').css('color', '');
        }
        
        if (loginPwd === "") {
            loginPwdCheckLocation.text('비밀번호를 입력해주세요').css('color', 'red');
            $("input[name='pwd']").focus();
            return false;
        } else {
            loginPwdCheckLocation.text('').css('color', '');
        }

        $.ajax({
            url: "loginProc.jsp",
            method: "POST",
            data: {user_id: loginId, user_pwd: loginPwd},
            // url에서 반환한 응답을 response 변수로 받음
            success: function(response) {
                if (response.trim() === "invalid_id") {
                    loginIdCheckLocation.text('존재하지 않는 아이디입니다.').css('color', 'red');
                } else if (response.trim() === "invalid_pwd") {
                    loginPwdCheckLocation.text('비밀번호가 틀렸습니다.').css('color', 'red');
                }else if (response.trim() === "none") {
                    loginPwdCheckLocation.text('탈퇴한 아이디입니다.').css('color', 'red');
                } else if (response.trim() === "success") {
                    // 로그인 성공 시 페이지 리디렉션 처리
                    window.location.href = "../main/main.jsp";
                 
                } else {
                    alert("서버에서 예상치 못한 응답이 반환되었습니다."); // 서버에서 반환한 응답이 예상과 다를 경우
                }
            },
            error: function(xhr, status, error) {
                console.error("AJAX 오류: " + status + " - " + error); // AJAX 오류 메시지 출력
                alert("서버와의 통신 중 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
        return true;
    }
});


// ===================================================================

// userInfoForm.jsp --------------------------------------------------------
$(document).ready(function() {
    $("#btnUpdate").click(function() {
        if (validateUpdateForm()) {
            if (combineAddress()) {
                submitForm(); // 폼 제출 함수 호출
            }
        }
    });
});

function validateUpdateForm() {
    var isValid = true;

    // 비밀번호 유효성 검사
    var userPwd = $("input[name='pwd']").val();
    var pwdChk = $("input[name='pwd_chk']").val();
    var userPwdCheckLocation = $("#user_pwd_check");
    var pwdChkCheckLocation = $("#pwd_chk_check");
    var userPwdRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{4,}$/; // 최소 4자, 영문, 숫자, 특수문자 포함

    if (userPwd === "") {
        userPwdCheckLocation.text('비밀번호를 입력해주세요').css('color', 'red');
        isValid = false;
    } else if (!userPwdRegex.test(userPwd)) {
        userPwdCheckLocation.text('비밀번호는 최소 4자, 영문, 숫자, 특수문자 포함해야 합니다.').css('color', 'red');
        isValid = false;
    } else {
        userPwdCheckLocation.text('').css('color', '');
    }

    if (pwdChk === "") {
        pwdChkCheckLocation.text('비밀번호 확인을 입력해주세요.').css('color', 'red');
        isValid = false;
    } else if (userPwd !== pwdChk) {
        pwdChkCheckLocation.text('비밀번호가 일치하지 않습니다.').css('color', 'red');
        isValid = false;
    } else {
        pwdChkCheckLocation.text('').css('color', '');
    }

    return isValid;
}

function combineAddress() {
    var zipCode = $("#zipcode_display").val();
    var addrStart = $("#addr_start").val();
    var addrEnd = $("#addr_end").val();

    if (addrStart === "" || addrEnd === "") {
        // 주소 필드가 모두 비어 있는 경우
        $("#full_addr").val($("#current_addr").val()); // 기존 주소 사용
        $("#user_zipcode").val($("#zipcode_display").val()); // 기존 우편번호 사용
        return $("#current_addr").val(); // 기존 주소 반환
    } else {
        $("#full_addr").val(addrStart + ' ' + addrEnd);    // 새로운 주소 설정
        $("#user_zipcode").val(zipCode);    // 새로운 우편번호 설정
        return $("#full_addr").val(); // 새로운 주소 반환
    }
}

function submitForm() {
    // 폼 제출
    $("#updateForm").submit();   // 폼 ID를 이용한 제출
}

function userUpdateCancel(){
	location.href="main.jsp";
}
function userDelete(){
	location.href="deleteForm.jsp";
}


// deleteForm.jsp ==========================================
function btnDelCancel() { 
    location.href = "userInfoForm.jsp";
}

function btnDelete() {
    var userId = $("#user_id").val();
    var userPwd = $("input[name='user_pwd']").val();
    var userPwdCheckLocation = $("#delete_check");

    console.log(userId);
    console.log(userPwd);

    if (userPwd === "") {
        userPwdCheckLocation.html('비밀번호를 입력해주세요').css('color', 'red');
        $("input[name='user_pwd']").focus();
        return;
    }

    // 아이디 중복 체크 AJAX 요청
    $.ajax({
        url: "deleteProc.jsp",  // 중복 체크를 수행할 파일
        method: "POST",
        data: { user_id: userId, user_pwd: userPwd },
        dataType: "json",
        success: function(response) {
            console.log("Ajax response: ", response);
            if (response.result === "success") {
                location.href = "deleteSuccess.jsp";
            } else if (response.result === "invalid") {
                userPwdCheckLocation.html('비밀번호를 확인해주세요').css('color', 'blue');
            }
        }
    });
    return true;  // 함수 실행이 정상적으로 완료되었음을 true로 반환
}

$(document).ready(function() {
    // 삭제 버튼 클릭 시 btnDelete 메소드 실행
    $("#btnDelete").click(function() {
        btnDelete();
    });
});

//카트 처리용
function cartUpdate(form){
	form.flag.value = "update";
	form.submit();
}

function cartDelete(form){
	
	form.flag.value = "del";
	form.submit();
}

//Question 부분
function check(){
	if(qfrm.user.value==""){
		alert("이름 쓰세요");
		qfrm.user.focus();
	}else if(qfrm.title.value ==""){
		alert("제목 쓰세요");
		qfrm.title.focus();
	}else if(qfrm.pic.value ==""){
		alert("사진 올리세요");
		qfrm.pic.focus();
	}else if(qfrm.contents.value ==""){
		alert("내용 쓰세요");
		qfrm.contents.focus();
	}else
		qfrm.submit();
}

function noticeget(num) {
	document.noticeForm.num.value = num;
	document.noticeForm.submit();
}

//관리자에서 상품처리
function productDetail(ss){
	//alert(ss);
	document.detailForm.str.value = ss;
	document.detailForm.submit();
	
}
function productUpdate(name){
	if(confirm("정말 수정할까요?")){
		document.updateForm.name.value = name;
		document.updateForm.submit();
	}
}
function productDelete(name){
	if(confirm("정말 삭제할까요?")){
		document.delForm.name.value = name;
		document.delForm.submit();		
	}
}

//사용자에서 상품 처리

function productDetail_guest(pname){ 
	document.detailFrm.no.value = pname;
	document.detailFrm.submit();
}
