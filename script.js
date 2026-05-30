const nav = document.querySelector(".main-nav");
const menuToggle = document.querySelector(".menu-toggle");
const toast = document.querySelector(".toast");
const characterRail = document.querySelector(".character-rail");
const prevButton = document.querySelector(".rail-button.prev");
const nextButton = document.querySelector(".rail-button.next");

let toastTimer;

function showToast(message) {
  toast.textContent = message;
  toast.classList.add("show");
  window.clearTimeout(toastTimer);
  toastTimer = window.setTimeout(() => {
    toast.classList.remove("show");
  }, 2200);
}

menuToggle?.addEventListener("click", () => {
  const isOpen = nav.classList.toggle("is-open");
  menuToggle.setAttribute("aria-expanded", String(isOpen));
});

document.querySelectorAll('a[href^="#"]').forEach((link) => {
  link.addEventListener("click", () => {
    nav.classList.remove("is-open");
    menuToggle?.setAttribute("aria-expanded", "false");
  });
});

document.querySelectorAll("[data-launch]").forEach((button) => {
  button.addEventListener("click", () => {
    showToast("Novel AI Studio is ready to launch.");
  });
});

document.querySelectorAll(".round-action").forEach((button) => {
  button.addEventListener("click", () => {
    const cardTitle = button.closest("article")?.querySelector("h3")?.textContent?.trim();
    showToast(`${cardTitle} selected.`);
  });
});

function scrollCharacters(direction) {
  if (!characterRail) return;
  const card = characterRail.querySelector(".character-card");
  const distance = card ? card.getBoundingClientRect().width + 16 : 172;
  characterRail.scrollBy({
    left: direction * distance * 2,
    behavior: "smooth",
  });
}

prevButton?.addEventListener("click", () => scrollCharacters(-1));
nextButton?.addEventListener("click", () => scrollCharacters(1));
