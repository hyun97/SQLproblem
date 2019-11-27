<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<li><a href="#contact" class="modal-trigger">Contact</a></li>

<div id="contact" class="modal add-edit-wrapper">
    <div class="modal-content blue-grey darken-4 black-text">
        <div class="white contact-wrapper">
            <div class="container">
                <h4>CONTACT</h4>
                <form action="../action/contactAction.jsp" method="post">
                    <p>TITLE</p>
                    <input type="text" name="contactTitle" placeholder="문의 제목을 입력하세요." required>
                    <p>CONTENT</p>
                    <textarea class="materialize-textarea" name="contactText" required></textarea>
                    <button class="btn waves-effect waves-light" type="submit">SEND</button>
                </form>
            </div>
        </div>
    </div>
</div>