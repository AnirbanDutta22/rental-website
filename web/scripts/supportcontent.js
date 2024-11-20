document.addEventListener("DOMContentLoaded", () => {
                    var faqs = [
                    { question: "How do I register for an account?", answer: "To register, click on the 'Sign Up' button at the top of the homepage, fill out your details, and follow the prompts. A confirmation email will be sent to verify your account." },
                    { question: "How can I list an item for rent?", answer: "Once registered, log in and go to the 'Post an Item' section. Fill in details such as item category, rental price, and availability, then submit it. Our team will review and publish it for users to view." },
                    { question: "What categories of items are available for rent?", answer: "We offer a variety of categories, including electronics, furniture, vehicles, clothing, and more. Use the search or browse feature to find items by category or specific type." },
                    { question: "How do I contact a renter about an item?", answer: "On each item page, there’s a 'Contact Owner' button. Click it to send a message or inquiry directly to the item owner to discuss availability, rates, and other details." },
                    { question: "Are there any fees for renting or listing items?", answer: "Creating an account and listing items is free, but we may charge a small service fee for transactions to help maintain the platform. Check our fee policy for more details." },
                    { question: "What payment methods are accepted?", answer: "We accept a variety of payment methods, including credit/debit cards, online banking, and digital wallets. All payments are securely processed through our payment partner." },
                    { question: "Can I modify or cancel my rental reservation?", answer: "Yes, you can modify or cancel your reservation within the rental agreement's terms. Check with the item owner for specific policies on cancellations and refunds." },
                    { question: "What happens if an item gets damaged during the rental period?", answer: "Our platform requires users to agree to terms before renting. Any damages are typically the renter’s responsibility, and compensation will be arranged between the renter and owner." },
                    { question: "How is the rental duration calculated, and what happens if I return an item late?", answer: "Rental duration is calculated from the pickup time until the return time agreed upon in the contract. Late returns may incur additional charges as per the owner's terms." },
                    { question: "What if I have an issue with an item I rented or a renter?", answer: "If there’s an issue, please contact our support team through the 'Help' section. We’re here to help resolve disputes and ensure a safe, smooth experience for both parties." }
                    ];
                    var faqContainer = document.getElementById("faq-container");
                    
                    faqs.forEach(function(faq){
                    var faqHTML = `<div class="mb-10">
                            <h3 class="flex items-center mb-4 text-lg font-medium text-gray-900 dark:text-white">
                            <svg class="flex-shrink-0 mr-2 w-5 h-5 text-gray-500 dark:text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-8-3a1 1 0 00-.867.5 1 1 0 11-1.731-1A3 3 0 0113 8a3.001 3.001 0 01-2 2.83V11a1 1 0 11-2 0v-1a1 1 0 011-1 1 1 0 100-2zm0 8a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd"></path>
                            </svg>
                    ${faq.question}
                            </h3>
                            <p class="text-gray-500 dark:text-gray-400">${faq.answer}</p>
                            </div>`;
                            // Injecting the HTML structure into the FAQ container
                    faqContainer.innerHTML += faqHTML;
                    });
            });