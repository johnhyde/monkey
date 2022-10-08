setInterval(() => {
  const spans = document.querySelectorAll('div > span[title^="~"][cursor="pointer"]');
  spans.forEach((span) => {
    let title = span.getAttribute('title');
    if (span.innerHTML.indexOf(title) === -1) {
      span.innerHTML = span.innerHTML + ' ' + title;
    }

    // console.log(span.innerHTML);
  });
}, 100);

let p = document.createElement('p');
p.innerHTML = "You are great";
p.style.position = 'absolute';
p.style.top = '0';
p.style.backgroundColor = "white";
document.body.appendChild(p);
