/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.addEventListener("load", function(){
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
        var page = window.location.pathname === '/pages/login.jsp' ? "login" : "signup";
//                console.log(window.location.pathname);
        console.log(page);
        setInterval(function(){

        var loginImg, signupImg;
                if (page === 'login'){
        loginImg = document.getElementById("loginimg");
                loginImg.classList.add("opacity-0");
        } else if (page === 'signup'){
        signupImg = document.getElementById("signupimg");
                signupImg.classList.add("opacity-0");
        }


        setTimeout(function(){

        if (page === "login" && loginImg){
        currentIndex = (currentIndex + 1) % login_images.length;
                loginImg.src = login_images[currentIndex];
                loginImg.classList.remove("opacity-0");
        } else if (page === "signup" && signupImg){
        currentIndex = (currentIndex + 1) % signup_images.length;
                signupImg.src = signup_images[currentIndex];
                signupImg.classList.remove("opacity-0");
        }
        }, 1000);
        }, 2000);
        
        // Select all OTP input fields
        const otpInputs = document.querySelectorAll('input[type="text"]');
        otpInputs.forEach((input, index) = > {
        input.addEventListener('input', () = > {
        // Move to the next input if a digit is entered
        if (input.value.length === 1 && index < otpInputs.length - 1) {
        otpInputs[index + 1].focus();
        }
        });
                input.addEventListener('keydown', (event) = > {
                // If backspace is pressed on an empty input, move to the previous input
                if (event.key === 'Backspace' && input.value === '' && index > 0) {
                otpInputs[index - 1].focus();
                }
                });
                // Optional: restrict input to only digits
                input.addEventListener('input', (event) = > {
                input.value = input.value.replace(/[^0-9]/g, ''); // Allow only numeric input
                });
        });
});
        