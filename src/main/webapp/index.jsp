<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>파일업로드</title>
</head>
<body>
    <form name="form0" action="file/upload" method="POST" enctype="multipart/form-data">
        <ul>
            <li>파일 하나 업로드 : <input id="file1" type="file" name="file" /></li>
            <li>여러 파일 업로드 : <input id="file2" type="file" name="multifile" multiple /></li>
            <li>파일을 선택하고 '전송'을 눌러 업로드하시거나, 탐색기에서 파일을 드래그앤드롭하여 업로드할 수 있습니다. 드래그앤드롭은 '전송'을 누르는 것이 아니라 드롭시점에 바로 업로드됩니다.</li>
        </ul>
        <input type="submit" value="전송"/>
    </form>
    <script type="text/javascript">
    var dropzone1 = document.getElementById('file1');
    var dropzone2 = document.getElementById('file2');
    setDnDhandler(dropzone1);
    setDnDhandler(dropzone2);
    
    function setDnDhandler(obj) {
        obj.addEventListener("dragover", function(event) {
            event.preventDefault();
        }, true);
        obj.addEventListener("drop", function(event) {
            event.preventDefault();
            var allTheFiles = event.dataTransfer.files;
            for (var i=0; i<allTheFiles.length; i++) {
                var element = document.createElement('div');
                element.id = 'f' + i;
                document.body.appendChild(element);
                sendFile(allTheFiles[i], element.id);
            }
        }, true);
    }
    function sendFile(file, fileId) {
        var xhr = new XMLHttpRequest();
        
        xhr.upload.addEventListener("progress", function(e) {
                if (e.lengthComputable) {
                    var percentage = Math.round((e.loaded * 100) / e.total);
                    document.getElementById(fileId).innerHTML = file.name + ' - ' + percentage + '%';
                }
            }, false);
        xhr.onreadystatechange = function() {  
            if (xhr.readyState == 4 && xhr.status == 200) {
                alert(xhr.responseText);
            }
        };
        xhr.upload.addEventListener("load", function(e){
                document.getElementById(fileId).innerHTML = file.name + ' - uploaded';
            }, false);
        xhr.open("POST", "file/upload");
        var fd = new FormData();
        fd.append("file", file);
        xhr.send(fd);
    }
    </script>
</body>
</html>