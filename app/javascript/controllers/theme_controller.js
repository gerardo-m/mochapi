import {Controller} from "@hotwired/stimulus"

export default class extends Controller{

  // static targets=["text"]

  connect(){
    const theme = (() => {
      if (typeof localStorage !== 'undefined' && localStorage.getItem('theme')) {
        return localStorage.getItem('theme');
      }
      if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
        return 'dark';
      }
        return 'light';
    })();
    let isDark = false;
    if (theme === 'light') {
      document.documentElement.classList.remove('dark');
    } else {
      document.documentElement.classList.add('dark');
      isDark = true;
    }
    window.localStorage.setItem('theme', theme);
    this.handleCssFiles(isDark);
  }

  toggleTheme(){
    const element = document.documentElement;
    element.classList.toggle("dark");

    const isDark = element.classList.contains("dark");
    localStorage.setItem("theme", isDark ? "dark" : "light");

    const highlightTheme = document.querySelector('link[href*="highlight-theme');
    if (highlightTheme != null){
      this.handleCssFiles(isDark);
    }
  }

  handleCssFiles(isDark){
    const link = document.createElement("link");
    link.rel = "stylesheet";
    let themeToRemove;
    if (isDark){
      link.href = window.localStorage.getItem("dark-theme-link");
      themeToRemove = document.querySelector('link[href*="highlight-theme-default');
    }else{
      link.href = window.localStorage.getItem("light-theme-link");
      themeToRemove = document.querySelector('link[href*="highlight-theme-default');
    }
    if (themeToRemove != null){
      themeToRemove.remove();
    }
    document.querySelector("head").append(link);
  }
}