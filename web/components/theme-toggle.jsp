<%-- 
    Document   : theme-toggle
    Created on : 28 Sep, 2024, 11:11:34 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! boolean theme_current = true; %>
<button id="theme-toggle" class="mr-5"><img src="../assets/images/moon.png" alt="switch_to_dark_mode" class="h-8"/></button>
<script>
    var theme_current = "<%= theme_current %>";
    document.addEventListener('DOMContentLoaded', function() {
      if (!localStorage.getItem('theme')) {
        localStorage.setItem('theme', 'light');
        theme_current = true;
      }

      if (localStorage.getItem('theme') === 'dark') {
        document.documentElement.classList.add('dark');
        theme_current = false;
      } else {
        document.documentElement.classList.remove('dark');
        theme_current = true;
      }

      updateButtonImage();

      document.getElementById('theme-toggle').addEventListener('click', function() {
        let theme = localStorage.getItem('theme');
        if (theme === 'light') {
          localStorage.setItem('theme', 'dark');
          document.documentElement.classList.add('dark');
          theme_current = false;
        } else {
          localStorage.setItem('theme', 'light');
          document.documentElement.classList.remove('dark');
          theme_current = true;
        }
        
        updateButtonImage();
      });
    });
    function updateButtonImage() {
            const imgElement = document.getElementById('theme-toggle').getElementsByTagName('img')[0];
            if (theme_current) {
                imgElement.src = "../assets/images/moon.png"; // Light mode image
                imgElement.alt = "Switch to Dark Mode";
            } else {
                imgElement.src = "../assets/images/sun.png"; // Dark mode image
                imgElement.alt = "Switch to Light Mode";
            }
        }
</script>



