const countButton = document.getElementById("count_button");
const countText = document.getElementById("count");

let count = 0;

countText.innerHTML = count;

countButton.addEventListener("click", () => {
  count += 1;
  countText.innerHTML = count;
});
