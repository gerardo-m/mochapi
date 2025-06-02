import {Controller} from "@hotwired/stimulus"

export default class extends Controller{

  // static targets=["text"]

  connect(){
    console.log("Theme controller connected")
    const theme = (() => {
      if (typeof localStorage !== 'undefined' && localStorage.getItem('theme')) {
        return localStorage.getItem('theme');
      }
      if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
        return 'dark';
      }
        return 'light';
    })();

    if (theme === 'light') {
      document.documentElement.classList.remove('dark');
    } else {
      document.documentElement.classList.add('dark');
    }
    window.localStorage.setItem('theme', theme);
  }

  toggleTheme(){
    const element = document.documentElement;
    element.classList.toggle("dark");

    const isDark = element.classList.contains("dark");
    localStorage.setItem("theme", isDark ? "dark" : "light");
  }
}