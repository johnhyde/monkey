'''
setInterval(() => {
  const spans = document.querySelectorAll('section > div > div > div > span > span:first-child');
  spans.forEach((span) => {
    if (span.innerHTML !== '~') return;
    let c = span.parentElement.parentElement;
    if (c.children.length > 1) return;
    let patp = c.innerText;
    let b = document.createElement('a');
    b.innerHTML = "View in Astrolabe";
    b.className = 'button ml-4';
    b.href = 'web+urbitgraph://astrolabe/ship/' + patp;
    b.target = '_blank';
    b.style.backgroundColor = "navy";
    c.appendChild(b);
  });
}, 100);
'''