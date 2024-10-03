/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.addEventListener("load",function(){
                login_images = [
                    "../assets/images/3d/tv.png",
                    "../assets/images/3d/fur.png",
                    "../assets/images/3d/car.png",
                    "../assets/images/3d/selaimachine.png",
                    "../assets/images/3d/mobile.png"
                ];
                signup_images = [
                    "../assets/images/3d/tv.png",
                    "../assets/images/3d/fur.png",
                    "../assets/images/3d/car.png",
                    "../assets/images/3d/selaimachine.png",
                    "../assets/images/3d/mobile.png"
                ];
                
                var currentIndex = 0;
                var loginImg = document.getElementById("loginimg");
                var signupImg = document.getElementById("signupimg");
                var page = window.location.pathname === "/pages/login.jsp" ? "login" : "signup";

                setInterval(function(){
          
                    if (page === "login"){
                        loginImg.classList.add("opacity-0");
                    }else{
                        signupImg.classList.add("opacity-0");
                    }
                    
          
                    setTimeout(function(){
                    
                    if (page === "login"){
                        currentIndex = (currentIndex + 1) % login_images.length;
                        loginImg.src = login_images[currentIndex];

                    
                        loginImg.classList.remove("opacity-0");
                    } else{
                        currentIndex = (currentIndex + 1) % signup_images.length;
                        signupImg.src = signup_images[currentIndex];

                        signupImg.classList.remove("opacity-0");
                    }
                    }, 1000);
                }, 2000);
            });
