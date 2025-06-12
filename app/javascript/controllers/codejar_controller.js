import {Controller} from "@hotwired/stimulus"
import {CodeJar} from 'codejar';
import {hljs} from 'highlight.js';

export default class extends Controller{

  static targets=["text"]

  initialize(){
    
  }

  connect(){
    const highlight = (editor) => {
      const value = hljs.highlight(editor.textContent, {language: 'json'}).value;
      editor.innerHTML = value;
    };
    const jar = CodeJar(this.textTarget, highlight);
    highlight(this.textTarget);
    // This is to change the theme of the code box
    // basically we will remove the css of the not selected theme
    // and add the one that is selected
    const themeLink = window.localStorage.getItem('dark-theme-link');
    if (themeLink != null){
      return;
    }
    const lightThemeLink = document.querySelector('link[href*="highlight-theme-default"]');
    const darkThemeLink = document.querySelector('link[href*="highlight-theme-dark"]');
    window.localStorage.setItem('dark-theme-link', darkThemeLink.getAttribute('href'));
    window.localStorage.setItem('light-theme-link', lightThemeLink.getAttribute('href'));
    const theme = (() => {
      if (typeof localStorage !== 'undefined' && localStorage.getItem('theme')) {
        return localStorage.getItem('theme');
      }
      return 'light';
    })();
    if (theme === 'light') {
      darkThemeLink.remove();
    } else {
      lightThemeLink.remove()
    }
  }
}