<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- Submit Button --%>
<%
    if (ua.equals("mobile")) {
%>
<button class="question-submit btn-small waves-effect waves-light deep-orange darken-2" type="submit" form="form">
    Submit <i class="material-icons right">send</i>
</button>
<%
} else {
%>
<button class="question-submit btn-small waves-effect waves-light deep-orange darken-2 tooltipped" type="submit"
        form="form"
        data-position="bottom"
        data-tooltip="ALT or ⌘ + ENTER
    ">
    Submit <i class="material-icons right">send</i>
</button>
<%
    }
%>

<%-- Solution Button --%>
<a class="solution-trigger waves-effect waves-light btn-small modal-trigger deep-orange darken-4"
   href="#sql-solution">정답</a>
