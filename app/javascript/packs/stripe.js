 import '@stripe/stripe-js';

 const button = document.getElementById("stripe")
 button.addEventListener("click", (e) => {
  if(document.getElementById("pickup").checked) {
    var id = document.getElementById("pickup").value * 1;
  }
  else if(document.getElementById("delivery").checked) {
    var id = document.getElementById("delivery").value * 1;
  }
   fetch(`/payments/session?delivery=${id}`)
   .then((res) => res.json())
   .then((data) => {
     const stripe = Stripe(data.stripe_public_key);
     stripe.redirectToCheckout({
       sessionId: data.id
     })
   })
 })
