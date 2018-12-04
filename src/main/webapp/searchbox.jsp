<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style type="text/css">
        #mydiv{
            position: absolute;
            left:50%;
            top:50%;
            margin-left: -200px;
            margin-top:-50px;
        }
        .mouseOver{
            background:#708090;
            color: #FFFAFA;
        }
        .mouseOut{
            background: #FFFAFA;
            color:#708090 ;
        }

    </style>

    <script type="text/javascript">

        var xmlHttp;
        //获得用户输入内容的关联信息的函数
        function getMoreContents() {
            //首先获得用户的输入
            var content = document.getElementById("keyword");
            if (content.value == ""){
                clearContent(); //按回车键消失关联的字符
                return;
            }
            //然后给服务器发送用户输入的内容，因为采用ajax异步发送数据，所以我们要使用一个XmlHttp对象
            xmlHttp = createXMLHttp();
            //给服务器发送数据
            var url = "search?keyword=" + escape(content.value);  //escape解决中文问题
            //true表示JavaScript脚本会在send()方法之后执行，而不会等待来自服务器的响应
            xmlHttp.open("GET",url,true);
            //xmlHttp绑定一个回调方法,这个回调方法会在xmlhttp状态改变的时候被调用
            //xmlhttp的状态0-4，只关心4这个状态（complete）
            //当数据传输的过程完成之后，再调用回调方法才有意义
            xmlHttp.onreadystatechange = callback;
            xmlHttp.send(null);

        }
        //获得xmlhttp对象
        function createXMLHttp() {
            //对于大多数浏览器都适用
            var xmlHttp;
            if (window.XMLHttpRequest){
                xmlHttp = new XMLHttpRequest();
            }
            //要考虑浏览器的兼容性（因为采用的javascript，最原始的方法;而采用jquery会简单点）
            if (window.ActiveXObject){
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                if (!xmlHttp){
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                }
            }
            return xmlHttp;
        }
        //回调函数
        function callback() {
            //4代表完成
            if (xmlHttp.readyState == 4){
                //200代表服务器响应成功
                if (xmlHttp.status == 200){
                    //交互成功，获得相应的数据，是文本格式
                    var result =xmlHttp.responseText;
                    //解析获得数据
                    var json = eval("("+result+")");
                    //获得这些数据之后，就可以动态的显示这些数据了，把这些数据展示到输入框的下面
                    //alert(json);
                    setContent(json);
                }
            }
        }
        //设关联数据的展示
        function setContent(contents) {
            clearContent();
            //首先获得关联数据的长度，以此来确定生成多少<tr></tr>
            setLocation();
            var size = contents.length;
            //设置内容
            for (var i = 0; i < size; i ++){
                var nextNode = contents[i];//代表的是jason格式数据的第i个元素
                var tr = document.createElement("tr");
                var td = document.createElement("td");
                td.setAttribute("border","0");
                td.setAttribute("bgcolor","#FFFAFA");
                td.onmouseover = function () {
                    this.className = 'mouseOver';
                };
                td.onmouseout = function () {
                    this.className = 'mouseOut';
                };
                td.onclick = function () {
                    //当选择一个关联的数据是，关联数据自动设置为输入框的数据
                    alert("123");
                };
                var text = document.createTextNode(nextNode);
                td.appendChild(text);
                tr.appendChild(td);
                document.getElementById("content_table_body").appendChild(tr);
            }
        }
        
        //清空之前数据的方法

        function clearContent() {
         var contentTableBody = document.getElementById("content_table_body");
         var size = contentTableBody.childNodes.length;
         for (var i = size - 1;i >= 0;i--){
         contentTableBody.removeChild(contentTableBody.childNodes[i]);
         }
         document.getElementById("popDiv").style.border = "none";
         }


         //当输入框失去焦点的时候，鼠标在外面清空关联的字符
         function keywordBlur() {
         clearContent();
         }
        //设置显示关联信息的位置
        function setLocation() {
            //关联信息的显示位置要和输入框一致
            var content = document.getElementById("keyword");
            var width = content.offsetWidth; //输入框的宽度
            var left = content["offsetLeft"]; //距离左边框的距离
            var top = content["offsetTop"] + content.offsetHeight; // 到顶部的距离
            //获得显示数据的div
            var popDiv = document.getElementById("popDiv");
            popDiv.style.border = "black 1px solid";
            popDiv.style.left = left + "px";
            popDiv.style.top = top + "px";
            popDiv.style.width = width + "px";
            document.getElementById("content_Table").style.width = width + "px";

        }
    </script>
</head>
<body>
<div id="mydiv">
    <%--输入框--%>
    <input type="text" size="50" id="keyword" onkeyup="getMoreContents()"
           onblur="keywordBlur()" onfocus="getMoreContents()" />
    <input type="button" value="百度一下" width="50px"/>

    <%--内容展示区域--%>
    <div id="popDiv">
        <table id="content_Table" bgcolor="#FFFAFA" border="0" cellspacing="0"
               cellpadding="0">
            <%--动态查询出来的数据显示在这个地方--%>
            <tbody id="content_table_body">
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
