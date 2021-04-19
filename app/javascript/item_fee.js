window.addEventListener('load', function(){

    const priceInput = document.getElementById("item-price");
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
  
    const addTax = document.getElementById("add-tax-price");
    addTax.innerHTML = (Math.floor(inputValue * 0.1));

    const profitNumber = document.getElementById("profit");
    const resultValue = (Math.floor(inputValue * 0.1));
    profitNumber.innerHTML = (Math.floor(inputValue - resultValue));
  })

})