import { getPatches } from 'lib/api';

export default function patch(iframe, params: any = {}) {
  let script;
  function getDoc(iframe) {
    const iframeWin = iframe.contentWindow || iframe;
    const iframeDoc = iframe.contentDocument || iframeWin.document;
    return iframeDoc;
  }
  function newTitle(title) {
    iframe.dispatchEvent(new CustomEvent('titleChanged', { detail: title } as any));
  }
  function newIcons(head) {
    // let old
    console.log(head);
  }
  function watchTitle(doc) {
    const titleNode = doc.querySelector('title');
    newTitle(titleNode.text);
    // debugger; 
    new MutationObserver(function(mutations) {
      let title = mutations[0].target.text;
      newTitle(title);
    }).observe(
      titleNode,
      { subtree: true, characterData: true, childList: true }
    );
  }
  function watchIcons(doc) {
    const headNode = doc.querySelector('head');
    newIcons(headNode);
    // debugger; 
    new MutationObserver(function(mutations) {
      let head = mutations[0].target;
      newIcons(head);
    }).observe(
      headNode,
      { subtree: true, characterData: true, childList: true }
    );
  }
  async function loadPatches(app) {
    const iframeDoc = getDoc(iframe);
    // window.hm = iframeDoc;
    watchTitle(iframeDoc);
    watchIcons(iframeDoc);
    const patches = await getPatches(app);
    script = iframeDoc.createElement("script");
    script.id = 'monkeypatch-for-' + app;
    script.append(`
    let loadPatches = function() {
      ${patches.join('\n')}
    };
    if (document.readyState == 'complete') {
      loadPatches();
    } else {
      window.onload = loadPatches;
    }
    `);
    iframeDoc.documentElement.appendChild(script);
  };
  iframe.addEventListener('load', () => loadPatches(params.app));
  // loadPatches(params.app);

  return {
    update: (newParams) => {
      console.log('UPDATING');
      // const iframeDoc = getDoc(iframe);
      // debugger;
      // iframeDoc.documentElement.removeElement(script);
      // loadPatches(newParams.app);
    },

    destroy: () => {
    }
  };
};
