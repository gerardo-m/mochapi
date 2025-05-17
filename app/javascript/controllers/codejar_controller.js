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
  }
}