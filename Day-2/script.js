const loadButton = document.querySelector("#loadButton");
const statusText = document.querySelector("#status");
const postTitle = document.querySelector("#postTitle");
const postBody = document.querySelector("#postBody");



const apiUrl =
    `https://jsonplaceholder.typicode.com/posts/${postId}`;



    async function loadPost() {
    loadButton.disabled = true;
    statusText.textContent = "Sending GET request...";

    try {
        const response = await fetch(
            "https://jsonplaceholder.typicode.com/posts/1"
        );

        if (!response.ok) {
            throw new Error(`HTTP error: ${response.status}`);
        }

        const post = await response.json();

        postTitle.textContent = post.title;
        postBody.textContent = post.body;

        statusText.textContent = `Success! HTTP ${response.status}`;
    } catch (error) {
        statusText.textContent = `Request failed: ${error.message}`;
    } finally {
        loadButton.disabled = false;
    }
}

loadButton.addEventListener("click", loadPost);