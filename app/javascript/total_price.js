window.addEventListener('load', () => {
  const priceInput = document.getElementById("price");
  const quantityInput = document.getElementById("quantity");
  
  
  priceInput.addEventListener("input", () => {
    const inputPrice = priceInput.value;
    console.log(inputPrice)
    const inputQuantity = quantityInput.value;
    console.log(inputQuantity)
    const addTaxDom = document.getElementById("total_price");
    const totalPrice = inputPrice * inputQuantity;
    console.log(totalPrice)
    addTaxDom.value = Math.floor(totalPrice);
  });

  quantityInput.addEventListener("input", () => {
    const inputPrice = priceInput.value;
    console.log(inputPrice)
    const inputQuantity = quantityInput.value;
    console.log(inputQuantity)
    const addTaxDom = document.getElementById("total_price");
    const totalPrice = inputPrice * inputQuantity;
    console.log(totalPrice)
    addTaxDom.value = Math.floor(totalPrice);
  });
});
