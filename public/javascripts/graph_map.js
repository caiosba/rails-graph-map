var mouseX = 0;
var mouseY = 0;
var svg = document.documentElement;
var svgNS = "http://www.w3.org/2000/svg";
var xlinkNS="http://www.w3.org/1999/xlink";

function worldMapOver(el) {
  var code = el.getAttribute('class').replace('land ','');
  el.setAttribute('fill-opacity','0.5');
  var color = el.getAttribute('fill');
  var country = el.getAttribute('country-name');
  var value = el.getAttribute('country-value');
  if (!value) value = "------"
  var box = document.createElementNS(svgNS, 'g');
  box.setAttribute('id','box-' + country);
  var span1 = document.createElementNS(svgNS, 'tspan');
  span1.setAttribute('x',mouseX + 5);
  span1.setAttribute('y',mouseY + 15);
  var span2 = document.createElementNS(svgNS, 'tspan');
  span2.setAttribute('x',mouseX + 5);
  span2.setAttribute('y',mouseY + 30);
  var text = document.createElementNS(svgNS, 'text');
  text.setAttribute('style','font-size: 13px; font-family: sans-serif; fill: #000000;');
  span1.appendChild(document.createTextNode(country));
  span2.appendChild(document.createTextNode(value));
  text.appendChild(span1);
  text.appendChild(span2);
  var rect = document.createElementNS(svgNS, 'rect');
  rect.setAttribute('fill',color);
  rect.setAttribute('fill-opacity','0.7');
  rect.setAttribute('x', mouseX);
  rect.setAttribute('y', mouseY);
  rect.setAttribute('rx', '6');
  rect.setAttribute('ry', '6');
  rect.setAttribute('stroke','#000000');
  rect.setAttribute('stroke-opacity','1');
  rect.setAttribute('stroke-width','2');
  rect.setAttribute('height','55');
  var img = document.createElementNS(svgNS, 'image');
  img.setAttributeNS(xlinkNS, 'href','/flags/' + code + '.png');
  img.setAttribute('x', mouseX + 6);
  img.setAttribute('y', mouseY + 30);
  img.setAttribute('width', '25');
  img.setAttribute('height', '25');
  box.appendChild(rect);
  box.appendChild(img);
  box.appendChild(text);
  svg.appendChild(box);
  var w = span1.getComputedTextLength() > span2.getComputedTextLength() ? span1.getComputedTextLength() : span2.getComputedTextLength();
  rect.setAttribute('width', w + 14);
}

function worldMapOut(el) {
  el.setAttribute('fill-opacity','1');
  var country = el.getAttribute('country-name');
  var box = document.getElementById('box-' + country);
  svg.removeChild(box);
}

function getMouseXY(e) {
  mouseX = e.pageX;
  mouseY = e.pageY;
}

window.onload = function() {
  document.onmousemove = getMouseXY;
}
