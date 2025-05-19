// import {CodeJar} from 'codejar';
// import {hljs} from 'highlight.js';

// function setupCodeJar(){
//   const highlight = (editor) => {
    
//     const value = hljs.highlight(editor.textContent, {language: 'json'}).value;
//     console.log("called agains", value)
//     editor.innerHTML = value;
//   };
//   const jar = CodeJar(document.querySelector('.editor'), highlight);
//   highlight(document.querySelector('.editor'));
// }

// function docReady(fn) {
//   if (document.readyState === "complete" || document.readyState === "interactive") {
//       setTimeout(fn, 1);
//   } else {
//       document.addEventListener("DOMContentLoaded", fn);
//   }
// }

// docReady(setupCodeJar);

// export { setupCodeJar}
