<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>콘서트 일정 수정</title>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f4f4f4; }
        .form-container { width: 700px; margin: 20px auto; padding: 30px; border: 1px solid #ddd; border-radius: 8px; background-color: #fff; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { text-align: center; color: #333; margin-bottom: 30px;}
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; margin-bottom: 6px; font-weight: bold; color: #555; }
        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group input[type="date"],
        .form-group input[type="datetime-local"],
        .form-group select,
        .form-group textarea {
            width: calc(100% - 20px); 
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 1em;
        }
        .form-group textarea { resize: vertical; min-height: 120px; }
        .form-group input[type="radio"] { margin-right: 5px; }
        .form-group label.radio-label { font-weight: normal; margin-right: 15px; display: inline-block;}
        .form-actions { margin-top: 30px; padding-top: 20px; border-top: 1px solid #eee; text-align: right; }
        .form-actions input[type="submit"], .form-actions a {
            padding: 10px 20px;
            margin-left: 10px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 1em;
            border: none;
            cursor: pointer;
        }
        .form-actions input[type="submit"] { background-color: #007bff; color: white; }
        .form-actions input[type="submit"]:hover { background-color: #0056b3; }
        .form-actions a { background-color: #6c757d; color: white; display: inline-block; }
        .form-actions a:hover { background-color: #5a6268; }
        .message { padding: 15px; margin-bottom: 20px; border-radius: 5px; text-align: center; }
        .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .attachment-list { list-style-type: none; padding-left: 0; margin-top: 5px; }
        .attachment-list li { margin-bottom: 8px; display: flex; align-items: center; font-size: 0.9em; }
        .attachment-list img.file-preview-small { /* 추가: 수정폼용 작은 미리보기 */
            max-width: 80px;
            max-height: 80px;
            object-fit: contain;
            border: 1px solid #ddd;
            margin-right: 8px;
            border-radius: 3px;
        }
        .attachment-list input[type="checkbox"] { margin-right: 5px; }
        .attachment-list label { font-weight: normal; }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>콘서트 일정 수정 (번호: ${concertVO.concertNo})</h1>

        <c:if test="${not empty errorMessage}">
            <div class="message error">${errorMessage}</div>
        </c:if>
        <c:if test="${not empty successMessage}"> <%-- For redirects --%>
            <div class="message success">${successMessage}</div>
        </c:if>

        <form method="post" action="<c:url value='/concert/schedule/mod/${concertVO.concertNo}'/>" enctype="multipart/form-data">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="form-group">
                <label for="concertNm">콘서트명:</label>
                <input type="text" id="concertNm" name="concertNm" value="<c:out value='${concertVO.concertNm}'/>" required>
            </div>
            <div class="form-group">
                <label for="artGroupNo">아티스트 그룹 번호:</label>
                <input type="number" id="artGroupNo" name="artGroupNo" value="${concertVO.artGroupNo}" required>
            </div>
            <div class="form-group">
                <label for="concertHallNo">공연장 번호:</label>
                <input type="number" id="concertHallNo" name="concertHallNo" value="${concertVO.concertHallNo}" required>
            </div>
            <div class="form-group">
                <label for="concertCatCode">콘서트 카테고리 코드:</label>
                <input type="text" id="concertCatCode" name="concertCatCode" value="<c:out value='${concertVO.concertCatCode}'/>" required>
            </div>
            <div class="form-group">
                <label for="concertReservationStatCode">예매 상태 코드:</label>
                <input type="text" id="concertReservationStatCode" name="concertReservationStatCode" value="<c:out value='${concertVO.concertReservationStatCode}'/>" required>
            </div>
            <div class="form-group">
                <label for="concertStatCode">콘서트 상태 코드:</label>
                <input type="text" id="concertStatCode" name="concertStatCode" value="<c:out value='${concertVO.concertStatCode}'/>" required>
            </div>
            <div class="form-group">
                <label for="concertImg">콘서트 이미지 URL:</label>
                <input type="text" id="concertImg" name="concertImg" value="<c:out value='${concertVO.concertImg}'/>">
            </div>
            <div class="form-group">
                <label>온라인 콘서트 여부 (Y/N):</label>
                <input type="radio" id="onlineY_mod" name="concertOnlineYn" value="Y" ${concertVO.concertOnlineYn == 'Y' ? 'checked' : ''}> <label for="onlineY_mod" class="radio-label">Yes</label>
                <input type="radio" id="onlineN_mod" name="concertOnlineYn" value="N" ${concertVO.concertOnlineYn == 'N' ? 'checked' : ''}> <label for="onlineN_mod" class="radio-label">No</label>
            </div>
            <div class="form-group">
                <label for="concertDate">공연일 (YYYY-MM-DD):</label>
                <input type="date" id="concertDate" name="concertDate" value="<fmt:formatDate value='${concertVO.concertDate}' pattern='yyyy-MM-dd'/>" required>
            </div>
            <div class="form-group">
                <label for="concertAddress">콘서트 주소:</label>
                <input type="text" id="concertAddress" name="concertAddress" value="<c:out value='${concertVO.concertAddress}'/>" required>
            </div>
            <div class="form-group">
                <label for="concertStartDate">(예매/이벤트)시작일시:</label>
                <input type="datetime-local" id="concertStartDate" name="concertStartDate" value="<fmt:formatDate value='${concertVO.concertStartDate}' pattern="yyyy-MM-dd'T'HH:mm"/>" required>
            </div>
            <div class="form-group">
                <label for="concertEndDate">(예매/이벤트)종료일시:</label>
                <input type="datetime-local" id="concertEndDate" name="concertEndDate" value="<fmt:formatDate value='${concertVO.concertEndDate}' pattern="yyyy-MM-dd'T'HH:mm"/>" required>
            </div>
            <div class="form-group">
                <label for="concertRunningTime">진행 시간(분):</label>
                <input type="number" id="concertRunningTime" name="concertRunningTime" value="${concertVO.concertRunningTime}" required min="0">
            </div>
            <div class="form-group">
                <label for="concertGuide">콘서트 안내사항:</label>
                <textarea id="concertGuide" name="concertGuide" required><c:out value='${concertVO.concertGuide}'/></textarea>
            </div>
            
            <c:if test="${not empty concertVO.attachmentFileList}">
            <div class="form-group">
                <label>기존 첨부파일 :</label>
                <ul class="attachment-list">
                <c:forEach var="file" items="${concertVO.attachmentFileList}">
                    <li>
                        <input type="checkbox" name="deleteFileNos" value="${file.attachDetailNo}" id="delFile_${file.attachDetailNo}">
                        <c:choose>
                            <c:when test="${file.fileMimeType != null && file.fileMimeType.startsWith('image/')}">
                                <img src="<c:url value='${file.webPath}'/>" alt="<c:out value='${file.fileOriginalNm}'/>" class="file-preview-small"/>
                            </c:when>
                        </c:choose>
                        <label for="delFile_${file.attachDetailNo}">
                            <c:out value="${file.fileOriginalNm}"/> (<c:out value="${file.fileFancysize}"/>)
                        </label>
                    </li>
                </c:forEach>
                </ul>
            </div>
            </c:if>
            
            <div class="form-group">
            	<label for="concertFiles"> 새 첨부파일 : </label>
            	<input type="file" id="concertFiles" name="concertFiles" multiple="multiple" >
            </div>

            <div class="form-actions">
                <a href="<c:url value='/concert/schedule/list'/>">목록으로</a>
                <input type="submit" value="수정 완료">
            </div>
        </form>
    </div>
	<div id="footer">
        <!-- FOOTER -->
        <jsp:include page="/WEB-INF/views/modules/communityFooter.jsp" />
        <script src="${pageContext.request.contextPath}/resources/js/pages/communityFooter.js"></script>
        <!-- FOOTER END -->
    </div>
</body>
</html>