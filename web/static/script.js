(async () => {
	let mainButton = document.getElementsByClassName("main-button")[0];
	mainButton.addEventListener("mousedown", async (e) => {
		// "mousedown" is more precisely triggered from UI than "click"
		await fetch("/click/register", {
			method: "POST",
			body: JSON.stringify({
				offsetX: e.offsetX,
				offsetY: e.offsetY
			})
		});
	});
})();
