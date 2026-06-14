# 기능 구현 계획서 20264139 정이안

| 항목 | 내용 |
|------|------|
| 과목 | 웹서버프로그래밍 |
| 학과 | 인공지능소프트웨어학과 |
| 교수 | 박규태 |
| 학번 | 20264139 |
| 이름 | 정이안 |

## 추가적인 기능

이번 프로젝트는 현재 운영 중인 쇼핑몰 홈페이지의 경쟁력을 강화하고 고객 경험을 개선하기 위해 추가 기능을 개발하는 것을 목표로 합니다. 최근 쇼핑몰 시장은 단순히 상품을 등록하고 판매하는 수준을 넘어, 고객 맞춤형 서비스와 편리한 구매 환경을 제공하는 방향으로 발전하고 있습니다. 이에 따라 당사 쇼핑몰 역시 고객의 구매 편의성을 높이고 매출 증대를 유도할 수 있는 기능을 추가적으로 구축하고자 합니다.

먼저 가장 우선적으로 검토한 기능은 **AI 기반 추천 시스템**입니다. 고객이 최근에 조회한 상품이나 구매 이력을 분석하여 관련 상품을 자동으로 추천하는 기능입니다. 이를 통해 고객은 자신이 관심 있는 상품을 더욱 쉽게 발견할 수 있으며, 쇼핑몰 입장에서는 객단가 상승과 구매 전환율 향상을 기대할 수 있습니다.

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<%!

class Product {
    int id;
    String name;
    String category;
    int price;

    public Product(int id, String name, String category, int price) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.price = price;
    }
}

%>

<%
    // 상품 데이터 (실제 서비스에서는 DB 조회)
    List<Product> products = new ArrayList<>();

    products.add(new Product(1,"게이밍 마우스","전자기기",45000));
    products.add(new Product(2,"기계식 키보드","전자기기",120000));
    products.add(new Product(3,"게이밍 헤드셋","전자기기",85000));
    products.add(new Product(4,"러닝화","운동",99000));
    products.add(new Product(5,"운동복","운동",55000));
    products.add(new Product(6,"덤벨","운동",70000));

    // 로그인 사용자 가정
    int userId = 1;

    // 구매 이력 가정
    List<Integer> purchaseHistory = Arrays.asList(1,2);

    // 카테고리 분석
    Map<String,Integer> categoryCount = new HashMap<>();

    for(Integer productId : purchaseHistory){

        for(Product p : products){

            if(p.id == productId){

                categoryCount.put(
                    p.category,
                    categoryCount.getOrDefault(p.category,0)+1
                );
            }
        }
    }

    String favoriteCategory = "";

    int max = 0;

    for(Map.Entry<String,Integer> entry : categoryCount.entrySet()){

        if(entry.getValue() > max){

            max = entry.getValue();
            favoriteCategory = entry.getKey();
        }
    }

    List<Product> recommendList = new ArrayList<>();

    for(Product p : products){

        if(p.category.equals(favoriteCategory)
                && !purchaseHistory.contains(p.id)){

            recommendList.add(p);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AI 상품 추천</title>

<style>
body{
    font-family: Arial;
}

.product{
    border:1px solid #ddd;
    padding:15px;
    margin:10px;
    width:250px;
    border-radius:10px;
}

.price{
    color:red;
    font-weight:bold;
}
</style>

</head>

<body>

<h2>🤖 AI 추천 상품</h2>

<%
if(recommendList.size()==0){
%>

추천 상품이 없습니다.

<%
}else{

    for(Product p : recommendList){
%>

<div class="product">
    <h3><%= p.name %></h3>
    <p>카테고리 : <%= p.category %></p>
    <p class="price">
        <%= String.format("%,d",p.price) %>원
    </p>
</div>

<%
    }
}
%>

</body>
</html>

두 번째는 **실시간 상담 기능**입니다. 고객이 상품 구매 과정에서 궁금한 사항이 있을 경우 즉시 문의할 수 있도록 채팅 상담 서비스를 구축할 계획입니다. 향후에는 AI 챗봇과 연계하여 반복적인 문의에 대한 자동 응답 기능도 제공할 수 있습니다.
<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 26. 6. 6.
  Time: 오전 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="UTF-8">
        <title>AI 상담</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
        }

        .chat-container {
            width: 600px;
            margin: 30px auto;
            background: white;
            border-radius: 10px;
            padding: 20px;
        }

        #chatBox {
            height: 500px;
            overflow-y: auto;
            border: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
        }

        .user {
            text-align: right;
            color: blue;
            margin: 10px;
        }

        .ai {
            text-align: left;
            color: green;
            margin: 10px;
        }

        .input-area {
            display: flex;
        }

        #message {
            flex: 1;
            padding: 10px;
        }

        button {
            width: 100px;
            background: #4CAF50;
            color: white;
            border: none;
        }
    </style>
</head>

<body>

<div class="chat-container">
    <h2>AI 상담센터</h2>

    <div id="chatBox"></div>

    <div class="input-area">
        <input type="text" id="message" placeholder="질문을 입력하세요">
        <button onclick="sendMessage()">전송</button>
    </div>
</div>

<script>

    async function sendMessage() {

        const input = document.getElementById("message");
        const msg = input.value.trim();

        if(msg === "") return;

        const chatBox = document.getElementById("chatBox");

        chatBox.innerHTML +=
            "<div class='user'>나 : " + msg + "</div>";

        input.value = "";

        try {

            const response = await fetch("/chat", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    message: msg
                })
            });

            const result = await response.text();

            chatBox.innerHTML +=
                "<div class='ai'>AI : " + result + "</div>";

            chatBox.scrollTop = chatBox.scrollHeight;

        } catch(e) {

            chatBox.innerHTML +=
                "<div class='ai'>서버 연결 실패</div>";
        }
    }

    document.getElementById("message")
        .addEventListener("keypress", function(e){
            if(e.key === "Enter"){
                sendMessage();
            }
        });

</script>

</body>
</html>
    </title>
</head>
<body>

</body>
</html>
